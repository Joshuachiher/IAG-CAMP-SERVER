import { PartialType } from '@nestjs/mapped-types';
import { CreateFormSubmissionDto } from './create-form-submissions.dto';

export class UpdateFormSubmissionDto extends PartialType(CreateFormSubmissionDto) {}
