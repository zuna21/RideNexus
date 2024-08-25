using System;
using API.DTOs;

namespace API.Services.Contracts;

public interface IRideService
{
    Task<bool> Create(CreateRideDto createRideDto);
    Task<List<ActiveRideCardDto>> GetActiveRides();
    Task<int> Decline(int rideId);
}
