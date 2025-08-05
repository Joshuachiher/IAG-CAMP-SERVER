import { Controller, Post, Body } from '@nestjs/common';
import { SubmissionService } from './submission.service';
import { CreateSubmissionDto } from './dto/create-submission.dto';
import { CheckUserExistsPipe } from '../common/filter/guards/pipes/check.user.exists.pipe';

@Controller('submissions')
export class SubmissionController {
  constructor(private readonly submissionService: SubmissionService) {}

  @Post()
  async createSubmission(
    @Body(CheckUserExistsPipe) dto: CreateSubmissionDto,
  ) {
    return this.submissionService.create(dto);
  }
}
