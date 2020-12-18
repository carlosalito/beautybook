
export class UserModel {
	uid: string;
	name: string;
	email: string;
	picture: string;
	password: string;
	updatedPictureAt: string;

	constructor(
		{ uid, name, email, picture, updatedPictureAt }:
			{
				uid: string;
				name: string;
				email: string;
				picture: string;
				updatedPictureAt: string;
			},
	) {
		Object.assign(this, {
			uid, name, email, picture, updatedPictureAt
		});
	}
}