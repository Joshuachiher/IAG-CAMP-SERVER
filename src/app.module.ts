import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { QuestionsModule } from './questions/questions.module';
import { QuestionOptionsModule } from './question-options/question-options.module';
import { PrismaModule } from 'src/common/prisma.module';
import { UsersModule } from './users/users.module';
import { AnswersModule } from './answers/answers.module';
import { CategoriesModule } from './categories/categories.module';
import { FormSubmissionsModule } from './form-submissions/form.submissions.module';
import { SignaturesModule } from './signatures/signatures.module';
import { SubmissionModule } from './submission-service/submission-module';

@Module({
  imports: [
    FormSubmissionsModule,
    QuestionsModule,
    QuestionOptionsModule,
    PrismaModule,
    UsersModule,
    AnswersModule,
    CategoriesModule,
    SignaturesModule,
    SubmissionModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
