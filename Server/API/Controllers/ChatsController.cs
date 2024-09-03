using API.DTOs;
using API.DTOs.Params;
using API.Services.Contracts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{   
    [Authorize]
    public class ChatsController(
        IChatService chatService
    ) : BaseController
    {
        private readonly IChatService _chatService = chatService;

        [HttpGet("{driverId}")]
        public async Task<ActionResult<ChatDto>> GetClientChatByIds(int driverId, [FromQuery] BasicParams basicParams)
        {
            var chat = await _chatService.GetClientChatByIds(driverId, basicParams);
            if (chat == null) return BadRequest("Failed to get chat");
            return chat;
        }

        [HttpPost("send-client/{chatId}")]
        public async Task<ActionResult<MessageDto>> SendClient(int chatId, CreateMessageDto createMessageDto)
        {
            var message = await _chatService.SendMessageClient(chatId, createMessageDto);
            if (message == null) return BadRequest("Failed to send message.");
            return message;
        }

        [HttpPost("send-driver/{chatId}")]
        public async Task<ActionResult<MessageDto>> SendDriver(int chatId, CreateMessageDto createMessageDto)
        {
            var message = await _chatService.SendMessageDriver(chatId, createMessageDto);
            if (message == null) return BadRequest("Failed to send message");
            return message;
        }

        [HttpGet("driver-chats")]
        public async Task<ActionResult<List<ChatCardDto>>> GetDriverChats([FromQuery] BasicParams basicParams)
        {
            var chats = await _chatService.GetDriverChats(basicParams);
            if (chats == null) return BadRequest("Failed to get chats");

            return Ok(chats);
        }

        [HttpGet("driver-chat/{chatId}")]
        public async Task<ActionResult<ChatDto>> GetDriverChat(int chatId, [FromQuery] BasicParams basicParams)
        {
            var chat = await _chatService.GetDriverChat(chatId, basicParams);
            if (chat == null) return BadRequest("Failed to get chat.");
            return chat;
        }
    }
}
