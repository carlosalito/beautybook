import { Module } from '@nestjs/common';
import { TimelineController } from '../controller/timeline.controller';
import { ElasticSearchService } from '../services/elasticsearch.service';
import { TimelineService } from '../services/timeline.service';
import { UserService } from '../services/user.service';
import { UtilsService } from '../services/utils.service';

@Module({
    imports: [],
    providers: [TimelineService, UtilsService, ElasticSearchService, UserService],
    controllers: [TimelineController]
})
export class TimelineModule { }
