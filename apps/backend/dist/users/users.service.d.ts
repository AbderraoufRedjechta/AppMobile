import { Repository } from 'typeorm';
import { User, UserStatus } from './user.entity';
export declare class UsersService {
    private usersRepository;
    constructor(usersRepository: Repository<User>);
    findOne(email: string): Promise<User | null>;
    findByPhone(phone: string): Promise<User | null>;
    findById(id: number): Promise<User>;
    create(userData: Partial<User>): Promise<User>;
    findAll(): Promise<User[]>;
    findCooks(): Promise<User[]>;
    findCouriers(): Promise<User[]>;
    findPending(): Promise<User[]>;
    updateStatus(id: number, status: UserStatus): Promise<User>;
}
