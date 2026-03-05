import { Injectable, NotFoundException } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { UserStatus, User } from '../users/user.entity';

@Injectable()
export class KycService {
  constructor(private usersService: UsersService) {}

  async updateKycDocuments(
    userId: number,
    documents: {
      cni_front?: Express.Multer.File[];
      cni_back?: Express.Multer.File[];
      kitchen_photo?: Express.Multer.File[];
    },
  ) {
    const user = await this.usersService.findById(userId);
    if (!user) {
      throw new NotFoundException(`User with ID ${userId} not found`);
    }

    if (documents.cni_front) user.cniFront = documents.cni_front[0].filename;
    if (documents.cni_back) user.cniBack = documents.cni_back[0].filename;
    if (documents.kitchen_photo) {
      user.kitchenPhotos = documents.kitchen_photo.map((file) => file.filename);
    }

    user.kycStatus = UserStatus.PENDING; // Still pending admin approval

    // This is a quick workaround since we didn't add a direct update method,
    // using create to save works in TypeORM if ID is present
    return this.usersService.create(user as Partial<User>);
  }
}
