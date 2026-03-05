import { Repository } from 'typeorm';
import { Review } from './review.entity';
export declare class ReviewsService {
    private reviewsRepository;
    constructor(reviewsRepository: Repository<Review>);
    findAll(): Promise<Review[]>;
    create(reviewData: Partial<Review>): Promise<Review>;
}
