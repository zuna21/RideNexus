using System;

namespace API.Entities;

public class Chat
{
    public int Id { get; set; }
    public int ClientId { get; set; }
    public int DriverId { get; set; }
    public bool IsSeenUser { get; set; } = false;
    public bool IsSeenDriver { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public Driver Driver { get; set; }
    public Client Client { get; set; }
    public List<Message> Messages { get; set; } = [];
}
