using System;

namespace API.DTOs;

public class RideDto
{

}

public class CreateRideDto 
{
    public int DriverId { get; set; }
    public int Passengers { get; set; }
}

public class ActiveRideCardDto
{
    public int Id { get; set; }
    public int ClientId { get; set; }
    public string Username { get; set; }
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public string Location { get; set; }
    public int Passengers { get; set; }
    public DateTime CreatedAt { get; set; }
}