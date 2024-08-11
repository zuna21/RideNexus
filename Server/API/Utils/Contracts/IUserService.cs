using System;

namespace API.Utils.Contracts;

public interface IUserService
{
    Task<Driver> GetDriver();

}
