using System;
using API.DTOs;
using API.Services.Contracts;
using API.Utils;
using API.Utils.Contracts;

namespace API.Services;

public class PhotoService(
    IWebHostEnvironment webHostEnvironment,
    IUserService userService,
    IDriverRepository driverRepository
) : IPhotoService
{
    private readonly IWebHostEnvironment _webHost = webHostEnvironment;
    private readonly IUserService _userService = userService;
    private readonly IDriverRepository _driverRepository = driverRepository;

    public async Task<bool> DeleteDriverProfile()
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return false;

        if (string.IsNullOrEmpty(driver.ImagePath)) return false;

        var oldFilePath = Path.Combine(_webHost.WebRootPath, driver.ImagePath.Replace("/", "\\"));
        if (System.IO.File.Exists(oldFilePath))
        {
            System.IO.File.Delete(oldFilePath);
        }

        driver.ImagePath = null;
        driver.ImageUrl = null;

        await _driverRepository.SaveAllAsync();
        return true;
    }

    public async Task<PhotoUrlDto> UpdateDriverProfile(IFormFile photo)
    {
        var driver = await _userService.GetDriver();
        if (driver == null) return null;

        if (!string.IsNullOrEmpty(driver.ImagePath))
        {
            var oldFilePath = Path.Combine(_webHost.WebRootPath, driver.ImagePath.Replace("/", "\\"));
            if (System.IO.File.Exists(oldFilePath))
            {
                System.IO.File.Delete(oldFilePath);
            }
        }

        var savedImage = await Upload(photo);
        if (savedImage == null) return null;

        driver.ImageUrl = savedImage.ImageUrl;
        driver.ImagePath = savedImage.ImagePath;

        await _driverRepository.SaveAllAsync();
        return new PhotoUrlDto
        {
            ImageUrl = driver.ImageUrl
        };
    }

    private async Task<PhotoDto> Upload(IFormFile image)
    {
        var fileName = $"{Guid.NewGuid()}-{Path.GetFileName(image.FileName)}";
        var directoryName = DateTime.UtcNow.ToString("dd-MM-yyyy");
        var directoryPath = Path.Combine(_webHost.WebRootPath, "images", directoryName);
        var filePath = Path.Combine(directoryPath, fileName);

        if (!Directory.Exists(directoryPath))
        {
            Directory.CreateDirectory(directoryPath);
        }

        using var stream = new FileStream(filePath, FileMode.Create);
        await image.CopyToAsync(stream);

        return new PhotoDto
        {
            ImageUrl = Path.Combine("http://localhost:5000", "images", directoryName, fileName),
            ImagePath = Path.Combine("images", directoryName, fileName)
        };
    }
}
