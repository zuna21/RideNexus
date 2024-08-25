using System;
using API.DTOs;

namespace API.Repositories.DtoRepositories.Contracts;

public interface IRideDtoRepository
{
    Task<List<ActiveRideCardDto>> GetActiveRides(int driverId);
}
