import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../common/prisma.service';
import { Prisma } from '@prisma/client';

export interface AnswerDto {
  questionId: number;
  answerText: string;
}

@Injectable()
export class FormSubmissionService {
  constructor(private prisma: PrismaService) {}

  async create(userId: number, answers: AnswerDto[]) {
    try {
      // cek user valid
      const user = await this.prisma.user.findUnique({ where: { id: userId } });
      if (!user) throw new NotFoundException(`User dengan id ${userId} tidak ditemukan`);

      // cek question valid
      const questionIds = answers.map((a) => a.questionId);
      const questions = await this.prisma.question.findMany({ where: { id: { in: questionIds } } });
      if (questions.length !== questionIds.length) {
        const foundIds = questions.map((q) => q.id);
        const invalidIds = questionIds.filter((id) => !foundIds.includes(id));
        throw new Error(`QuestionId tidak valid: ${invalidIds.join(", ")}`);
      }

      // buat form submission baru
      const formSubmission = await this.prisma.formSubmission.create({ data: { userId } });

      // simpan jawaban satu-satu (bukan createMany)
      const answersData = answers.map((answer) => ({
        userId,
        questionId: answer.questionId,
        answerText: answer.answerText,
        formSubmissionId: formSubmission.id,
      }));

      for (const answerData of answersData) {
        await this.prisma.answer.create({ data: answerData });
      }

      return {
        formSubmissionId: formSubmission.id,
        submittedAnswers: answersData.length,
      };
    } catch (error) {
      console.error('Error saat create form submission:', error);
      throw error;
    }
  }

  async findOne(id: number) {
    const formSubmission = await this.prisma.formSubmission.findUnique({
      where: { id },
      include: {
        user: true,
        answers: {
          include: { question: true },
        },
      },
    });

    if (!formSubmission) {
      throw new NotFoundException(`FormSubmission dengan id ${id} tidak ditemukan`);
    }

    return formSubmission;
  }

  async findAll(page = 1, limit = 10) {
    const skip = (page - 1) * limit;

    const [data, total] = await Promise.all([
      this.prisma.formSubmission.findMany({
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          user: true,
          answers: {
            include: { question: true },
          },
        },
      }),
      this.prisma.formSubmission.count(),
    ]);

    return {
      data,
      total,
      page,
      lastPage: Math.ceil(total / limit),
    };
  }

  // Method untuk menghapus semua submission
  async removeAll(): Promise<{ deletedCount: number }> {
    const deleteResult = await this.prisma.formSubmission.deleteMany({});
    return { deletedCount: deleteResult.count };
  }
}
