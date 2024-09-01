using System;
using API.DTOs;

namespace API.Repositories.DtoRepositories.Contracts;

public interface ICarDtoRepository
{
    Task<List<CarDto>> GetAll(int driverId);
    Task<CarDto> GetById(int id);
}
