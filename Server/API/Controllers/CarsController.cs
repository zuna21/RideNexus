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
        ICarService carService
    ) : BaseController
    {
        private readonly ICarService _carService = carService;

        
        [HttpPost]
        public async Task<ActionResult<CarDto>> Create(CreateCarDto createCarDto)
        {
            var car = await _carService.Create(createCarDto);
            if (car == null) return BadRequest("Something went wrong.");
            return car;
        }

        [HttpGet]
        public async Task<ActionResult<List<CarDto>>> GetAll()
        {
            var cars = await _carService.GetAll();
            if (cars == null) return BadRequest("Something went wrong.");
            return Ok(cars);
        }

        [HttpGet("{carId}")]
        public async Task<ActionResult<CarDto>> Get(int  carId)
        {
            var car = await _carService.Get(carId);
            if (car == null) return BadRequest("Something went wrong.");
            return car;
        }

        [HttpPut("{carId}")]
        public async Task<ActionResult<CarDto>> Update(int carId, CreateCarDto createCarDto)
        {
            var car = await _carService.Update(carId, createCarDto);
            if (car == null) return BadRequest("Something went wrong.");
            return car;
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<int>> Delete(int id)
        {
            var carId = await _carService.Delete(id);
            if (carId == -1) return BadRequest("Failed to delete car.");
            return carId;
        }
    }
}
