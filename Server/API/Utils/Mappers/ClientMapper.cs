using System;
using API.DTOs;
using API.Entities;

namespace API.Utils.Mappers;

public static class ClientMapper
{
    public static ClientDto ClientToClientDto(Client client)
    {
        return new ClientDto
        {
            Id = client.Id,
            Username= client.Username,
        };
    }
}
