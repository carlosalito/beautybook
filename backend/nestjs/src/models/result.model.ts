export class Result {
	constructor(
		public success: boolean,
		public message: string,
		public data: any,
		public error: any,
	) {

	}
}

export interface PageInfoModel {
	totalRows: number;
	totalPages: number;
}

export interface ResulModel {
	data: Array<any>;
	pageInfo: PageInfoModel;
}
