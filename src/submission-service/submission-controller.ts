import { Controller, Post, Body } from '@nestjs/common';
import { SubmissionService } from './submission-service';

@Controller('submissions')
export class SubmissionController {
  constructor(private readonly submissionService: SubmissionService) {}

  @Post()
  submitForm(@Body() body: any) {
    return this.submissionService.submitFullForm(body);
  }
}
