using API.DTOs;
using API.Services.Contracts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Authorize]
    public class RidesController(
        IRideService rideService
    ) : BaseController
    {
        private readonly IRideService _rideService = rideService;

        [HttpPost]
        public async Task<ActionResult<bool>> Create(CreateRideDto createRideDto)
        {
            var ride = await _rideService.Create(createRideDto);
            return Ok(ride);
        }
    }
}
