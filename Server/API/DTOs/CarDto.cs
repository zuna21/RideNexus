using System;

namespace API.DTOs;

public class CarDto
{
    public int Id { get; set; }
    public string Make { get; set; }
    public string Model { get; set; }
    public string RegistrationNumber { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class CreateCarDto 
{
    public string Make { get; set; }
    public string Model { get; set; }
    public string RegistrationNumber { get; set; }
    public bool IsActive { get; set; }
}
