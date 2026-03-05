import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { User, UserRole, UserStatus } from '../users/user.entity';
export declare class AuthService {
    private usersService;
    private jwtService;
    private readonly logger;
    private otpStore;
    constructor(usersService: UsersService, jwtService: JwtService);
    sendOtp(phone: string): Promise<{
        success: boolean;
        message: string;
    }>;
    verifyOtp(phone: string, otp: string): Promise<{
        access_token: string;
        user: {
            id: number | undefined;
            email: string | undefined;
            name: string | undefined;
            role: UserRole | undefined;
            status: UserStatus | undefined;
        };
        token: string;
    }>;
    login(user: Partial<User>): Promise<{
        access_token: string;
        user: {
            id: number | undefined;
            email: string | undefined;
            name: string | undefined;
            role: UserRole | undefined;
            status: UserStatus | undefined;
        };
        token: string;
    }>;
    register(user: Partial<User>): Promise<{
        access_token: string;
        user: {
            id: number | undefined;
            email: string | undefined;
            name: string | undefined;
            role: UserRole | undefined;
            status: UserStatus | undefined;
        };
        token: string;
    }>;
    loginWithEmail(email: string, pass: string): Promise<{
        access_token: string;
        user: {
            id: number | undefined;
            email: string | undefined;
            name: string | undefined;
            role: UserRole | undefined;
            status: UserStatus | undefined;
        };
        token: string;
    }>;
}
