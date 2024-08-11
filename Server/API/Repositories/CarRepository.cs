using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories;

public class CarRepository(
    DataContext dataContext
) : ICarRepository
{
    private readonly DataContext _dataContext = dataContext;

    public void Add(Car car)
    {
        _dataContext.Cars.Add(car);
    }

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

    public async Task<bool> SaveAllAsync()
    {
        return await _dataContext.SaveChangesAsync() > 0;
    }
}
