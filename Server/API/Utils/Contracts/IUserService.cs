using System;
using API.Entities;

namespace API.Utils.Contracts;

public interface IUserService
{
    Task<Driver> GetDriver();
    Task<Client> GetClient();

}
