
namespace API;

using Microsoft.AspNetCore.Identity;

public class DriverService(
    IDriverRepository driverRepository,
    IAuthService authService
) : IDriverService
{
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly IAuthService _authService = authService;

    public async Task<DriverDto> Login(LoginDriverDto loginDriverDto)
    {
        var driver = await _driverRepository.GetByUsername(loginDriverDto.Username);
        if (driver == null) return null;
        var result = PasswordManager.VerifyDriverPassword(driver, loginDriverDto.Password);
        if (result == PasswordVerificationResult.Failed) return null;
        var driverDto = DriverMapper.DriverToDriverDto(driver);
        driverDto.Token = _authService.GenerateToken(driver.Username);
        return driverDto;
    }

    public async Task<DriverDto> Register(RegisterDriverDto registerDriverDto)
    {
        if (!PasswordManager.ArePasswordsEqual(registerDriverDto.Password, registerDriverDto.ConfirmPassword)) return null;

        Driver driver = DriverMapper.RegisterDriverDtoToDriver(registerDriverDto);
        driver.Password = PasswordManager.HashDriverPassword(driver, registerDriverDto.Password);
        driver.Username = driver.Username.ToLower();
        
        _driverRepository.Register(driver);
        if (!await _driverRepository.SaveAllAsync())
        {
            return null;
        }
        return DriverMapper.DriverToDriverDto(driver);
    }
}
