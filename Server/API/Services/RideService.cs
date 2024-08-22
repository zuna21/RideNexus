using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;

namespace API.Services;

public class RideService(
    IUserService userService,
    IDriverRepository driverRepository,
    ICarRepository carRepository
) : IRideService
{
    private readonly IUserService _userService = userService;
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly ICarRepository _carRepository = carRepository;

    public async Task<bool> Create(int driverId, CreateRideDto createRideDto)
    {
        var client = await _userService.GetClient();
        if (client == null) return false; // Ovo ce vjerovatno vracati null, kasnije malo
        var driver = await _driverRepository.FindById(driverId);
        if (driver == null) return false;
        var car = await _carRepository.GetDriverActiveCar(driver.Id);
        if (car == null) return false;

        Ride ride = new()
        {
            DriverId = driver.Id,
            Driver = driver,
            ClientId = client.Id,
            Client = client,
            CarId = car.Id,
            Car = car,
            StartLatitude = createRideDto.StartLatitude,
            StartLongitude = createRideDto.StartLongitude,
            Origin = createRideDto.Origin,
            Passengers = createRideDto.Passengers,
            RideStatus = RideStatus.Active
        };

        Console.WriteLine(ride);
        return true;

    }
}
