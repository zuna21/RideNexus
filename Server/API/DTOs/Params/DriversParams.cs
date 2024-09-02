using System;

namespace API.DTOs.Params;

// defaultno je autobuska stanica Doboj
public class DriversParams : BasicParams
{
    public double Latitude { get; set; } = 44.727549;
    public double Longitude { get; set; } = 18.090244;
}
