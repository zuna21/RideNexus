using API.DTOs;
using API.Services.Contracts;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    public class RidesController(
        IRideService rideService
    ) : BaseController
    {
        private readonly IRideService _rideService = rideService;

        [HttpPost("{driverId}")]
        public async Task<ActionResult<bool>> Create(int driverId, CreateRideDto createRideDto)
        {
            var ride = await _rideService.Create(driverId, createRideDto);
            return Ok(ride);
        }
    }
}
