using API.DTOs;
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
        public async Task<ActionResult<ChatDto>> GetClientChatByIds(int driverId)
        {
            var chat = await _chatService.GetClientChatByIds(driverId);
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
    }
}
