using System;

namespace API.Repositories.DtoRepositories.Contracts;

public interface IDriverDtoRepository
{
    Task<List<DriverCardDto>> GetAll();
    Task<DriverDetailsDto> GetDetails(int driverId);
    Task<DriverAccountDetailsDto> GetAccountDetails(int driverId);
    Task<DriverUpdateBasicDetails> GetAccountBasicDetails(int driverId);
}
