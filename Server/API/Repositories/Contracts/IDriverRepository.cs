namespace API;

public interface IDriverRepository
{
    void Register(Driver driver);
    Task<Driver> GetByUsername(string username);
    Task<bool> SaveAllAsync();
}
