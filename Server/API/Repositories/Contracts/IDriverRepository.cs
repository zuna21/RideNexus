namespace API;

public interface IDriverRepository
{
    void Register(Driver driver);
    Task<Driver> GetByUsername(string username);
    Task<bool> IsUsernameTaken(string username);
    Task<Driver> FindById(int id);
    Task<bool> SaveAllAsync();
}
