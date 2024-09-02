using System;
using API.DTOs;
using API.DTOs.Params;

namespace API.Services.Contracts;

public interface IChatService
{
    Task<ChatDto> GetClientChatByIds(int driverId);
    Task<MessageDto> SendMessageClient(int chatId, CreateMessageDto createMessageDto);
    Task<MessageDto> SendMessageDriver(int chatId, CreateMessageDto createMessageDto);
    Task<List<ChatCardDto>> GetDriverChats();
    Task<ChatDto> GetDriverChat(int chatId, BasicParams basicParams);
}
