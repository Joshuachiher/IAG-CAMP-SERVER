import { IsString, IsInt } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateQuestionOptionDto {
  @ApiProperty({ example: 3, description: 'ID pertanyaan yang terkait' })
  @IsInt()
  questionId: number;

  @ApiProperty({ example: 'L', description: 'Nilai yang disimpan sebagai jawaban' })
  @IsString()
  value: string;

  @ApiProperty({ example: 'Laki-laki', description: 'Label atau teks yang ditampilkan' })
  @IsString()
  label: string;
}
