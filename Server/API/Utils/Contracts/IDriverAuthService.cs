namespace API;

public interface IDriverAuthService
{
    string GenerateToken(Driver driver);
}
