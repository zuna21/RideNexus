using System;
using API.DTOs;
using API.Entities.Enums;

namespace API.Repositories.DtoRepositories.Contracts;

public interface IChatDtoRepository
{
    Task<ChatDto> GetClientChatByIds(int clientId, int driverId);
}
