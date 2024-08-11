using System;
using API.DTOs;
using API.Entities;

namespace API.Utils.Mappers;

public static class CarMapper
{
    public static Car CreateCarDtoToCar(CreateCarDto createCarDto)
    {
        return new Car
        {
            IsActive = createCarDto.IsActive,
            Make = createCarDto.Make,
            Model = createCarDto.Model,
            RegistrationNumber = createCarDto.RegistrationNumber,
        };
    }

    public static CarDto CarToCarDto(Car car)
    {
        return new CarDto
        {
            Id = car.Id,
            Make = car.Make,
            Model = car.Model,
            RegistrationNumber = car.RegistrationNumber,
            IsActive = car.IsActive,
            CreatedAt = car.CreatedAt
        };
    }
}
