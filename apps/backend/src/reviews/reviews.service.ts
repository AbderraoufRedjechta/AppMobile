import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Review } from './review.entity';

@Injectable()
export class ReviewsService {
  constructor(
    @InjectRepository(Review)
    private reviewsRepository: Repository<Review>,
  ) {}

  findAll(): Promise<Review[]> {
    return this.reviewsRepository.find();
  }

  create(reviewData: Partial<Review>): Promise<Review> {
    const review = this.reviewsRepository.create(reviewData);
    return this.reviewsRepository.save(review);
  }
}
