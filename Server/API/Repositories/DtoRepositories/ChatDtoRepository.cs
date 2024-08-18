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

    public async Task<ChatDto> GetById(int chatId, int searcherId, CreatorType creatorType)
    {
        return await _dataContext.Chats
            .Where(chat => chat.Id == chatId)
            .Select(chat => new ChatDto
            {
                Id = chat.Id,
                Messages = chat.Messages
                    .Select(message => new MessageDto
                    {
                        Id = message.Id,
                        Content = message.Content,
                        IsMine = message.CreatorId == searcherId 
                            && message.CreatorType == creatorType,
                        CreatedAt = message.CreatedAt
                    })
                    .ToList()
            })
            .FirstOrDefaultAsync();
    }

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

    public async Task<List<ChatCardDto>> GetDriverChats(int driverId)
    {
        return await _dataContext.Chats
            .Where(chat => chat.DriverId == driverId)
            .Select(chat => new ChatCardDto
            {
                Id = chat.Id,
                IsSeen = chat.IsSeenDriver,
                SenderUsername = chat.Client.Username,
                LastMessage = chat.Messages
                    .OrderByDescending(message => message.CreatedAt)
                    .Select(message => new MessageDto
                    {
                        Id = message.Id,
                        Content = message.Content,
                        CreatedAt = message.CreatedAt,
                        IsMine = false  // Ovo meni u sustini ne treba u chatCard
                    })
                    .FirstOrDefault()
            })
            .ToListAsync();
    }
}
