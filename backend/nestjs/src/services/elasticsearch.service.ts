import { Client } from '@elastic/elasticsearch';
import { Injectable } from '@nestjs/common';


@Injectable()
export class ElasticSearchService {
	esclient: Client;

	constructor() {
		this.esclient = new Client({
			node: process.env.ELASTIC_URL,
			requestTimeout: 60000,
			auth: {
				username: process.env.ELASTIC_USER,
				password: process.env.ELASTIC_PASSWORD,
			}
		});
	}
}
