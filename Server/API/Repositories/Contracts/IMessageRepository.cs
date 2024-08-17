using System;
using API.Entities;

namespace API.Repositories.Contracts;

public interface IMessageRepository
{
    void Create(Message message);
    Task<bool> SaveAllAsync();
}
