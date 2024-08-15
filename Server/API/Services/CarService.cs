using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Services.Contracts;
using API.Utils.Mappers;

namespace API.Services;

public class CarService(
    ICarRepository carRepository
) : ICarService
{
    private readonly ICarRepository _carRepository = carRepository;

    public async Task<CarDto> Create(CreateCarDto createCarDto, Driver driver)
    {
        Car car = CarMapper.CreateCarDtoToCar(createCarDto);
        car.Driver = driver;
        car.DriverId = driver.Id;

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

    public async Task<List<CarDto>> GetAll(Driver driver)
    {
        return await _carRepository.GetAll(driver.Id);
    }
}
