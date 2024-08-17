using System;
using API.Entities.Enums;

namespace API.Entities;

public class Message
{
    public int Id { get; set; }
    public int ChatId { get; set; }
    public int CreatorId { get; set; }
    public string Content { get; set; }
    public CreatorType CreatorType { get; set; } = CreatorType.Client;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public Chat Chat { get; set; }
}
