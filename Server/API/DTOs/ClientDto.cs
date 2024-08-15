using System;

namespace API.DTOs;

public class ClientDto
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string Token { get; set; }
}


public class LoginClientDto
{
    public string Username { get; set; }
    public string Password { get; set; }
}

public class RegisterClientDto
{
    public string Username { get; set; }
    public string Password { get; set; }
    public string ConfirmPassword { get; set; }
}