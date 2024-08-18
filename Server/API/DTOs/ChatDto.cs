using System;

namespace API.DTOs;

public class ChatDto
{
    public int Id { get; set; }
    public List<MessageDto> Messages { get; set; }
}

public class ChatCardDto
{
    public int Id { get; set; }
    public string SenderUsername { get; set; }
    public bool IsSeen { get; set; }
    public MessageDto LastMessage { get; set; }
}