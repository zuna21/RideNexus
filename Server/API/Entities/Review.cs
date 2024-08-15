using System;

namespace API.Entities;

public class Review
{
    public int Id { get; set; } 
    public int DriverId { get; set; }
    public int ClientId { get; set; }
    public float Rating { get; set; } = 0;
    public string Comment { get; set; }
    public bool IsAnonymous { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public Driver Driver { get; set; }
    public Client Client { get; set; }
}
