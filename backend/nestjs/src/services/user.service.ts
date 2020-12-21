import { Injectable, UnauthorizedException } from '@nestjs/common';
import { classToPlain } from 'class-transformer';
import { auth } from 'firebase-admin';
import { FirebaseAdmin, InjectFirebaseAdmin } from 'nestjs-firebase';
import { COLLECTIONS } from '../constants/collections/collections';
import { STORAGE } from '../constants/storage/storage';
import { SearchResponse } from '../models/elasticsearch/elasticsearch.model';
import { UserModel } from '../models/user/user.model';
import { ElasticSearchService } from './elasticsearch.service';
import { bucket } from './gcs.service';
import { UtilsService } from './utils.service';

@Injectable()
export class UserService {
  private fireAuth: auth.Auth;
  private firestore: FirebaseFirestore.Firestore;

  constructor(
    private service: UtilsService,
    private esService: ElasticSearchService,
    @InjectFirebaseAdmin() private readonly firebase: FirebaseAdmin,
  ) {
    this.fireAuth = this.firebase.auth;
    this.firestore = this.firebase.db;
  }

  checkUser(email: string): Promise<any> {
    return new Promise(async (resolve, reject) => {
      try {

        const body = {
          query: {
            bool: {
              should: [
                {
                  term: {
                    "email.keyword": email
                  }
                }
              ]
            }
          }
        }

        const response = await this.esService.esclient.search({
          index: COLLECTIONS.user,
          body
        });

        const result = response.body as SearchResponse<UserModel>;

        if (result.hits.total.value > 0) {
          reject(new UnauthorizedException({ haveEmail: true }));
        } else {
          resolve(true);
        }
      } catch (error) {
        console.log(error);
        reject(error);
      }
    });
  }

  createUser(user: UserModel): Promise<any> {
    return new Promise(async (resolve, reject) => {
      try {
        await this.checkUser(user.email);

        if (!user.uid) {
          user.uid = this.service.uId();
        }

        const password = user.password;
        delete user.password;

        await this.fireAuth.createUser({
          uid: user.uid,
          email: user.email,
          password
        });

        await this.esService.esclient.index({
          index: COLLECTIONS.user,
          type: '_doc',
          id: user.uid,
          body: user
        });

        await this.firestore
          .collection(COLLECTIONS.user)
          .doc(user.uid)
          .set(classToPlain(user) as any);

        await this.esService.esclient.indices.refresh({
          index: COLLECTIONS.user
        });

        resolve({ uid: user.uid });
      } catch (err) {
        console.error('ERR CREATE USER', err);
        reject(err);
      }
    });
  }

  updateUser(user: UserModel): Promise<any> {
    return new Promise(async (resolve, reject) => {
      try {
        delete user.password;

        if (user.picture) {
          user.picture = user.uid + '.jpg';
        }

        await this.esService.esclient.index({
          index: COLLECTIONS.user,
          type: '_doc',
          id: user.uid,
          body: user
        });

        await this.firestore
          .collection(COLLECTIONS.user)
          .doc(user.uid)
          .set(classToPlain(user) as any);

        await this.esService.esclient.indices.refresh({
          index: COLLECTIONS.user
        });

        resolve({ success: true });
      } catch (error) {
        console.log('ERRO DO UPDATE', error);
        reject(error);
      }
    });
  }

  updateUserPicture(userUid: string, action: string): Promise<any> {
    return new Promise(async (resolve, reject) => {
      try {
        const body = {
          query: {
            bool: {
              must: [
                {
                  term: {
                    'uid.keyword': userUid
                  }
                }
              ]
            }
          },
          script: {
            lang: 'painless',
            source: `ctx._source.picture = ${action === 'clear' ? 'null' : "'" + userUid + ".jpg'"}; ctx._source.updatedPictureAt = '${new Date().valueOf().toString()}'`
          }
        }

        console.log(JSON.stringify(body));
        console.log('ACTION', action);

        await this.esService.esclient.updateByQuery({
          index: COLLECTIONS.user,
          body
        });

        const data = {};
        data['updatedPictureAt'] = new Date().toISOString();


        if (action === 'clear') {
          data['picture'] = null;

          const exist = await bucket.file(`${STORAGE.user}${userUid}.jpg`).exists();
          if (exist[0]) {
            await bucket.file(`${STORAGE.user}${userUid}.jpg`).delete();
          }
        }

        await this.firestore
          .collection(COLLECTIONS.user)
          .doc(userUid)
          .update(data);

        await this.esService.esclient.indices.refresh({
          index: COLLECTIONS.user
        });

        resolve({ success: true });
      } catch (error) {
        console.log('ERRO DO UPDATE', JSON.stringify(error));
        reject(error);
      }
    });
  }

  async createUserRecord(userRecord: auth.UserRecord) {
    const picture = await this.service.checkAndGetFireUrl(STORAGE.user + userRecord.uid + '.jpg');

    const user = new UserModel({
      email: userRecord.email,
      uid: userRecord.uid,
      name: userRecord.email.split('@')[0],
      picture: picture ? userRecord.uid + '.jpg' : null,
      updatedPictureAt: null
    });

    await this.esService.esclient.index({
      index: COLLECTIONS.user,
      type: '_doc',
      id: user.uid,
      body: user
    });

    await this.firestore
      .collection(COLLECTIONS.user)
      .doc(user.uid)
      .set(classToPlain(user) as any);

    await this.esService.esclient.indices.refresh({
      index: COLLECTIONS.user
    });

    return { user: user, picture: picture };
  }

  me(userUid: string) {
    return new Promise(async (resolve, reject) => {
      try {
        const body = {
          query: {
            bool: {
              must: [
                {
                  term: {
                    _id: userUid
                  }
                }
              ]
            }
          }
        }

        const response = await this.esService.esclient.search({
          index: COLLECTIONS.user,
          body
        });

        const result = response.body as SearchResponse<UserModel>;
        let userPicture = null;
        let user: UserModel = null;

        if (result.hits.total.value === 0) {
          const userAuth = await this.fireAuth.getUser(userUid);
          const resultCreate = await this.createUserRecord(userAuth);
          userPicture = resultCreate.picture;
          user = resultCreate.user;
        } else {
          user = result.hits.hits[0]._source;
        }

        if (user.picture && !userPicture) {
          user.picture = await this.service.getFireUrl(`${STORAGE.user}${user.picture}`);
          if (user.updatedPictureAt)
            user.picture = user.picture + '&decache=user.updatedPictureAt';
        } else {
          if (userPicture) {
            user.picture = userPicture;
          } else {
            const arrayName = user.name.split(' ');
            let initial = arrayName[0].substr(0, 1);
            if (arrayName[1]) {
              initial += arrayName[1].substr(0, 1);
            }
            user.picture = initial.toUpperCase();
          }
        }

        resolve(user);
      } catch (error) {
        console.log(error);
        reject(error);
      }
    });
  }

  async findOneByToken(idToken: string): Promise<auth.DecodedIdToken | null> {
    try {
      const decoded = await this.fireAuth.verifyIdToken(idToken);
      return decoded;
    } catch (error) {
      return null;
    }
  }
}
