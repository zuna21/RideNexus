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
