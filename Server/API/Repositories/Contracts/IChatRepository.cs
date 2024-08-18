using System;
using API.Entities;

namespace API.Repositories.Contracts;

public interface IChatRepository
{
    void Create(Chat chat);
    Task<bool> IsChatCreated(int clientId, int driverId);
    Task<Chat> GetById(int id);
    Task<bool> SaveAllAsync();
}
