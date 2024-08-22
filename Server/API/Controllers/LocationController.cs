using API.DTOs;
using API.Services.Contracts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Authorize]
    public class LocationController(
        ILocationService locationService
    ) : BaseController
    {
        private readonly ILocationService _locationService = locationService;

        [HttpPut("driver")]
        public async Task<ActionResult<LocationDto>> UpdateDriver(LocationDto locationDto)
        {
            var location = await _locationService.UpdateDriverLocation(locationDto);
            if (location == null) return BadRequest("Failed to update location.");
            return location;
        }

        [HttpPut("client")]
        public async Task<ActionResult<LocationDto>> UpdateClient(LocationDto locationDto)
        {
            var location = await _locationService.UpdateClientLocation(locationDto);
            if (location == null) return BadRequest("Failed to update location.");
            return location;
        }
    }
}
