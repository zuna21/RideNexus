using System;

namespace API.Entities;

public class Car
{
    public int Id { get; set;}
    public int DriverId { get; set;}
    public string Make { get; set; }
    public string Model { get; set; }
    public string RegistrationNumber { get; set; }
    public bool IsActive { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public Driver Driver { get; set; }
    public List<Ride> Rides { get; set; }
}
