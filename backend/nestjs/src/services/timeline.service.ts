import { Injectable } from '@nestjs/common';
import { classToPlain } from 'class-transformer';
import { auth } from 'firebase-admin';
import { FirebaseAdmin, InjectFirebaseAdmin } from 'nestjs-firebase';
import { COLLECTIONS } from '../constants/collections/collections';
import { STORAGE } from '../constants/storage/storage';
import { SearchResponse } from '../models/elasticsearch/elasticsearch.model';
import { ResulModel } from '../models/result.model';
import { PostModel } from '../models/timeline/post.model';
import { UserModel } from '../models/user/user.model';
import { ElasticSearchService } from './elasticsearch.service';
import { UserService } from './user.service';
import { UtilsService } from './utils.service';

@Injectable()
export class TimelineService {
  private fireAuth: auth.Auth;
  private firestore: FirebaseFirestore.Firestore;

  constructor(
    private esService: ElasticSearchService,
    private service: UtilsService,
    private userService: UserService,
    @InjectFirebaseAdmin() private readonly firebase: FirebaseAdmin,
  ) {
    // constructor
  }

  post(post: PostModel, userUid: string): Promise<any> {
    return new Promise(async (resolve, reject) => {
      try {

        if (!post.uid) {
          post.uid = this.service.uId();
        }

        if (!post.userUid) {
          post.userUid = userUid;
        }

        if (!post.commentarys) {
          post.commentarys = [];
        }

        if (!post.createdAt) {
          post.createdAt = new Date().toISOString();
        }

        if (post.pictures && post.pictures.length > 0) {
          const pictures = [];
          for (const item of post.pictures) {
            if (item.indexOf('https://') === 0) {
              pictures.push(this.service.getIdByUrl(item));
            } else {
              pictures.push(item);
            }
          }
          post.pictures = pictures;
        }

        await this.esService.esclient.index({
          index: COLLECTIONS.timeline,
          type: '_doc',
          id: post.uid,
          body: post
        });

        const postFire = classToPlain(post);
        postFire['createdAt'] = new Date(post.createdAt);

        await this.firestore
          .collection(COLLECTIONS.timeline)
          .doc(post.uid)
          .set(postFire);

        await this.esService.esclient.indices.refresh({
          index: COLLECTIONS.user
        });

        resolve({ success: true });
      } catch (error) {
        console.log(error);
        reject(error);
      }
    });
  }

  delete(uid: string): Promise<any> {
    return new Promise(async (resolve, reject) => {
      try {

        const body = {
          query: {
            bool: {
              must: [
                {
                  term: {
                    _id: uid
                  }
                }
              ]
            }
          }
        };

        await this.esService.esclient.deleteByQuery({
          index: COLLECTIONS.timeline,
          body
        });

        await this.firestore
          .collection(COLLECTIONS.timeline)
          .doc(uid)
          .delete();

        await this.esService.esclient.indices.refresh({
          index: COLLECTIONS.user
        });

        resolve({ success: true });
      } catch (error) {
        console.log(error);
        reject(error);
      }
    });
  }

  list(page: number): Promise<any> {
    return new Promise(async (resolve, reject) => {
      try {
        const size = 5;
        const body = {
          from: page * size,
          size,
          query: {
            bool: {
              must: [
              ]
            }
          },
          sort: {
            createdAt: {
              order: 'desc'
            }
          }
        }

        const response = await this.esService.esclient.search({
          index: COLLECTIONS.timeline,
          body
        });

        const result = response.body as SearchResponse<PostModel>;
        const resultPosts: ResulModel = {
          data: [],
          pageInfo: {
            totalRows: result.hits.total.value,
            totalPages: Math.ceil(result.hits.total.value / size)
          }
        }

        const usersToGetData = [];
        const imagesData = [];
        for (const item of result.hits.hits) {
          const post = item._source;
          if (post.userUid) {
            const index = usersToGetData.findIndex(u => u.uid === post.userUid);
            if (index === -1) {
              usersToGetData.push({ uid: post.userUid, data: null, pic: null });
            }

            if (post.pictures && post.pictures.length > 0) {
              for (const pic of post.pictures) {
                imagesData.push({ postUid: post.uid, picUid: pic, data: null });
              }
            }
          }
        }

        const blockPromise = [];
        for (const item of usersToGetData) {
          blockPromise.push(this.service.checkAndGetFireUrl(`${STORAGE.user}${item.uid}.jpg`));
        }

        for (const item of usersToGetData) {
          blockPromise.push(this.userService.me(item.uid));
        }

        for (const item of imagesData) {
          blockPromise.push(this.service.getFireUrl(`${STORAGE.timeline}${item.postUid}/${item.picUid}`));
        }

        const resultPromises = await Promise.all(blockPromise);


        for (let i = 0; i < usersToGetData.length; i++) {
          const element = usersToGetData[i];
          element.data = resultPromises[i + usersToGetData.length];
          element.pic = resultPromises[i];
        }

        // tslint:disable-next-line: prefer-for-of
        for (let i = 0; i < imagesData.length; i++) {
          const element = imagesData[i];
          element.data = resultPromises[i + (2 * usersToGetData.length)];
        }

        for (const item of result.hits.hits) {
          const post = item._source;
          if (post.userUid) {
            const user = usersToGetData.find(u => u.uid === post.userUid).data as UserModel;
            post.userName = user.name;
            const userPic = usersToGetData.find(u => u.uid === post.userUid).pic;
            post.userPicture = userPic ? userPic + `&debounce=${user.updatedPictureAt}` : null;
            if (!post.userPicture) {
              const arrayName = user.name.split(' ');
              let initial = arrayName[0].substr(0, 1);
              if (arrayName[1]) {
                initial += arrayName[1].substr(0, 1);
              }
              post.userPicture = initial.toUpperCase();
            }

            if (post.pictures && post.pictures.length > 0) {
              const pics = [];
              for (const pic of post.pictures) {
                const url = imagesData.find(i => i.postUid === post.uid && i.picUid === pic).data;
                pics.push(url);
              }

              post.pictures = pics;
            }
            resultPosts.data.push(post);
          }
        }

        resolve(resultPosts);
      } catch (error) {
        console.log(JSON.stringify(error));
        reject(error);
      }
    });
  }

  updateGalery(uid: string, galery: string[]): Promise<any> {
    return new Promise(async (resolve, reject) => {
      try {
        let pictures = '';
        if (galery.length > 0) {
          for (const item of galery) {
            if (item.indexOf('https://') === 0) {
              pictures += `'${this.service.getIdByUrl(item)}',`;
            }
          }
        }

        pictures = pictures.replace(/,\s*$/, "");

        const body = {
          query: {
            bool: {
              must: [
                {
                  term: {
                    'uid.keyword': uid
                  }
                }
              ]
            }
          },
          script: {
            lang: 'painless',
            source: `ctx._source.pictures = [${pictures}]`
          }
        }

        // console.log(JSON.stringify(body));

        await this.esService.esclient.updateByQuery({
          index: COLLECTIONS.timeline,
          body
        });

        await this.firestore
          .collection(COLLECTIONS.timeline)
          .doc(uid)
          .update({
            pictures: galery
          });

        await this.esService.esclient.indices.refresh({
          index: COLLECTIONS.timeline
        });

        resolve({ success: true });
      } catch (error) {
        console.log('ERRO DO UPDATE', error);
        reject(error);
      }
    });
  }
}
