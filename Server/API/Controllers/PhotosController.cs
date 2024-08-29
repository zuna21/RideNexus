using API.DTOs;
using API.Services.Contracts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Authorize]
    public class PhotosController(
        IPhotoService photoService
    ) : BaseController
    {
        private readonly IPhotoService _photoService = photoService;

        [HttpPost("driver-profile")]
        public async Task<ActionResult<PhotoUrlDto>> PostDriverProfile()
        {

            var photo = Request.Form.Files[0];
            if (photo == null) return BadRequest("Please upload image.");
            var photoUploaded = await _photoService.UpdateDriverProfile(photo);
            if (photoUploaded == null) return BadRequest("Failed to upload image.");

            return photoUploaded;
        }

        [HttpDelete("driver-profile")]
        public async Task<ActionResult<bool>> DeleteDriverProfile()
        {
            var isDeleted = await _photoService.DeleteDriverProfile();
            if (isDeleted == false) return BadRequest("Failed to delete profile photo.");
            return true;
        }
    }
}
