using System;
using API.DTOs;
using API.DTOs.Params;
using API.Entities.Enums;

namespace API.Repositories.DtoRepositories.Contracts;

public interface IChatDtoRepository
{
    Task<ChatDto> GetClientChatByIds(int clientId, int driverId, BasicParams basicParams);
    Task<List<ChatCardDto>> GetDriverChats(int driverId);
    Task<ChatDto> GetById(int chatId, int searcherId, CreatorType creatorType, BasicParams basicParams);
}
