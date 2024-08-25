using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Repositories.DtoRepositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;
using FirebaseAdmin.Messaging;

namespace API.Services;

public class RideService(
    IUserService userService,
    IDriverRepository driverRepository,
    ICarRepository carRepository,
    IRideRepository rideRepository,
    IRideDtoRepository rideDtoRepository
) : IRideService
{
    private readonly IUserService _userService = userService;
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly ICarRepository _carRepository = carRepository;
    private readonly IRideRepository _rideRepository = rideRepository;
    private readonly IRideDtoRepository _rideDtoRepository = rideDtoRepository;

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

        _rideRepository.Add(ride);
        if (!await _rideRepository.SaveAllAsync()) return false;

        // Trebalo bi takodjer provjeriti situaciju sta ako 
        // driver nema FCMToken
        FirebaseAdmin.Messaging.Message message = new()
        {
            Notification = new FirebaseAdmin.Messaging.Notification
            {
                Title = "Imate novu vožnju 🚗",
                Body = $"Korisnik {client.Username} trazi vožnju za {ride.Passengers} osoba. Iz mjesta {ride.Origin}."
            },
            Data = new Dictionary<string, string>()
            {
                ["NotificationType"] = "Ride"
            },
            Token = driver.FCMToken
        };

        var messaging = FirebaseMessaging.DefaultInstance;
        var result = await messaging.SendAsync(message);

        if (string.IsNullOrEmpty(result)) return false;

        return true;

    }

    public async Task<int> Decline(int rideId)
    {
        var ride = await _rideRepository.GetById(rideId);
        if (ride == null) return -1;
        
        ride.RideStatus = RideStatus.Declined;
        await _rideRepository.SaveAllAsync();
        return ride.Id;
    }

    public async Task<List<ActiveRideCardDto>> GetActiveRides()
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;
        return await _rideDtoRepository.GetActiveRides(driver.Id);
    }
}
