using API.DTOs;

namespace API;

public interface IDriverService
{
    Task<DriverDto> Register(RegisterDriverDto registerDriverDto);
    Task<DriverDto> Login(LoginDriverDto loginDriverDto);
    Task<DriverAccountDetailsDto> GetAccountDetails();
    Task<List<DriverCardDto>> GetAllCards();
    Task<bool> UpdateFCMToken(FCMDto fCMDto);
    Task<DriverDetailsDto> GetDetails(int driverId);
}
