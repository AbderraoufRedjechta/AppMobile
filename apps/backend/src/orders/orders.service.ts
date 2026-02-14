import { Injectable } from '@nestjs/common';
import { CreateOrderDto } from './dto/create-order.dto';

export interface Order {
  id: number;
  items: number[];
  total: number;
  status: 'PENDING' | 'PREPARING' | 'DELIVERING' | 'DELIVERED';
  createdAt: Date;
}

@Injectable()
export class OrdersService {
  private orders: Order[] = [
    {
      id: 1,
      items: [1, 3],
      total: 1350,
      status: 'DELIVERED',
      createdAt: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000), // 2 days ago
    },
    {
      id: 2,
      items: [2, 5],
      total: 1150,
      status: 'DELIVERING',
      createdAt: new Date(Date.now() - 3 * 60 * 60 * 1000), // 3 hours ago
    },
    {
      id: 3,
      items: [4],
      total: 600,
      status: 'PREPARING',
      createdAt: new Date(Date.now() - 30 * 60 * 1000), // 30 minutes ago
    },
  ];
  private idCounter = 4;

  create(createOrderDto: CreateOrderDto) {
    const order: Order = {
      id: this.idCounter++,
      ...createOrderDto,
      status: 'PENDING',
      createdAt: new Date(),
    };
    this.orders.push(order);
    return order;
  }

  findAll() {
    return this.orders;
  }

  findOne(id: number) {
    return this.orders.find((order) => order.id === id);
  }

  updateStatus(id: number, status: Order['status']) {
    const order = this.findOne(id);
    if (order) {
      order.status = status;
      return order;
    }
    return null;
  }
}
