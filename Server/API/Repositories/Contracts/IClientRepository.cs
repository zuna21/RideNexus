using System;
using API.Entities;

namespace API.Repositories.Contracts;

public interface IClientRepository
{
    void Create(Client client);
    Task<Client> FindByUsername(string username);
    Task<bool> SaveAllAsync();
}
