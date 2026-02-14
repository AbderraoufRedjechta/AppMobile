import { Injectable } from '@nestjs/common';

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

export interface User {
  id: number;
  email: string;
  password: string;
  name: string;
  role: UserRole;
  status: UserStatus;
}

@Injectable()
export class UsersService {
  private users: User[] = [
    {
      id: 1,
      email: 'client@tayabli.com',
      password: 'password',
      name: 'Client Test',
      role: UserRole.CLIENT,
      status: UserStatus.APPROVED,
    },
    {
      id: 2,
      email: 'cook@tayabli.com',
      password: 'password',
      name: 'Cook Test',
      role: UserRole.COOK,
      status: UserStatus.APPROVED,
    },
    {
      id: 3,
      email: 'courier@tayabli.com',
      password: 'password',
      name: 'Courier Test',
      role: UserRole.COURIER,
      status: UserStatus.APPROVED,
    },
    {
      id: 4,
      email: 'admin@tayabli.com',
      password: 'password',
      name: 'Admin Test',
      role: UserRole.ADMIN,
      status: UserStatus.APPROVED,
    },
  ];

  findOne(email: string): User | undefined {
    return this.users.find((user) => user.email === email);
  }

  create(user: Omit<User, 'id' | 'status'>): User {
    const newUser: User = {
      id: this.users.length + 1,
      ...user,
      status: user.role === UserRole.CLIENT ? UserStatus.APPROVED : UserStatus.PENDING,
    };
    this.users.push(newUser);
    return newUser;
  }

  findAll(): User[] {
    return this.users;
  }

  updateStatus(id: number, status: UserStatus): User | undefined {
    const user = this.users.find((u) => u.id === id);
    if (user) {
      user.status = status;
      return user;
    }
    return undefined;
  }
}
