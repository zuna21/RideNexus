using API.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API;

public class DriverController(
    IDriverService driverService,
    IConfiguration configuration
) : BaseController
{
    private readonly IDriverService _driverService = driverService;
    private readonly IConfiguration _config = configuration;

    [HttpPost("register")]
    public async Task<ActionResult<DriverDto>> Register(RegisterDriverDto registerDriverDto)
    {
        if (registerDriverDto == null) return BadRequest("Invalid form request");
        var driver = await _driverService.Register(registerDriverDto);
        if (driver == null) return BadRequest("Something went wrong.");
        return driver;
    }

    [HttpPost("login")]
    public async Task<ActionResult<DriverDto>> Login(LoginDriverDto loginDriverDto)
    {
        if (loginDriverDto == null) return BadRequest("Invalid form request.");
        var driver = await _driverService.Login(loginDriverDto);
        if (driver == null) return BadRequest("Something went wrong.");
        return driver;
    }

    [HttpGet]
    [Authorize]
    public async Task<ActionResult<List<DriverCardDto>>> GetAll()
    {
        var drivers = await _driverService.GetAllCards();
        return Ok(drivers);
    }

    [HttpGet("{id}")]
    [Authorize]
    public async Task<ActionResult<DriverDetailsDto>> GetDetails(int id)
    {
        var driver = await _driverService.GetDetails(id);
        if (driver == null) return NotFound();
        return driver;
    }

    [HttpGet("account-details")]
    [Authorize]
    public async Task<ActionResult<DriverAccountDetailsDto>> GetAccountDetails()
    {
        var driver = await _driverService.GetAccountDetails();
        if (driver == null) return NotFound();
        return driver;
    }

    [HttpPut("update-fcm-token")]
    [Authorize]
    public async Task<ActionResult<bool>> UpdateFcmToken(FCMDto fCMDto)
    {
        var isUpdated = await _driverService.UpdateFCMToken(fCMDto);
        if (isUpdated == false) return BadRequest("Failed to update fmc token.");
        return true;
    }

    [HttpGet("basic-account-details")]  
    [Authorize]
    public async Task<ActionResult<DriverUpdateBasicDetailsDto>> GetBasicAccountDetails()
    {
        var details = await _driverService.GetAccountBasicDetails();
        if (details == null) return BadRequest("Something went wrong.");
        return details;
    }

    [HttpPut("basic-account-details")]
    [Authorize]
    public async Task<ActionResult<bool>> UpdateBasicAccountDetails(DriverUpdateBasicDetailsDto driverUpdateBasicDetails)
    {
        var isUpdated = await _driverService.UpdateAccountBasicDetails(driverUpdateBasicDetails);
        if (isUpdated == false) return BadRequest("Failed to update account.");
        return true;
    }

    [HttpGet("main-account-details")]
    [Authorize]
    public async Task<ActionResult<DriverUpdateMainDetailsDto>> GetMainAccountDetails() 
    {
        var details = await _driverService.GetAccountMainDetails();
        if (details == null) return BadRequest("Failed to get main detals.");
        return details;
    }
}
