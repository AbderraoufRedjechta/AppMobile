import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
} from 'typeorm';
import { User } from '../users/user.entity';
import { Order } from '../orders/order.entity';

export enum DisputeStatus {
  OPEN = 'OPEN',
  RESOLVED = 'RESOLVED',
}

@Entity('disputes')
export class Dispute {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Order, { eager: true })
  order: Order;

  @ManyToOne(() => User, { eager: true })
  user: User;

  @Column()
  reason: string;

  @Column({
    type: 'enum',
    enum: DisputeStatus,
    default: DisputeStatus.OPEN,
  })
  status: DisputeStatus;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
