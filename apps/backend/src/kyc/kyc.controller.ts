import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFiles,
  Body,
} from '@nestjs/common';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { KycService } from './kyc.service';
import { diskStorage } from 'multer';
import { extname } from 'path';

@Controller('kyc')
export class KycController {
  constructor(private readonly kycService: KycService) {}

  @Post('upload')
  @UseInterceptors(
    FileFieldsInterceptor(
      [
        { name: 'cni_front', maxCount: 1 },
        { name: 'cni_back', maxCount: 1 },
        { name: 'kitchen_photo', maxCount: 3 },
      ],
      {
        storage: diskStorage({
          destination: './uploads',
          filename: (req, file, cb) => {
            const randomName = Array(32)
              .fill(null)
              .map(() => Math.round(Math.random() * 16).toString(16))
              .join('');
            return cb(null, `${randomName}${extname(file.originalname)}`);
          },
        }),
      },
    ),
  )
  uploadFile(
    @UploadedFiles()
    files: {
      cni_front?: Express.Multer.File[];
      cni_back?: Express.Multer.File[];
      kitchen_photo?: Express.Multer.File[];
    },
    @Body() body: any,
  ) {
    console.log(files);
    return {
      message: 'KYC documents uploaded successfully',
      status: 'SUBMITTED',
    };
  }
}
