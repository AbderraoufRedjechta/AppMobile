import { UsersService } from './users.service';
import { UserStatus } from './user.entity';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    findAll(): Promise<import("./user.entity").User[]>;
    findCooks(): Promise<import("./user.entity").User[]>;
    updateStatus(id: string, status: UserStatus): Promise<import("./user.entity").User>;
}
