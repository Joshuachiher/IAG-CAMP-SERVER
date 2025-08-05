import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../common/prisma.service';
import { CreateUserDto } from 'src/users/dto/create-users.dto';
@Injectable()
export class SubmissionService {
  constructor(private prisma: PrismaService) {}

  async submitFullForm(data: {
    user: CreateUserDto;
    answers: { questionId: number; answerText: string }[];
    signature?: { imageUrl: string };
  }) {
    const { user, answers, signature } = data;

    return await this.prisma.$transaction(async (prisma) => {
      // Check if user email exists
      let dbUser = await prisma.user.findUnique({
        where: { email: user.email },
      });

      if (dbUser) {
        // Update user
        dbUser = await prisma.user.update({
          where: { id: dbUser.id },
          data: user,
        });
      } else {
        // Create user
        dbUser = await prisma.user.create({ data: user });
      }

      // Create answers with userId
      const createdAnswers = await Promise.all(
        answers.map((ans) =>
          prisma.answer.create({
            data: {
              userId: dbUser.id,
              questionId: ans.questionId,
              answerText: ans.answerText,
            },
          }),
        ),
      );

      // Create or update signature if provided
      if (signature) {
        const existingSig = await prisma.signature.findUnique({
          where: { userId: dbUser.id },
        });

        if (existingSig) {
          await prisma.signature.update({
            where: { id: existingSig.id },
            data: { imageUrl: signature.imageUrl },
          });
        } else {
          await prisma.signature.create({
            data: {
              userId: dbUser.id,
              imageUrl: signature.imageUrl,
            },
          });
        }
      }

      // Create form submission with answers relation
      const formSubmission = await prisma.formSubmission.create({
        data: {
          userId: dbUser.id,
          answers: {
            connect: createdAnswers.map((a) => ({ id: a.id })),
          },
        },
        include: {
          answers: true,
        },
      });

      return {
        user: dbUser,
        answers: createdAnswers,
        formSubmission,
      };
    });
  }
}
