using System;
using API.DTOs;

namespace API.Repositories.DtoRepositories.Contracts;

public interface IReviewDtoRepository
{
    Task<ReviewDetailsDto> GetReviewDetails(int driverId);
}
