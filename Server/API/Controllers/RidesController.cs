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

        [HttpGet("active-rides")]
        public async Task<ActionResult<List<ActiveRideCardDto>>> GetActiveRides()
        {
            var rides = await _rideService.GetActiveRides();
            if (rides == null) return BadRequest("Something went wrong.");
            return Ok(rides);
        }

        [HttpGet("decline/{rideId}")]
        public async Task<ActionResult<int>> Decline(int rideId)
        {
            var declinedRide = await _rideService.Decline(rideId);
            if (declinedRide == -1) return BadRequest("Failed to decline.");
            return declinedRide;
        }

        [HttpGet("accept/{rideId}")]
        public async Task<ActionResult<bool>> Accept(int rideId)
        {
            var isAccepted = await _rideService.Accept(rideId);
            if (!isAccepted) return BadRequest("Failed to accept ride");
            return false;
        }

        [HttpPut("finish/{rideId}")]
        public async Task<ActionResult<bool>> Finish(int rideId, FinishRideDto finishRideDto)
        {
            var isRideFinished = await _rideService.Finish(rideId, finishRideDto);
            if (!isRideFinished) return BadRequest("Something went wrong.");
            return true;
        }
    }
}
