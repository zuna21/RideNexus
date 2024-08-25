using System;
using API.Entities;

namespace API.Repositories.Contracts;

public interface IRideRepository
{
    void Add(Ride ride);
    Task<Ride> GetById(int id);
    Task<bool> SaveAllAsync();
}
