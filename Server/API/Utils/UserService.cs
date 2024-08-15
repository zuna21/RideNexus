using System;
using API.Entities;
using API.Repositories.Contracts;
using API.Utils.Contracts;

namespace API.Utils;

public class UserService(
        IHttpContextAccessor httpContextAccessor,
        IDriverRepository driverRepository,
        IClientRepository clientRepository
) : IUserService
{
    private readonly IHttpContextAccessor _httpContext = httpContextAccessor;
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly IClientRepository _clientRepository = clientRepository;

    public async Task<Client> GetClient()
    {
        var username = _httpContext.HttpContext.User.Identity.Name;
        if (username == null) return null;
        var client = await _clientRepository.FindByUsername(username);
        return client;
    }

    public async Task<Driver> GetDriver()
    {
        var username = _httpContext.HttpContext.User.Identity.Name;
        if (username == null) return null;
        var driver = await _driverRepository.GetByUsername(username);
        return driver;
    }
}
