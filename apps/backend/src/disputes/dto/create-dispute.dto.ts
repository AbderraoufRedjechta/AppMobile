import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateDisputeDto {
  @IsNotEmpty()
  @IsNumber()
  orderId: number;

  @IsNotEmpty()
  @IsString()
  reason: string;
}
