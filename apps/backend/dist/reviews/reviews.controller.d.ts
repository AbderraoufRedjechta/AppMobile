import { ReviewsService } from './reviews.service';
import { Review } from './review.entity';
export declare class ReviewsController {
    private readonly reviewsService;
    constructor(reviewsService: ReviewsService);
    findAll(): Promise<Review[]>;
    create(reviewData: Partial<Review>): Promise<Review>;
}
