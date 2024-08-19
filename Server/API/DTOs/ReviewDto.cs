using System;

namespace API.DTOs;

public class ReviewDto
{
    public int Id { get; set; }
    public float Rating { get; set; }
    public string Comment { get; set; }
    public bool IsAnonymous { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class CreateReviewDto 
{
    public float Rating { get; set; }
    public string Comment { get; set; }
    public bool IsAnonymous { get; set; }
}

public class ReviewCardDto
{
    public int Id { get; set; }
    public string Username { get; set; }
    public double Rating { get; set; }
    public string Comment { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class ReviewDetailsDto
{
    public double Rating { get; set; }
    public int RatingCount { get; set; }
    public List<ReviewCardDto> Reviews { get; set; }
}