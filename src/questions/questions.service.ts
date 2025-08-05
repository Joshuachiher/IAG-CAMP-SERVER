import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { PrismaService } from '../common/prisma.service';
import { CreateQuestionDto } from './dto/create-question.dto';
import { UpdateQuestionDto } from './dto/update-question.dto';
import { Prisma } from '@prisma/client';

@Injectable()
export class QuestionsService {
  constructor(private prisma: PrismaService) {}

async create(data: CreateQuestionDto) {
  try {
    return await this.prisma.question.create({
      data: {
        questionTextId: data.questionTextId,
        questionTextEn: data.questionTextEn,
        questionType: data.questionType,
        isRequired: data.isRequired,
        order: data.order ?? 0,
        categoryId: data.categoryId ?? null,
        key: data.key,
        placeholder: data.placeholder,
        description: data.description,
      },
    });
  } catch (error) {
    console.error("Prisma error:", error); // <-- Tambahkan ini untuk debug
    throw new BadRequestException(error.message || 'Failed to create question');
  }
}
  async findAll(
    page = 1,
    limit = 10,
    filterText?: string,
    lang: 'id' | 'en' = 'id',
  ) {
    const skip = (page - 1) * limit;

    // Dynamic filtering by language
    const conditions: Prisma.QuestionWhereInput[] = [];

    if (filterText) {
      if (lang === 'en') {
        conditions.push({
          questionTextEn: {
            contains: filterText,
            mode: 'insensitive',
          },
        });
      } else {
        conditions.push({
          questionTextId: {
            contains: filterText,
            mode: 'insensitive',
          },
        });
      }
    }

    const where: Prisma.QuestionWhereInput = filterText
      ? { OR: conditions }
      : {};

    const [data, total] = await Promise.all([
      this.prisma.question.findMany({
        where,
        skip,
        take: limit,
        orderBy: { order: 'asc' },
        include: { options: true, category: true },
      }),
      this.prisma.question.count({ where }),
    ]);

    return {
      data,
      total,
      page,
      lastPage: Math.ceil(total / limit),
    };
  }

  async findOne(id: number) {
    const question = await this.prisma.question.findUnique({
      where: { id },
      include: { options: true, category: true },
    });

    if (!question) {
      throw new NotFoundException(`Question with id ${id} not found`);
    }

    return question;
  }

  async update(id: number, data: UpdateQuestionDto) {
    const existing = await this.prisma.question.findUnique({
      where: { id },
    });

    if (!existing) {
      throw new NotFoundException(`Question with id ${id} not found`);
    }

    return this.prisma.question.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    const existing = await this.prisma.question.findUnique({
      where: { id },
    });

    if (!existing) {
      throw new NotFoundException(`Question with id ${id} not found`);
    }

    return this.prisma.question.delete({
      where: { id },
    });
  }
}
