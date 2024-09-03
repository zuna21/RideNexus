using System;
using API.DTOs;
using API.DTOs.Params;

namespace API.Services.Contracts;

public interface IChatService
{
    Task<ChatDto> GetClientChatByIds(int driverId, BasicParams basicParams);
    Task<MessageDto> SendMessageClient(int chatId, CreateMessageDto createMessageDto);
    Task<MessageDto> SendMessageDriver(int chatId, CreateMessageDto createMessageDto);
    Task<List<ChatCardDto>> GetDriverChats(BasicParams basicParams);
    Task<ChatDto> GetDriverChat(int chatId, BasicParams basicParams);
}
