using System;

namespace API.DTOs;

public class RideDto
{

}

public class CreateRideDto 
{
    public double StartLatitude { get; set; }
    public double StartLongitude { get; set; }
    public string Origin { get; set; }
    public int Passengers { get; set; }
}