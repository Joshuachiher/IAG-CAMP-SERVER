import { Body, Controller, Post, Get, Param, Query, ParseIntPipe, DefaultValuePipe, Delete } from '@nestjs/common';
import { FormSubmissionService } from './form-submissions.service';
import { CreateFormSubmissionDto } from './dto/create-form-submissions.dto';

@Controller('form-submissions')
export class FormSubmissionController {
  constructor(private readonly formSubmissionService: FormSubmissionService) {}

  @Post()
  create(@Body() createDto: CreateFormSubmissionDto) {
    return this.formSubmissionService.create(createDto.userId, createDto.answers);
  }

  @Get()
  findAll(
    @Query('page', new DefaultValuePipe(1), ParseIntPipe) page: number,
    @Query('limit', new DefaultValuePipe(10), ParseIntPipe) limit: number,
  ) {
    return this.formSubmissionService.findAll(page, limit);
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.formSubmissionService.findOne(id);
  }

  @Delete()
  removeAll() {
    return this.formSubmissionService.removeAll();
  }
}
