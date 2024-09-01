using System;
using API.DTOs;

namespace API.Services.Contracts;

public interface ICarService
{
    Task<CarDto> Create(CreateCarDto createCarDto);
    Task<int> Delete(int carId);
    Task<List<CarDto>> GetAll();
    Task<CarDto> Get(int carId);
    Task<CarDto> Update(int carId, CreateCarDto createCarDto);
}
