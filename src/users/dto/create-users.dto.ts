import { IsEmail, IsOptional, IsString, IsInt } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateUserDto {
   @ApiProperty({ example: 'John Doe', description: 'Full name of the user' })
  @IsString()
  name: string;

   @ApiProperty({ example: 'john@example.com', description: 'Email address' })
  @IsEmail()
  email: string;

    @ApiProperty({ example: '08123456789', description: 'Phone number', required: false })
  @IsOptional()
  @IsString()
  phone?: string;

    @ApiProperty({ example: 17, description: 'Age of the user', required: false })
  @IsOptional()
  @IsInt()
  age?: number;


 @ApiProperty({ example: 'male', description: 'Gender of the user', required: false })
  @IsOptional()
  @IsString()
  gender?: string;
}
