import { AuthService } from './auth.service';
import { User } from '../users/user.entity';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    sendOtp(req: {
        phone: string;
    }): Promise<{
        success: boolean;
        message: string;
    }>;
    verifyOtp(req: {
        phone: string;
        otp: string;
    }): Promise<{
        access_token: string;
        user: {
            id: number | undefined;
            email: string | undefined;
            name: string | undefined;
            role: import("../users/user.entity").UserRole | undefined;
            status: import("../users/user.entity").UserStatus | undefined;
        };
        token: string;
    }>;
    register(req: Partial<User>): Promise<{
        access_token: string;
        user: {
            id: number | undefined;
            email: string | undefined;
            name: string | undefined;
            role: import("../users/user.entity").UserRole | undefined;
            status: import("../users/user.entity").UserStatus | undefined;
        };
        token: string;
    }>;
    login(req: {
        email: string;
        pass: string;
    }): Promise<{
        access_token: string;
        user: {
            id: number | undefined;
            email: string | undefined;
            name: string | undefined;
            role: import("../users/user.entity").UserRole | undefined;
            status: import("../users/user.entity").UserStatus | undefined;
        };
        token: string;
    }>;
}
