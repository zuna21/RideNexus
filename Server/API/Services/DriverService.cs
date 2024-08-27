
namespace API;

using System.Collections.Generic;
using API.DTOs;
using API.Repositories.DtoRepositories.Contracts;
using API.Utils.Contracts;
using Microsoft.AspNetCore.Identity;

public class DriverService(
    IDriverRepository driverRepository,
    IAuthService authService,
    IDriverDtoRepository driverDtoRepository,
    IUserService userService
) : IDriverService
{
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly IAuthService _authService = authService;
    private readonly IDriverDtoRepository _driverDtoRepository = driverDtoRepository;
    private readonly IUserService _userService = userService;

    public async Task<DriverUpdateBasicDetailsDto> GetAccountBasicDetails()
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;
        return await _driverDtoRepository.GetAccountBasicDetails(driver.Id);
        
    }

    public async Task<DriverAccountDetailsDto> GetAccountDetails()
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;
        return await _driverDtoRepository.GetAccountDetails(driver.Id);
    }

    public async Task<DriverUpdateMainDetailsDto> GetAccountMainDetails()
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;
        return await _driverDtoRepository.GetAccountMainDetails(driver.Id);
    }

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

    public async Task<bool> UpdateAccountBasicDetails(DriverUpdateBasicDetailsDto driverUpdateBasicDetails)
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return false;

        driver.FirstName = driverUpdateBasicDetails.FirstName;
        driver.LastName = driverUpdateBasicDetails.LastName;
        driver.Phone = driverUpdateBasicDetails.Phone;
        driver.HasPrice = driverUpdateBasicDetails.HasPrice;
        driver.Price = driverUpdateBasicDetails.HasPrice
            ? driverUpdateBasicDetails.Price
            : 0;

        await _driverRepository.SaveAllAsync();
        return true;
    }

    public async Task<bool> UpdateFCMToken(FCMDto fCMDto)
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return false;

        driver.FCMToken = fCMDto.Token;
        await _driverRepository.SaveAllAsync();
        return true;
    }
}
