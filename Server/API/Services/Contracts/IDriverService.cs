using API.DTOs;
using API.DTOs.Params;

namespace API;

public interface IDriverService
{
    Task<DriverDto> Register(RegisterDriverDto registerDriverDto);
    Task<DriverDto> Login(LoginDriverDto loginDriverDto);
    Task<DriverAccountDetailsDto> GetAccountDetails();
    Task<List<DriverCardDto>> GetAllCards(DriversParams driversParams);
    Task<bool> UpdateFCMToken(FCMDto fCMDto);
    Task<DriverDetailsDto> GetDetails(int driverId);
    Task<DriverUpdateBasicDetailsDto> GetAccountBasicDetails();
    Task<bool> UpdateAccountBasicDetails(DriverUpdateBasicDetailsDto driverUpdateBasicDetails);
    Task<DriverUpdateMainDetailsDto> GetAccountMainDetails();
    Task<bool> UpdateAccountMainDetails(DriverUpdateMainDetailsDto driverUpdateMainDetailsDto);
}
