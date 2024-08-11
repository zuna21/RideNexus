using System;
using API.DTOs;
using API.Entities;

namespace API.Repositories.Contracts;

public interface ICarRepository
{
    void Add(Car car);
    Task<List<CarDto>> GetAll(int driverId);
    Task<bool> SaveAllAsync();
}
