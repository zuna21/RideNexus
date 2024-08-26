using System;
using API.Entities;
using API.Repositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories;

public class ClientRepository(
    DataContext dataContext
) : IClientRepository
{
    private readonly DataContext _dataContext = dataContext;

    public void Create(Client client)
    {
        _dataContext.Clients.Add(client);
    }

    public async Task<Client> FindByUsername(string username)
    {
        return await _dataContext.Clients
            .FirstOrDefaultAsync(x => string.Equals(x.Username, username.ToLower()));
    }

    public async Task<Client> GetById(int clientId)
    {
        return await _dataContext.Clients.FindAsync(clientId);
    }

    public async Task<bool> SaveAllAsync()
    {
        return await _dataContext.SaveChangesAsync() > 0;
    }
}
