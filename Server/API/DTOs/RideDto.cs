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