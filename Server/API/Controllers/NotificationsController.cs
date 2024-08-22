using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    public class NotificationsController : BaseController
    {
        [HttpPost]
        public ActionResult SendMessageAsync() 
        {
            // Implementation will be added here to handle sending push notifications
            return Ok("Push notification sent successfully!");
        }
    }
}
