
namespace API;

using System.Collections.Generic;
using API.Repositories.DtoRepositories.Contracts;
using Microsoft.AspNetCore.Identity;

public class DriverService(
    IDriverRepository driverRepository,
    IAuthService authService,
    IDriverDtoRepository driverDtoRepository
) : IDriverService
{
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly IAuthService _authService = authService;
    private readonly IDriverDtoRepository _driverDtoRepository = driverDtoRepository;

    public async Task<List<DriverCardDto>> GetAllCards()
    {
        return await _driverDtoRepository.GetAll();
    }

    public async Task<DriverDetailsDto> GetDetails(int driverId)
    {
        return await _driverDtoRepository.GetDetails(driverId);
    }

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
