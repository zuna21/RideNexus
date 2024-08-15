using System;
using API.DTOs;
using API.Entities;

namespace API.Utils.Mappers;

public static class ReviewMapper
{
    public static Review CreateReviewDtoToReview(CreateReviewDto createReviewDto)
    {
        return new Review
        {
            Comment = createReviewDto.Comment,
            IsAnonymous = createReviewDto.IsAnonymous,
            Rating = createReviewDto.Rating,
        };
    }

    public static ReviewDto ReviewToReviewDto(Review review)
    {
        return new ReviewDto
        {
            Comment = review.Comment,
            CreatedAt = review.CreatedAt,
            Id = review.Id,
            IsAnonymous = review.IsAnonymous,
            Rating = review.Rating,
        };
    }
}

