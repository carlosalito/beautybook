import { Injectable } from '@nestjs/common';
import { bucket } from './gcs.service';

@Injectable()
export class UtilsService {
  // constructor() {}

  uId() {
    return (
      this.s4() +
      this.s4() +
      '-' +
      this.s4() +
      '-' +
      this.s4() +
      '-' +
      this.s4() +
      '-' +
      this.s4() +
      this.s4() +
      this.s4()
    );
  }

  s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
  }

  getFireUrl(path: string): Promise<string> {
    return new Promise(async (resolve, reject) => {
      try {
        const url = await bucket.file(path).getSignedUrl({
          action: 'read',
          expires: '03-09-2491'
        });

        resolve(url[0]);
      } catch (error) {
        console.log('erro get url', error);
        reject(error);
      }
    });
  }


  checkAndGetFireUrl(path: string): Promise<string> {
    return new Promise(async (resolve, reject) => {
      try {
        const exist = await bucket.file(path).exists();

        if (exist[0]) {
          const url = await bucket.file(path).getSignedUrl({
            action: 'read',
            expires: '03-09-2491'
          });

          resolve(url[0]);
        } else {
          resolve('');
        }
      } catch (error) {
        console.log('erro get url', error);
        reject(error);
      }
    });
  }

  getIdByUrl(url: string) {
    const start = "appspot.com/";
    const end = ".jpg";

    const startIndex = url.indexOf(start);
    const endIndex = url.indexOf(end);

    let result = url
      .substr(startIndex + start.length, endIndex - startIndex - start.length)
      .replace(/%2F/g, '/');

    if (result.indexOf('o/') === 0) {
      result = result.replace('o/', '');
    }

    const parts = result.split('/')

    return parts[parts.length - 1] + '.jpg';
  }
}
