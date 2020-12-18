import { Module } from '@nestjs/common';
import { UserController } from '../controller/user.controller';
import { ElasticSearchService } from '../services/elasticsearch.service';
import { UserService } from '../services/user.service';
import { UtilsService } from '../services/utils.service';

@Module({
    imports: [],
    providers: [UserService, UtilsService, ElasticSearchService],
    controllers: [UserController]
})
export class UsersModule { }
