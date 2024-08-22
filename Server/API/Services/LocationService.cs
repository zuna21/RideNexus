using System;
using API.DTOs;
using API.Repositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;

namespace API.Services;

public class LocationService(
    IUserService userService,
    IDriverRepository driverRepository,
    IClientRepository clientRepository
) : ILocationService
{
    private readonly IUserService _userService = userService;
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly IClientRepository _clientRepository = clientRepository;

    public async Task<LocationDto> UpdateClientLocation(LocationDto location)
    {
        var client = await _userService.GetClient();
        if (client == null) return null;

        client.Latitude = location.Latitude;
        client.Longitude = location.Longitude;
        client.Location = location.Location;

        await _clientRepository.SaveAllAsync();
        return new LocationDto
        {
            Latitude = client.Latitude,
            Longitude = client.Longitude,
            Location = client.Location
        };
    }

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
