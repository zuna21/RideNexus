using System;
using API.Repositories.DtoRepositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories.DtoRepositories;

public class DriverDtoRepository(
    DataContext dataContext
) : IDriverDtoRepository
{
    private readonly DataContext _dataContext = dataContext;

    public async Task<DriverUpdateBasicDetailsDto> GetAccountBasicDetails(int driverId)
    {
        return await _dataContext.Drivers
            .Where(d => d.Id == driverId)
            .Select(d => new DriverUpdateBasicDetailsDto
            {
                Id = d.Id,
                FirstName = d.FirstName,
                LastName = d.LastName,
                HasPrice = d.HasPrice,
                Phone = d.Phone,
                Price = d.Price,
                ImageUrl = d.ImageUrl,
            })
            .FirstOrDefaultAsync();
    }

    public async Task<DriverAccountDetailsDto> GetAccountDetails(int driverId)
    {
        return await _dataContext.Drivers
            .Where(driver => driver.Id == driverId)
            .Select(driver => new DriverAccountDetailsDto
            {
                Id = driver.Id,
                FullName = $"{driver.LastName} {driver.FirstName}",
                Username = driver.Username,
                Price = driver.Price,
                UnseenChats = driver.Chats
                    .Where(chat => chat.IsSeenDriver == false)
                    .Count(),
                Rating = driver.Reviews.Count == 0 
                    ? 5
                    : driver.Reviews.Average(review => review.Rating),
                RatingCount = driver.Reviews.Count,
                HasPrice = driver.HasPrice,
                Location = driver.Location,
                ProfilePhotoUrl = driver.ImageUrl,
            })
            .FirstOrDefaultAsync();
    }

    public async Task<DriverUpdateMainDetailsDto> GetAccountMainDetails(int driverId)
    {
        return await _dataContext.Drivers
            .Where(d => d.Id == driverId)
            .Select(d => new DriverUpdateMainDetailsDto
            {
                Username = d.Username,
                ChangePassword = false,
                NewPassword = null,
                OldPassword = null,
                RepeatNewPassword = null
            })
            .FirstOrDefaultAsync();
    }

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
                    : driver.Reviews.Average(r => r.Rating),
                Location = driver.Location
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
                Username = driver.Username,
                Location = driver.Location
            })
            .FirstOrDefaultAsync();
    }
}
