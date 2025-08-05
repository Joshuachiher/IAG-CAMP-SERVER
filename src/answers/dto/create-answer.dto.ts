import { IsString, IsInt, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateAnswerDto {
  @ApiProperty({ example: 'Blue', description: 'Jawaban teks' })
  @IsString()
  answerText: string;

  @ApiProperty({ example: 1, description: 'ID pertanyaan yang dijawab' })
  @IsInt()
  questionId: number;

  @ApiProperty({ example: 2, description: 'ID user yang memberikan jawaban' })
  @IsInt()
  userId: number;

  @ApiProperty({ example: 5, description: 'ID form submission terkait', required: false })
  @IsOptional()
  @IsInt()
  formSubmissionId?: number;
}
