import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { User } from '../users/user.entity';
import { Dish } from '../dishes/dish.entity';
import { OrderStatus } from './order.entity';

@Controller('orders')
export class OrdersController {
  constructor(private readonly ordersService: OrdersService) {}

  @Post()
  async create(
    @Body() createOrderDto: CreateOrderDto,
    @Body('clientId') clientId: number,
    @Body('cookId') cookId: number,
    @Body('dishId') dishId: number,
  ) {
    // In a real app these come from JWT or complex DTOs
    return this.ordersService.create(
      createOrderDto,
      { id: clientId } as User,
      { id: cookId } as User,
      { id: dishId } as Dish,
    );
  }

  @Get()
  async findAll() {
    return this.ordersService.findAll();
  }
  @Get('client/:clientId')
  async findByClient(@Param('clientId') clientId: string) {
    return this.ordersService.findByClient(+clientId);
  }

  @Get('cook/:cookId')
  async findByCook(@Param('cookId') cookId: string) {
    return this.ordersService.findByCook(+cookId);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.ordersService.findOne(+id);
  }

  @Post(':id/status')
  async updateStatus(
    @Param('id') id: string,
    @Body('status') status: OrderStatus,
  ) {
    return this.ordersService.updateStatus(+id, status);
  }
}
