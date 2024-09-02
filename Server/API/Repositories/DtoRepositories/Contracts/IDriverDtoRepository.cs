using System;
using API.DTOs.Params;

namespace API.Repositories.DtoRepositories.Contracts;

public interface IDriverDtoRepository
{
    Task<List<DriverCardDto>> GetAll(DriversParams driversParams);
    Task<DriverDetailsDto> GetDetails(int driverId);
    Task<DriverAccountDetailsDto> GetAccountDetails(int driverId);
    Task<DriverUpdateBasicDetailsDto> GetAccountBasicDetails(int driverId);
    Task<DriverUpdateMainDetailsDto> GetAccountMainDetails(int driverId);
}
