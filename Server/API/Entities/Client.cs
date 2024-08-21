using System;

namespace API.Entities;

public class Client
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }
    public double Latitude { get; set; } = 0;
    public double Longitude { get; set; } = 0;
    public string Location { get; set; }
    public string FCMToken { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public List<Review> Reviews { get; set; } = [];
    public List<Chat> Chats { get; set; } = [];
}
