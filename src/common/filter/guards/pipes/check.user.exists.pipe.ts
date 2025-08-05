// pipes/check-user-exists.pipe.ts
import { PipeTransform, Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from 'src/common/prisma.service';

@Injectable()
export class CheckUserExistsPipe implements PipeTransform {
  constructor(private readonly prisma: PrismaService) {}

  async transform(value: any) {
    const user = await this.prisma.user.findUnique({
      where: { email: value.email },
    });

    if (!user) {
      throw new BadRequestException('Email tidak terdaftar. Silakan register terlebih dahulu.');
    }

    value.userId = user.id; // opsional, agar bisa dipakai langsung di service

    return value;
  }
}
