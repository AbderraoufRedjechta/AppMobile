import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  OneToMany,
} from 'typeorm';
import { Dish } from '../dishes/dish.entity';
import { Order } from '../orders/order.entity';

export enum UserRole {
  CLIENT = 'CLIENT',
  COOK = 'COOK',
  COURIER = 'COURIER',
  ADMIN = 'ADMIN',
}

export enum UserStatus {
  PENDING = 'PENDING',
  APPROVED = 'APPROVED',
  REJECTED = 'REJECTED',
}

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  password?: string;

  @Column()
  name: string;

  @Column({ nullable: true })
  phone?: string;

  @Column({ nullable: true })
  avatar?: string;

  @Column({
    type: 'enum',
    enum: UserRole,
    default: UserRole.CLIENT,
  })
  role: UserRole;

  @Column({
    type: 'enum',
    enum: UserStatus,
    default: UserStatus.PENDING,
  })
  status: UserStatus;

  @OneToMany(() => Dish, (dish) => dish.cook)
  dishes: Dish[];

  @OneToMany(() => Order, (order) => order.client)
  clientOrders: Order[];

  @Column({ nullable: true })
  cniFront?: string;

  @Column({ nullable: true })
  cniBack?: string;

  @Column('simple-array', { nullable: true })
  kitchenPhotos?: string[];

  @Column({
    type: 'enum',
    enum: UserStatus,
    default: UserStatus.PENDING,
  })
  kycStatus: UserStatus;

  @OneToMany(() => Order, (order) => order.cook)
  cookOrders: Order[];

  @OneToMany(() => Order, (order) => order.courier)
  courierMissions: Order[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
