using System;
using API.DTOs;
using API.Entities;

namespace API.Repositories.Contracts;

public interface ICarRepository
{
    void Add(Car car);
    void Delete(Car car);
    Task<Car> FindById(int id);
    Task<List<Car>> GetAll(int driverId);
    Task<Car> GetDriverActiveCar(int driverId);
    Task<bool> SaveAllAsync();
}
