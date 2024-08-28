
using Microsoft.EntityFrameworkCore;

namespace API;

public class DriverRepository(
    DataContext dataContext
) : IDriverRepository
{
    private readonly DataContext _dataContext = dataContext;

    public async Task<Driver> FindById(int id)
    {
        return await _dataContext.Drivers.FindAsync(id);
    }

    public async Task<Driver> GetByUsername(string username)
    {
        return await _dataContext.Drivers.FirstOrDefaultAsync(
            x => string.Equals(x.Username, username.ToLower())
        );
    }

    public async Task<bool> IsUsernameTaken(string username)
    {
        return await _dataContext.Drivers.AnyAsync(d => string.Equals(d.Username, username.ToLower()));
    }

    public void Register(Driver driver)
    {
        _dataContext.Drivers.Add(driver);
    }

    public async Task<bool> SaveAllAsync()
    {
        return await _dataContext.SaveChangesAsync() > 0;
    }
}
