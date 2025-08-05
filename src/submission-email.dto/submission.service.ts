import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'src/common/prisma.service';
import { CreateSubmissionDto } from './dto/create-submission.dto';

@Injectable()
export class SubmissionService {
  constructor(private readonly prisma: PrismaService) {}

  async create(dto: CreateSubmissionDto) {
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email },
    });

    if (!user) {
      throw new NotFoundException(`User with email ${dto.email} not found`);
    }

    const submission = await this.prisma.formSubmission.create({
      data: {
        userId: user.id,
        answers: {
          create: dto.answers.map((answer) => ({
            questionId: answer.questionId,
            value: answer.value,
          })),
        },
      },
      include: {
        answers: true,
      },
    });

    return submission;
  }

  async findAll() {
    return this.prisma.formSubmission.findMany({
      include: {
        user: true,
        answers: true,
      },
    });
  }

  async findById(id: number) {
    const submission = await this.prisma.formSubmission.findUnique({
      where: { id },
      include: {
        user: true,
        answers: true,
      },
    });

if (!submission) {
      throw new NotFoundException(`Submission with id ${id} not found`);
    }

    return submission;
  }
}