import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../common/prisma.service';
import { CreateQuestionOptionDto } from './dto/create-question-option.dto';
import { UpdateQuestionOptionDto } from './dto/update-question-option.dto';

@Injectable()
export class QuestionOptionsService {
  constructor(private prisma: PrismaService) {}

  async create(data: CreateQuestionOptionDto) {
    return this.prisma.questionOption.create({ data });
  }

  async findAll() {
    return this.prisma.questionOption.findMany({
      include: { question: true },
    });
  }

  async findOne(id: number) {
    const option = await this.prisma.questionOption.findUnique({
      where: { id },
      include: { question: true },
    });
    if (!option) {
      throw new NotFoundException(`QuestionOption with id ${id} not found`);
    }
    return option;
  }

  async update(id: number, data: UpdateQuestionOptionDto) {
    await this.findOne(id);
    return this.prisma.questionOption.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    await this.findOne(id);
    return this.prisma.questionOption.delete({
      where: { id },
    });
  }
}
