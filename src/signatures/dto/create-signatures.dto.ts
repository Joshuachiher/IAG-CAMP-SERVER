import { IsInt, IsString } from 'class-validator';

export class CreateSignatureDto {
  @IsInt()
  userId: number;

  @IsString()
  imageUrl: string;
}
