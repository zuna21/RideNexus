using System;
using API.DTOs;
using API.Services.Contracts;
using API.Utils.Contracts;

namespace API.Services;

public class LocationService(
    IUserService userService,
    IDriverRepository driverRepository
) : ILocationService
{
    private readonly IUserService _userService = userService;
    private readonly IDriverRepository _driverRepository = driverRepository;
    public async Task<LocationDto> UpdateDriverLocation(LocationDto location)
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;

        driver.Latitude = location.Latitude;
        driver.Longitude = location.Longitude;
        driver.Location = location.Location;

        await _driverRepository.SaveAllAsync();
        return new LocationDto
        {
            Latitude = driver.Latitude,
            Longitude = driver.Longitude,
            Location = driver.Location
        };
    }   
}
