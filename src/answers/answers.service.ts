import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../common/prisma.service';
import { CreateAnswerDto } from './dto/create-answer.dto';
import { UpdateAnswerDto } from './dto/update-answer.dto';

@Injectable()
export class AnswersService {
  constructor(private prisma: PrismaService) {}

  async create(data: CreateAnswerDto) {
    try {
      return await this.prisma.answer.create({ data });
    } catch (error) {
      throw new BadRequestException('Failed to create answer');
    }
  }

async findAll(page = 1, limit = 10, filterAnswerText?: string) {
  const skip = (page - 1) * limit;
const where = filterAnswerText
  ? {
      answerText: {
        contains: filterAnswerText,
        mode: 'insensitive' as 'insensitive', // pakai casting string literal
      },
    }
  : {};

    const [data, total] = await Promise.all([
      this.prisma.answer.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          question: true,
          user: true,
          formSubmission: true,
        },
      }),
      this.prisma.answer.count({ where }),
    ]);

    return {
      data,
      total,
      page,
      lastPage: Math.ceil(total / limit),
    };
  }

  async findOne(id: number) {
    const answer = await this.prisma.answer.findUnique({
      where: { id },
      include: {
        question: true,
        user: true,
        formSubmission: true,
      },
    });

    if (!answer) {
      throw new NotFoundException(`Answer with id ${id} not found`);
    }

    return answer;
  }

  async update(id: number, data: UpdateAnswerDto) {
    try {
      const existing = await this.prisma.answer.findUnique({ where: { id } });
      if (!existing) {
        throw new NotFoundException(`Answer with id ${id} not found`);
      }

      return await this.prisma.answer.update({
        where: { id },
        data,
      });
    } catch (error) {
      throw new BadRequestException('Failed to update answer');
    }
  }

  async remove(id: number) {
    try {
      const existing = await this.prisma.answer.findUnique({ where: { id } });
      if (!existing) {
        throw new NotFoundException(`Answer with id ${id} not found`);
      }
      return await this.prisma.answer.delete({ where: { id } });
    } catch (error) {
      throw new BadRequestException('Failed to delete answer');
    }
  }
  async removeAll(): Promise<{ deletedCount: number }> {
  const deleteResult = await this.prisma.answer.deleteMany({});
  return { deletedCount: deleteResult.count };
}
}







