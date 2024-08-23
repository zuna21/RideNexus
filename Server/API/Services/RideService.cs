using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;
using FirebaseAdmin.Messaging;

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

    public async Task<bool> Create(CreateRideDto createRideDto)
    {
        var client = await _userService.GetClient();
        if (client == null) return false;
        var driver = await _driverRepository.FindById(createRideDto.DriverId);
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
            StartLatitude = client.Latitude,
            StartLongitude = client.Longitude,
            Origin = client.Location,
            Passengers = createRideDto.Passengers,
            RideStatus = RideStatus.Active
        };

        FirebaseAdmin.Messaging.Message message = new()
        {
            Notification = new FirebaseAdmin.Messaging.Notification
            {
                Title = "Imate novu vožnju 🚗",
                Body = $"Korisnik {client.Username} trazi vožnju za {ride.Passengers} osoba. Iz mjesta {ride.Origin}."
            },
            Token = driver.FCMToken
        };

        var messaging = FirebaseMessaging.DefaultInstance;
        var result = await messaging.SendAsync(message);

        if (string.IsNullOrEmpty(result)) return false;

        return true;

    }
}
