using API.Entities;
using API.Repositories.Contracts;
using Microsoft.EntityFrameworkCore;

namespace API.Repositories;

public class CarRepository(
    DataContext dataContext
) : ICarRepository
{
    private readonly DataContext _dataContext = dataContext;

    public void Add(Car car)
    {
        _dataContext.Cars.Add(car);
    }

    public void Delete(Car car)
    {
        _dataContext.Cars.Remove(car);
    }

    public async Task<Car> FindById(int id)
    {
        return await _dataContext.Cars.FindAsync(id);
    }

    public async Task<bool> SaveAllAsync()
    {
        return await _dataContext.SaveChangesAsync() > 0;
    }

    public async Task<Car> GetDriverActiveCar(int driverId)
    {
        return await _dataContext.Drivers
            .Where(driver => driver.Id == driverId)
            .Select(driver => driver.Cars
                .FirstOrDefault(car => car.IsActive)
            )
            .FirstOrDefaultAsync();
    }

    public async Task<List<Car>> GetAll(int driverId)
    {
        return await _dataContext.Cars
            .Where(car => car.DriverId == driverId)
            .ToListAsync();
    }
}
