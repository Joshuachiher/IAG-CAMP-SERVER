import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../common/prisma.service';
import { CreateSignatureDto } from './dto/create-signatures.dto';
import { UpdateSignatureDto } from './dto/update-signatures.dto';

@Injectable()
export class SignaturesService {
  constructor(private prisma: PrismaService) {}

async create(data: CreateSignatureDto) {
  return this.prisma.signature.upsert({
    where: { userId: data.userId },
    update: { imageUrl: data.imageUrl },
    create: { userId: data.userId, imageUrl: data.imageUrl },
  });
}

  async findAll() {
    return this.prisma.signature.findMany({
    });
  }

  async findByUserId(userId: number) {
  return this.prisma.signature.findUnique({
    where: { userId }, // karena userId @unique di Signature
  });
}


  async findOne(id: number) {
    const signature = await this.prisma.signature.findUnique({
      where: { id },
      include: { user: true },
    });
    if (!signature) {
      throw new NotFoundException(`Signature with id ${id} not found`);
    }
    return signature;
  }

  async update(id: number, data: UpdateSignatureDto) {
    await this.findOne(id);
    return this.prisma.signature.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    await this.findOne(id);
    return this.prisma.signature.delete({
      where: { id },
    });
  }
}
