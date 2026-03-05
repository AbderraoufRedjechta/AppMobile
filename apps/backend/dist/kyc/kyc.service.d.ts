import { UsersService } from '../users/users.service';
import { User } from '../users/user.entity';
export declare class KycService {
    private usersService;
    constructor(usersService: UsersService);
    updateKycDocuments(userId: number, documents: {
        cni_front?: Express.Multer.File[];
        cni_back?: Express.Multer.File[];
        kitchen_photo?: Express.Multer.File[];
    }): Promise<User>;
}
