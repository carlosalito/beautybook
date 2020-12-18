import * as path from 'path';

const projectConfigPath = path.resolve(__dirname);

const SDKFile = 'firebase-adminsdk.json';

const config = {
  adminSDKFile: projectConfigPath + '/' + SDKFile,
  bucket: 'beautybook-38dd1.appspot.com'
}

export default config;
