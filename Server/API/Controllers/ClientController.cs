using API.DTOs;
using API.Services.Contracts;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    public class ClientController(
        IClientService clientService
    ) : BaseController
    {
        private readonly IClientService _clientService = clientService;

        [HttpPost("register")]
        public async Task<ActionResult<ClientDto>> Register(RegisterClientDto registerClientDto)
        {
            var client = await _clientService.Register(registerClientDto);
            if (client == null) return BadRequest("Failed to register user.");
            return client;
        }

        [HttpPost("login")]
        public async Task<ActionResult<ClientDto>> Login(LoginClientDto loginClientDto)
        {
            var client = await _clientService.Login(loginClientDto);
            if (client == null) return BadRequest("Failed to login client");
            return client;
        }
    }
}
