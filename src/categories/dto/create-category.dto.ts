import { IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateCategoryDto {
  @ApiProperty({
    description: 'Nama kategori',
    example: 'Elektronik',
  })
  @IsString()
  name: string;
}
