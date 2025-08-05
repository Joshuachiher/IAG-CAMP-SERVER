import { Module } from '@nestjs/common';
import { FormSubmissionService } from './form-submissions.service';
import { FormSubmissionController } from './form-submissions.controller';
import { PrismaModule } from '../common/prisma.module';

@Module({
  imports: [PrismaModule],
  controllers: [FormSubmissionController],
  providers: [FormSubmissionService],
})
export class FormSubmissionsModule {}
