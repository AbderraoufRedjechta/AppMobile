import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order, OrderStatus } from './order.entity';
import { CreateOrderDto } from './dto/create-order.dto';
import { User } from '../users/user.entity';
import { Dish } from '../dishes/dish.entity';

@Injectable()
export class OrdersService {
  constructor(
    @InjectRepository(Order)
    private ordersRepository: Repository<Order>,
  ) {}

  async create(
    createOrderDto: CreateOrderDto,
    client: User,
    cook: User,
    dish: Dish,
  ): Promise<Order> {
    const order = this.ordersRepository.create({
      ...createOrderDto,
      client,
      cook,
      dish,
      status: OrderStatus.PENDING,
    });
    return this.ordersRepository.save(order);
  }

  async findAll(): Promise<Order[]> {
    return this.ordersRepository.find({
      relations: ['client', 'cook', 'courier', 'dish'],
    });
  }

  async findOne(id: number): Promise<Order> {
    const order = await this.ordersRepository.findOne({
      where: { id },
      relations: ['client', 'cook', 'courier', 'dish'],
    });
    if (!order) {
      throw new NotFoundException(`Order with ID ${id} not found`);
    }
    return order;
  }

  async findByClient(clientId: number): Promise<Order[]> {
    return this.ordersRepository.find({
      where: { client: { id: clientId } },
      relations: ['cook', 'courier', 'dish'],
    });
  }

  async findByCook(cookId: number): Promise<Order[]> {
    return this.ordersRepository.find({
      where: { cook: { id: cookId } },
      relations: ['client', 'courier', 'dish'],
    });
  }

  async updateStatus(id: number, status: OrderStatus): Promise<Order> {
    const order = await this.findOne(id);
    order.status = status;
    return this.ordersRepository.save(order);
  }

  async assignCourier(id: number, courier: User): Promise<Order> {
    const order = await this.findOne(id);
    order.courier = courier;
    order.status = OrderStatus.ASSIGNED;
    return this.ordersRepository.save(order);
  }
}
