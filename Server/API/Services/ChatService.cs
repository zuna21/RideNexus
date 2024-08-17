using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Repositories.DtoRepositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;

namespace API.Services;

public class ChatService(
    IChatRepository chatRepository,
    IUserService userService,
    IDriverRepository driverRepository,
    IChatDtoRepository chatDtoRepository
) : IChatService
{
    private readonly IChatRepository _chatRepository = chatRepository;
    private readonly IUserService _userService = userService;
    private readonly IDriverRepository _driverRepository = driverRepository;
    private readonly IChatDtoRepository _chatDtoRepository = chatDtoRepository;

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

    // Ova funkcija je privatna jer se koristi samo u ovom servisu
    private async Task<Chat> Create(Driver driver, Client client)
    {
        Chat chat = new()
        {
            ClientId = client.Id,
            Client = client,
            DriverId = driver.Id,
            Driver = driver,
        };

        _chatRepository.Create(chat);
        if (!await _chatRepository.SaveAllAsync()) return null;
        return chat;
    }
}
