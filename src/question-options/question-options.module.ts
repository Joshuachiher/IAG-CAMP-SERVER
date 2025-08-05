import { Module } from '@nestjs/common';
import { QuestionOptionsService } from './question-options.service';
import { QuestionOptionsController } from './question-options.controller';
import { PrismaModule } from '../common/prisma.module';

@Module({
  imports: [PrismaModule],
  controllers: [QuestionOptionsController],
  providers: [QuestionOptionsService],
})
export class QuestionOptionsModule {}
