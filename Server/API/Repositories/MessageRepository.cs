using System;
using API.Entities;
using API.Repositories.Contracts;

namespace API.Repositories;

public class MessageRepository(
    DataContext dataContext
) : IMessageRepository
{
    private readonly DataContext _dataContext = dataContext;


    public void Create(Message message)
    {
        _dataContext.Messages.Add(message);
    }

    public async Task<bool> SaveAllAsync()
    {
        return await _dataContext.SaveChangesAsync() > 0;
    }
}
