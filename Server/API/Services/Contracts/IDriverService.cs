namespace API;

public interface IDriverService
{
    Task<DriverDto> Register(RegisterDriverDto registerDriverDto);
    Task<DriverDto> Login(LoginDriverDto loginDriverDto);
    Task<List<DriverCardDto>> GetAllCards();
    Task<DriverDetailsDto> GetDetails(int driverId);
}
