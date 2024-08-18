using System;
using API.Entities;
using API.Repositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories;

public class ChatRepository(
    DataContext dataContext
) : IChatRepository
{
    private readonly DataContext _dataContext = dataContext;

    public void Create(Chat chat)
    {
        _dataContext.Chats.Add(chat);
    }

    public async Task<Chat> GetById(int id)
    {
        return await _dataContext.Chats.FindAsync(id);
    }

    public async Task<bool> IsChatCreated(int clientId, int driverId)
    {
        return await _dataContext.Chats
            .AnyAsync(chat => chat.ClientId == clientId && chat.DriverId == driverId);
    }

    public async Task<bool> SaveAllAsync()
    {
        return await _dataContext.SaveChangesAsync() > 0;
    }
}
