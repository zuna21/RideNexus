using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Repositories.DtoRepositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;
using API.Entities.Enums;

namespace API.Services;

public class ChatService(
    IChatRepository chatRepository,
    IUserService userService,
    IDriverRepository driverRepository,
    IChatDtoRepository chatDtoRepository,
    IMessageRepository messageRepository
) : IChatService
{
    private readonly IChatRepository _chatRepository = chatRepository;
    private readonly IUserService _userService = userService;
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly IChatDtoRepository _chatDtoRepository = chatDtoRepository;
    private readonly IMessageRepository _messageRepository = messageRepository;

    public async Task<ChatDto> GetClientChatByIds(int driverId)
    {
        var client = await _userService.GetClient();
        if (client == null) return null;

        var isChatCreated = await _chatRepository.IsChatCreated(client.Id, driverId);
        if (!isChatCreated)
        {
            var driver = await _driverRepository.FindById(driverId);
            if (driver == null) return null;
            Chat createdChat = new()
            {
                ClientId = client.Id,
                Client = client,
                DriverId = driver.Id,
                Driver = driver,
                IsSeenDriver = false,
                IsSeenUser = true
            };

            _chatRepository.Create(createdChat);
            if (!await _chatRepository.SaveAllAsync()) return null;
        }        

        return await _chatDtoRepository.GetClientChatByIds(client.Id, driverId); 
    }

    public async Task<MessageDto> SendMessageClient(int chatId, CreateMessageDto createMessageDto)
    {
        var client = await _userService.GetClient();
        if (client == null) return null;
        var chat = await _chatRepository.GetById(chatId);
        if (chat == null) return null;

        Message message= new()
        {
            ChatId = chat.Id,
            Chat = chat,
            Content = createMessageDto.Content,
            CreatorId = client.Id,
            CreatorType = CreatorType.Client
        };

        _messageRepository.Create(message);
        if (!await _messageRepository.SaveAllAsync()) return null;

        return new MessageDto
        {
            Id = message.Id,
            Content = message.Content,
            IsMine = true,
            CreatedAt = message.CreatedAt,
        };
    }
}
