using System;
using API.Entities;
using API.Repositories.Contracts;

namespace API.Repositories;

public class RideRepository(
    DataContext dataContext
) : IRideRepository
{
    private readonly DataContext _dataContext = dataContext;

    public void Add(Ride ride)
    {
        _dataContext.Rides.Add(ride);
    }

    public async Task<Ride> GetById(int id)
    {
        return await _dataContext.Rides.FindAsync(id);
    }

    public async Task<bool> SaveAllAsync()
    {
        return await _dataContext.SaveChangesAsync() > 0;
    }
}
