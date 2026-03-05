import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User, UserRole, UserStatus } from './user.entity';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) { }

  async findOne(email: string): Promise<User | null> {
    return this.usersRepository.findOne({ where: { email } });
  }

  async findByPhone(phone: string): Promise<User | null> {
    return this.usersRepository.findOne({ where: { phone } });
  }

  async findById(id: number): Promise<User> {
    const user = await this.usersRepository.findOne({ where: { id } });
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }
    return user;
  }

  async create(userData: Partial<User>): Promise<User> {
    const user = this.usersRepository.create({
      ...userData,
      status:
        userData.role === UserRole.CLIENT
          ? UserStatus.APPROVED
          : UserStatus.PENDING,
    });
    return this.usersRepository.save(user);
  }

  async findAll(): Promise<User[]> {
    return this.usersRepository.find();
  }

  async findCooks(): Promise<User[]> {
    return this.usersRepository.find({
      where: {
        role: UserRole.COOK,
        status: UserStatus.APPROVED,
      },
    });
  }
  async findCouriers(): Promise<User[]> {
    return this.usersRepository.find({
      where: {
        role: UserRole.COURIER,
        status: UserStatus.APPROVED,
      },
    });
  }

  async findPending(): Promise<User[]> {
    return this.usersRepository.find({
      where: {
        status: UserStatus.PENDING,
      },
    });
  }

  async updateStatus(id: number, status: UserStatus): Promise<User> {
    const user = await this.findById(id);
    user.status = status;
    return this.usersRepository.save(user);
  }
}
