using System;
using API.DTOs;
using API.Entities;
using API.Repositories.DtoRepositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories.DtoRepositories;

public class RideDtoRepository(
    DataContext dataContext
) : IRideDtoRepository
{
    private readonly DataContext _dataContext = dataContext;

    public async Task<List<ActiveRideCardDto>> GetActiveRides(int driverId)
    {
        return await _dataContext.Rides
            .Where(r => r.DriverId == driverId && r.RideStatus == RideStatus.Active)
            .Select(ride => new ActiveRideCardDto
            {
                Id = ride.Id,
                ClientId = ride.ClientId,
                Latitude = ride.StartLatitude,
                Longitude = ride.StartLongitude,
                Location = ride.Origin,
                Passengers = ride.Passengers,
                Username = ride.Client.Username,
                CreatedAt = ride.CreatedAt,
            })
            .ToListAsync();
    }
}
