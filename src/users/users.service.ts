import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../common/prisma.service';
import { CreateUserDto } from './dto/create-users.dto';
import { UpdateUserDto } from './dto/update-users.dto';
import { Prisma } from '@prisma/client';
import { ConflictException } from '@nestjs/common';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}



async create(data: CreateUserDto) {
  const existingUser = await this.prisma.user.findUnique({
    where: { email: data.email },
  });

  if (existingUser) {
    throw new ConflictException('Email sudah terdaftar, gunakan email lain');
  }

  return this.prisma.user.create({ data });
}


  async findAll(
    page: number = 1,
    limit: number = 10,
    filterName?: string,
  ) {
    const skip = (page - 1) * limit;
const where = filterName
  ? { name: { contains: filterName, mode: Prisma.QueryMode.insensitive } }
  : {};

    const [data, total] = await Promise.all([
      this.prisma.user.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
      }),
      this.prisma.user.count({ where }),
    ]);

    return {
      data,
      total,
      page,
      lastPage: Math.ceil(total / limit),
    };
  }

  async findOne(id: number) {
    const user = await this.prisma.user.findUnique({
      where: { id },
      include: {
        answers: true,
        formSubmissions: true,
        signature: true,
      },
    });
    if (!user) {
      throw new NotFoundException(`User with id ${id} not found`);
    }
    return user;
  }

  async findUserWithAnswers(id: number) {
    const user = await this.prisma.user.findUnique({
      where: { id },
      include: {
        answers: {
          include: {
            question: true,
            formSubmission: true,
          },
        },
        signature: true,
        formSubmissions: true,
      },
    });
    if (!user) {
      throw new NotFoundException(`User with id ${id} not found`);
    }
    return user;
  }

  async update(id: number, data: UpdateUserDto) {
    await this.findOne(id); // pastikan user ada dulu
    return this.prisma.user.update({
      where: { id },
      data,
    });
  }

  async replace(id: number, data: CreateUserDto) {
    const existing = await this.prisma.user.findUnique({ where: { id } });
    if (!existing) {
      throw new NotFoundException(`User with id ${id} not found`);
    }
    return this.prisma.user.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    await this.findOne(id); // cek dulu ada
    return this.prisma.user.delete({
      where: { id },
    });
  }
}
