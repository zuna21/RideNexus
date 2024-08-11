using System;
using API.Utils.Contracts;

namespace API.Utils;

public class UserService(
        IHttpContextAccessor httpContextAccessor,
        IDriverRepository driverRepository
) : IUserService
{
    private readonly IHttpContextAccessor _httpContext = httpContextAccessor;
    private readonly IDriverRepository _driverRepository = driverRepository;

    public async Task<Driver> GetDriver()
    {
        var username = _httpContext.HttpContext.User.Identity.Name;
        if (username == null) return null;
        var driver = await _driverRepository.GetByUsername(username);
        return driver;
    }
}
