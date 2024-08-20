using System;
using API.DTOs;

namespace API.Services.Contracts;

public interface ILocationService
{
    Task<LocationDto> UpdateDriverLocation(LocationDto location);
}
