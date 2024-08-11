using System.Security.Claims;
using API.DTOs;
using API.Services.Contracts;
using API.Utils.Contracts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Authorize]
    public class CarsController(
        ICarService carService,
        IUserService userService
    ) : BaseController
    {
        private readonly ICarService _carService = carService;
        private readonly IUserService _userService = userService;

        
        [HttpPost]
        public async Task<ActionResult<CarDto>> Create(CreateCarDto createCarDto)
        {
            var user = await _userService.GetDriver();
            if (user == null) return BadRequest("Something went wrong");
            var car = await _carService.Create(createCarDto, user);
            if (car == null) return BadRequest("Something went wrong.");
            return car;
        }

        [HttpGet]
        public async Task<ActionResult<List<CarDto>>> GetAll()
        {
            var driver = await _userService.GetDriver();
            if (driver == null) return BadRequest("Something went wrong");
            var cars = await _carService.GetAll(driver);
            return Ok(cars);
        }
    }
}
