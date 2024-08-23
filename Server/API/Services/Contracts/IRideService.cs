using System;
using API.DTOs;

namespace API.Services.Contracts;

public interface IRideService
{
    Task<bool> Create(CreateRideDto createRideDto);
}
