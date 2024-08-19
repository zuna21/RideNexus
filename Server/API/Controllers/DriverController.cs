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

}
