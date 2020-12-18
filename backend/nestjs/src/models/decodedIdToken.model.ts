export class DecodedIdToken {
	iss: string = null;
	aud: string = null;
	auth_time: number = null;
	user_id: string = null;
	sub: string = null;
	iat: number = null;
	exp: number = null;
	email: string = null;
	email_verified: string = null;
	firebase: Firebase = null;
	uid: string = null;
}

export class Firebase {
	identities: Identities = null;
	sign_in_provider: string = null;
}

export class Identities {
	email: string[] = [];
}
