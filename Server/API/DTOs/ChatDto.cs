using System;

namespace API.DTOs;

public class ChatDto
{
    public int Id { get; set; }
    public List<MessageDto> Messages { get; set; }
}
