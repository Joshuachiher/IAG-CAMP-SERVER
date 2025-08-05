import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Patch,
  Delete,
  ParseIntPipe,
} from '@nestjs/common';
import { QuestionOptionsService } from './question-options.service';
import { CreateQuestionOptionDto } from './dto/create-question-option.dto';
import { UpdateQuestionOptionDto } from './dto/update-question-option.dto';

@Controller('question-options')
export class QuestionOptionsController {
  constructor(private readonly questionOptionsService: QuestionOptionsService) {}

  @Post()
  create(@Body() createDto: CreateQuestionOptionDto) {
    return this.questionOptionsService.create(createDto);
  }

  @Get()
  findAll() {
    return this.questionOptionsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.questionOptionsService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateDto: UpdateQuestionOptionDto,
  ) {
    return this.questionOptionsService.update(id, updateDto);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.questionOptionsService.remove(id);
  }
}
