import { Module } from '@nestjs/common';
import { PrismaModule } from '../common/prisma.module';
import { SubmissionService } from './submission-service';
import { SubmissionController } from './submission-controller';
@Module({
  imports: [PrismaModule],
  controllers: [SubmissionController],
  providers: [SubmissionService],
})
export class SubmissionModule {}
