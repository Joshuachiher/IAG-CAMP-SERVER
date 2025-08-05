import { IsString, IsBoolean, IsOptional, IsInt, IsEnum } from 'class-validator';
import { QuestionType } from '@prisma/client';
import { ApiProperty } from '@nestjs/swagger';

export class CreateQuestionDto {
  @ApiProperty({ example: 'Apa warna kesukaanmu?', description: 'Isi pertanyaan versi Bahasa Indonesia' })
  @IsString()
  questionTextId: string;

  @ApiProperty({ example: 'What is your favorite color?', description: 'Isi pertanyaan versi Bahasa Inggris' })
  @IsString()
  questionTextEn: string;

  @ApiProperty({
    example: 'choice',
    description: 'Tipe pertanyaan',
    enum: QuestionType,
  })
  @IsEnum(QuestionType)
  questionType: QuestionType;

  @ApiProperty({ example: true, description: 'Apakah pertanyaan wajib diisi?' })
  @IsBoolean()
  isRequired: boolean;

  @ApiProperty({ example: 1, description: 'Urutan pertanyaan', required: false })
  @IsOptional()
  @IsInt()
  order?: number;

  @ApiProperty({ example: 3, description: 'ID kategori pertanyaan', required: false })
  @IsOptional()
  @IsInt()
  categoryId?: number;

  @ApiProperty({ example: 'favorite_color', description: 'Key unik untuk identifikasi pertanyaan', required: false })
  @IsOptional()
  @IsString()
  key?: string;

  @ApiProperty({ example: 'Masukkan jawaban Anda...', description: 'Placeholder untuk input', required: false })
  @IsOptional()
  @IsString()
  placeholder?: string;

  @ApiProperty({ example: 'Ini untuk menentukan preferensi warna anak.', description: 'Penjelasan tambahan', required: false })
  @IsOptional()
  @IsString()
  description?: string;
}
