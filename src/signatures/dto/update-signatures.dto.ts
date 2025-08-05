import { PartialType } from '@nestjs/mapped-types';
import { CreateSignatureDto } from './create-signatures.dto';

export class UpdateSignatureDto extends PartialType(CreateSignatureDto) {}
