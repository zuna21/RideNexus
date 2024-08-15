namespace API;

public interface IAuthService
{
    string GenerateToken(string username);
}
