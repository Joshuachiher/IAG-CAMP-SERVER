import { IsEmail, IsNotEmpty } from 'class-validator';

export class CreateSubmissionDto {
  @IsEmail()
  @IsNotEmpty()
  email: string; // email untuk validasi user

  @IsNotEmpty()
  answers: any; // isi jawaban, bisa object atau array tergantung struktur kamu
}
