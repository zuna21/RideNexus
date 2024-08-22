using System;

namespace API.Entities;

public class Ride
{
    public int Id { get; set;}
    public int DriverId { get; set;}
    public int ClientId { get; set;}
    public int CarId { get; set;}
    public double StartLatitude { get; set; }
    public double StartLongitude { get; set; }
    public string Origin { get; set; }
    public double EndLatitude { get; set; }
    public double EndLongitude { get; set; }
    public string Destination { get; set; }
    public string Duration { get; set; }
    public RideStatus RideStatus { get; set; } = RideStatus.Active;
    public double Price { get; set; }
    public int Passengers { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public Driver Driver { get; set; }
    public Client Client { get; set; }
    public Car Car { get; set; }
}

public enum RideStatus
{
    Active,
    Declined,
    Finished
}