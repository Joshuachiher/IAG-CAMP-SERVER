import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsArray, ArrayNotEmpty, ValidateNested, IsString } from 'class-validator';
import { Type } from 'class-transformer';

export class AnswerDto {
  @ApiProperty({ example: 3, description: 'ID pertanyaan' })
  @IsInt()
  questionId: number;

  @ApiProperty({ example: 'Laki-laki', description: 'Jawaban teks' })
  @IsString()
  answerText: string;
}

export class CreateFormSubmissionDto {
  @ApiProperty({ example: 1, description: 'ID user yang submit form' })
  @IsInt()
  userId: number;

  @ApiProperty({ type: [AnswerDto], description: 'List jawaban dari pertanyaan' })
  @IsArray()
  @ArrayNotEmpty()
  @ValidateNested({ each: true })
  @Type(() => AnswerDto)
  answers: AnswerDto[];
}
