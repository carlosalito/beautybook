export class ReactionModel {
  uid: string;
  userUid: string;
  updatedAt: string;

  constructor(
    { uid, userUid, updatedAt }:
      {
        uid: string;
        userUid: string;
        updatedAt: string;
      },
  ) {
    Object.assign(this, {
      uid, userUid, updatedAt
    });
  }
}

export class CommentaryModel {
  uid: string;
  userUid: string;
  updatedAt: string;
  commentary: string;

  constructor(
    { uid, userUid, updatedAt, commentary }:
      {
        uid: string;
        userUid: string;
        updatedAt: string;
        commentary: string;
      },
  ) {
    Object.assign(this, {
      uid, userUid, updatedAt, commentary
    });
  }
}

export class PostModel {
  uid: string;
  userUid: string;
  userPicture: string;
  userName: string;
  title: string;
  body: string;
  pictures: Array<string>;
  commentarys: Array<CommentaryModel>;
  createdAt: string;
  updatedAt: string;


  constructor(
    { uid, userUid, userPicture, userName, title, body, pictures, commentarys, createdAt, updatedAt }:
      {
        uid: string;
        userUid: string;
        userPicture: string;
        userName: string;
        title: string;
        body: string;
        pictures: Array<string>;
        commentarys: Array<CommentaryModel>;
        createdAt: string;
        updatedAt: string;
      },
  ) {
    Object.assign(this, {
      uid, userUid, userPicture, userName, title, body, pictures, commentarys, createdAt, updatedAt
    });
  }
}
