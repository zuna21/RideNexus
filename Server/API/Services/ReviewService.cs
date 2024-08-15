using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;
using API.Utils.Mappers;
using Microsoft.AspNetCore.Http.HttpResults;

namespace API.Services;

public class ReviewService(
    IReviewRepository reviewRepository,
    IUserService userService,
    IDriverRepository driverRepository
) : IReviewService
{
    private readonly IReviewRepository _reviewRepository = reviewRepository;
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly IUserService _userService = userService;

    public async Task<ReviewDto> Create(CreateReviewDto createReviewDto, int driverId)
    {
        var client = await _userService.GetClient();
        if (client == null) return null;

        var driver = await _driverRepository.FindById(driverId);
        if (driver == null) return null;

        Review review = ReviewMapper.CreateReviewDtoToReview(createReviewDto);
        review.DriverId = driver.Id;
        review.Driver = driver;

        review.ClientId = client.Id;
        review.Client = client;

        _reviewRepository.Add(review);
        if (!await _reviewRepository.SaveAllAsync()) return null;
        return ReviewMapper.ReviewToReviewDto(review);
    }
}
