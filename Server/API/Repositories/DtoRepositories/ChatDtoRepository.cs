using System;
using API.DTOs;
using API.Entities.Enums;
using API.Repositories.DtoRepositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories.DtoRepositories;

public class ChatDtoRepository(
    DataContext dataContext
) : IChatDtoRepository
{
    private readonly DataContext _dataContext = dataContext;

    public async Task<ChatDto> GetClientChatByIds(int clientId, int driverId)
    {
        return await _dataContext.Chats
            .Where(chat => chat.ClientId == clientId && chat.DriverId == driverId)
            .Select(chat => new ChatDto
            {
                Id = chat.Id,
                Messages = chat.Messages
                    .Select(message => new MessageDto
                    {
                        Id = message.Id,
                        Content = message.Content,
                        IsMine = message.CreatorType == CreatorType.Client,
                        CreatedAt = message.CreatedAt,
                    })
                    .ToList(),
            })
            .FirstOrDefaultAsync();
    }
}
