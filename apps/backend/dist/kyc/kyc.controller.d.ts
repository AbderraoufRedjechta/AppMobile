import { KycService } from './kyc.service';
export declare class KycController {
    private readonly kycService;
    constructor(kycService: KycService);
    uploadFile(files: {
        cni_front?: Express.Multer.File[];
        cni_back?: Express.Multer.File[];
        kitchen_photo?: Express.Multer.File[];
    }, body: any): {
        message: string;
        status: string;
    };
}
