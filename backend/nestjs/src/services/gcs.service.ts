import { Storage } from '@google-cloud/storage';
import config from '../config/config';


const gcs = new Storage({
    keyFilename: config.adminSDKFile
});

export const bucket = gcs.bucket(config.bucket);