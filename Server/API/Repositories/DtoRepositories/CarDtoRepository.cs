using System;
using API.DTOs;
using API.Repositories.DtoRepositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories.DtoRepositories;

public class CarDtoRepository(
    DataContext dataContext
) : ICarDtoRepository
{
    private readonly DataContext _dataContext = dataContext;

    public async Task<List<CarDto>> GetAll(int driverId)
    {
        return await _dataContext.Cars
            .Where(x => x.DriverId == driverId)
            .Select(x => new CarDto
            {
                Id = x.Id,
                CreatedAt = x.CreatedAt,
                IsActive = x.IsActive,
                Make = x.Make,
                Model = x.Model,
                RegistrationNumber = x.RegistrationNumber
            })
            .ToListAsync();
    }

    public async Task<CarDto> GetById(int id)
    {
        return await _dataContext.Cars
            .Select(x => new CarDto
            {
                Id = x.Id,
                Make = x.Make,
                Model = x.Model,
                IsActive = x.IsActive,
                RegistrationNumber = x.RegistrationNumber,
                CreatedAt = x.CreatedAt,
            })
            .FirstOrDefaultAsync(x => x.Id == id);
    }
}
