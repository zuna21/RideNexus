using System;
using API.DTOs;
using API.Services;
using API.Services.Contracts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers;

[Authorize]
public class ReviewsController(
    IReviewService reviewService
) : BaseController
{
    private readonly IReviewService _reviewService = reviewService;


    [HttpPost("{driverId}")]
    public async Task<ActionResult<ReviewDto>> Create(int driverId, CreateReviewDto createReviewDto)
    {
        var createdReview = await _reviewService.Create(createReviewDto, driverId);
        if (createdReview == null) return BadRequest("Failed to create review");
        return createdReview;
    }

    [HttpGet("{driverId}")]
    public async Task<ActionResult<ReviewDetailsDto>> GetReviewDetails(int driverId)
    {
        var review = await _reviewService.GetReviewDetails(driverId);
        if (review == null) return NotFound();
        return review;
    }
}
