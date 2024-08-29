using System;
using API.DTOs;

namespace API.Services.Contracts;

public interface IPhotoService
{
    Task<PhotoUrlDto> UpdateDriverProfile(IFormFile photo);
    Task<bool> DeleteDriverProfile();
}
