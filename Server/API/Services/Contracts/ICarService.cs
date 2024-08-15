using System;
using API.DTOs;

namespace API.Services.Contracts;

public interface ICarService
{
    Task<CarDto> Create(CreateCarDto createCarDto, Driver driver);
    Task<int> Delete(int carId);
    Task<List<CarDto>> GetAll(Driver driver);
}
