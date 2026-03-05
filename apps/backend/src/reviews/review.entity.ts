import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  ManyToOne,
} from 'typeorm';
import { User } from '../users/user.entity';
import { Dish } from '../dishes/dish.entity';
import { Order } from '../orders/order.entity';

@Entity('reviews')
export class Review {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Order, { eager: true, nullable: true })
  order: Order;

  @ManyToOne(() => Dish, { eager: true })
  dish: Dish;

  @ManyToOne(() => User, { eager: true })
  author: User;

  @Column({ type: 'int', default: 5 })
  rating: number;

  @Column({ nullable: true })
  comment: string;

  @CreateDateColumn()
  createdAt: Date;
}
