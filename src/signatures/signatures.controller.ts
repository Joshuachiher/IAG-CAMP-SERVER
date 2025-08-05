import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Patch,
  Delete,
  ParseIntPipe,
  NotFoundException,
} from '@nestjs/common';
import { SignaturesService } from './signatures.service';
import { CreateSignatureDto } from './dto/create-signatures.dto';
import { UpdateSignatureDto } from './dto/update-signatures.dto';

@Controller('signatures')
export class SignaturesController {
  constructor(private readonly signaturesService: SignaturesService) {}

  @Post()
  create(@Body() createDto: CreateSignatureDto) {
    return this.signaturesService.create(createDto);
  }

  @Get()
  findAll() {
    return this.signaturesService.findAll();
  }

  @Get('/user/:userId')
async findByUserId(@Param('userId', ParseIntPipe) userId: number) {
  const signature = await this.signaturesService.findByUserId(userId);
  if (!signature) throw new NotFoundException(`Signature for userId ${userId} not found`);
  return signature;
}


  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.signaturesService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateDto: UpdateSignatureDto,
  ) {
    return this.signaturesService.update(id, updateDto);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.signaturesService.remove(id);
  }
}
