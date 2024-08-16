using System;
using API.Repositories.DtoRepositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories.DtoRepositories;

public class DriverDtoRepository(
    DataContext dataContext
) : IDriverDtoRepository
{
    private readonly DataContext _dataContext = dataContext;

    public async Task<List<DriverCardDto>> GetAll()
    {
        return await _dataContext.Drivers
            .Select(driver => new DriverCardDto
            {
                Id = driver.Id,
                FullName = $"{driver.LastName} {driver.FirstName}",
                RatingCount = driver.Reviews.Count,
                Price = driver.Price,
                Car = driver.Cars
                        .Where(c => c.IsActive == true)
                        .Select(c => $"{c.Make} {c.Model}")
                        .FirstOrDefault(),
                Rating = driver.Reviews.Count == 0
                    ? 5
                    : driver.Reviews.Average(r => r.Rating)
            })
            .ToListAsync();
    }

    public async Task<DriverDetailsDto> GetDetails(int driverId)
    {
        return await _dataContext.Drivers
            .Where(driver => driver.Id == driverId)
            .Select(driver => new DriverDetailsDto
            {
                Id = driver.Id,
                Car = driver.Cars
                        .Where(car => car.IsActive == true)
                        .Select(car => $"{car.Make} {car.Model}")
                        .FirstOrDefault() ?? "",
                Phone = driver.Phone,
                Price = driver.Price,
                FullName = $"{driver.LastName} {driver.FirstName}",
                Rating = driver.Reviews.Count == 0
                    ? 5
                    : driver.Reviews.Average(r => r.Rating),
                RatingCount = driver.Reviews.Count,
                RegistrationNumber = driver.Cars
                    .Where(car => car.IsActive)
                    .Select(car => car.RegistrationNumber)
                    .FirstOrDefault() ?? "",
                Username = driver.Username
            })
            .FirstOrDefaultAsync();
    }
}
