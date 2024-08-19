using System;
using API.DTOs;
using API.Repositories.DtoRepositories.Contracts;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace API.Repositories.DtoRepositories;

public class ReviewDtoRepository(
    DataContext dataContext
) : IReviewDtoRepository
{
    private readonly DataContext _dataContext = dataContext;
    public async Task<ReviewDetailsDto> GetReviewDetails(int driverId)
    {
        return await _dataContext.Drivers
            .Where(driver => driver.Id == driverId)
            .Select(driver => new ReviewDetailsDto
            {
                Rating = driver.Reviews.Count == 0 ? 0 : driver.Reviews.Average(x => x.Rating),
                RatingCount = driver.Reviews.Count,
                Reviews = driver.Reviews
                    .Where(review => !string.IsNullOrEmpty(review.Comment))
                    .Select(review => new ReviewCardDto
                    {
                        Id = review.Id,
                        Comment = review.Comment,
                        CreatedAt = review.CreatedAt,
                        Rating = Math.Round(review.Rating, 2),
                        Username = review.IsAnonymous
                            ? "Anonimno"
                            : review.Client.Username
                    })
                    .ToList()
            })
            .FirstOrDefaultAsync();
    }
}
