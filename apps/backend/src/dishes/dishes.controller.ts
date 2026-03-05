import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { DishesService } from './dishes.service';
import { CreateDishDto } from './dto/create-dish.dto';
import { User } from '../users/user.entity';

@Controller('dishes')
export class DishesController {
  constructor(private readonly dishesService: DishesService) {}

  @Post()
  async create(
    @Body() createDishDto: CreateDishDto,
    @Body('cookId') cookId: number,
  ) {
    // Assuming cook is passed or extracted from JWT in real life
    // For now we just mock a user lookup or pass raw
    return this.dishesService.create(createDishDto, { id: cookId } as User);
  }

  @Get()
  async findAll() {
    return this.dishesService.findAll();
  }

  @Get('cook/:cookId')
  async findByCook(@Param('cookId') cookId: string) {
    return this.dishesService.findByCook(+cookId);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dishesService.findOne(+id);
  }
}
