using System;
using API.DTOs;
using API.Entities;
using API.Repositories.Contracts;
using API.Services.Contracts;
using API.Utils.Contracts;
using API.Utils.Mappers;
using Microsoft.AspNetCore.Identity;

namespace API.Services;

public class ClientService(
    IClientRepository clientRepository,
    IAuthService authService,
    IUserService userService
) : IClientService
{
    private readonly IClientRepository _clientRepository = clientRepository;
    private readonly IAuthService _authService = authService;
    private readonly IUserService _userService = userService;

    public async Task<ClientDto> Login(LoginClientDto loginClientDto)
    {
        var client = await _clientRepository.FindByUsername(loginClientDto.Username.ToLower());
        if (client == null) return null;
        var result = PasswordManager.VerifyClientPassword(client, loginClientDto.Password);
        if (result == PasswordVerificationResult.Failed) return null;
        var clientDto = ClientMapper.ClientToClientDto(client);
        clientDto.Token = _authService.GenerateToken(client.Username);
        return clientDto;
    }

    public async Task<ClientDto> Register(RegisterClientDto registerClientDto)
    {
        if (!PasswordManager.ArePasswordsEqual(registerClientDto.Password, registerClientDto.ConfirmPassword)) return null;
        
        Client client = new Client
        {
            Username = registerClientDto.Username.ToLower()
        };

        client.Password = PasswordManager.HashClientPassword(client, registerClientDto.Password);
        _clientRepository.Create(client);

        if(!await _clientRepository.SaveAllAsync()) return null;
        return ClientMapper.ClientToClientDto(client);
    }

    public async Task<bool> UpdateFCMToken(FCMDto fCMDto)
    {
        var client = await _userService.GetClient();
        if (client == null) return false;

        client.FCMToken = fCMDto.Token;
        await _clientRepository.SaveAllAsync();

        return true;
    }
}
