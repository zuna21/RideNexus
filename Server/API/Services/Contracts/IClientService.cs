using System;
using API.DTOs;

namespace API.Services.Contracts;

public interface IClientService
{
    Task<ClientDto> Register(RegisterClientDto registerClientDto);
    Task<ClientDto> Login(LoginClientDto loginClientDto);
    Task<bool> UpdateFCMToken(FCMDto fCMDto);
}
