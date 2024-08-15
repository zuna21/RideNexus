using System;
using API.DTOs;

namespace API.Services.Contracts;

public interface IReviewService
{
    Task<ReviewDto> Create(CreateReviewDto createReviewDto, int driverId);
}
