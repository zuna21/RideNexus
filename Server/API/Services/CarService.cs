using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Repositories.DtoRepositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;
using API.Utils.Mappers;

namespace API.Services;

public class CarService(
    ICarRepository carRepository,
    ICarDtoRepository carDtoRepository,
    IUserService userService
) : ICarService
{
    private readonly ICarRepository _carRepository = carRepository;
    private readonly ICarDtoRepository _carDtoRepository = carDtoRepository;
    private readonly IUserService _userService = userService;

    public async Task<CarDto> Create(CreateCarDto createCarDto)
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;

        Car car = CarMapper.CreateCarDtoToCar(createCarDto);
        car.Driver = driver;
        car.DriverId = driver.Id;

        if (car.IsActive)
        {
            var otherCars = await _carRepository.GetAll(driver.Id);
            foreach (var otherCar in otherCars)
            {
                otherCar.IsActive = false;
            }
        }

        _carRepository.Add(car);
        if (!await _carRepository.SaveAllAsync()) return null;
        return CarMapper.CarToCarDto(car);
    }

    public async Task<int> Delete(int carId)
    {
        var car = await _carRepository.FindById(carId);
        if (car == null) return -1;
        _carRepository.Delete(car);
        if (!await _carRepository.SaveAllAsync()) return -1;
        return car.Id;

    }

    public async Task<CarDto> Get(int carId)
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;

        var car = await _carDtoRepository.GetById(carId);
        return car;
    }

    public async Task<List<CarDto>> GetAll()
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;

        return await _carDtoRepository.GetAll(driver.Id);
    }

    public async Task<CarDto> Update(int carId, CreateCarDto createCarDto)
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;
        var car = await _carRepository.FindById(carId);
        if (car == null) return null;

        car.Make = createCarDto.Make;
        car.Model = createCarDto.Model;
        car.RegistrationNumber = createCarDto.RegistrationNumber;

        if (createCarDto.IsActive)
        {
            var otherCars = await _carRepository.GetAll(driver.Id);
            foreach (var otherCar in otherCars)
            {
                otherCar.IsActive = false;
            }
        }

        car.IsActive = createCarDto.IsActive;
        await _carRepository.SaveAllAsync();
        return CarMapper.CarToCarDto(car);
    }
}
