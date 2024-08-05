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

    [HttpGet("test")]
    public void Test() 
    {
        Console.WriteLine("**********");
        Console.WriteLine(_config.GetValue<string>("TokenKey"));
        Console.WriteLine("**********");
    }

}
