import { IsArray, IsNumber, IsNotEmpty, Min } from 'class-validator';

export class CreateOrderDto {
  @IsArray()
  @IsNotEmpty()
  items: number[]; // List of Dish IDs

  @IsNumber()
  @Min(0)
  total: number;
}
