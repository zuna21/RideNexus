namespace API;

public static class DriverMapper
{
    public static Driver RegisterDriverDtoToDriver(RegisterDriverDto registerDriverDto) 
    {
        return new Driver
        {
            Username = registerDriverDto.Username,
            FirstName = registerDriverDto.FirstName,
            LastName = registerDriverDto.LastName,
            Phone = registerDriverDto.Phone,
            Price = registerDriverDto.Price,
        };
    }

    public static DriverDto DriverToDriverDto(Driver driver)
    {
        return new DriverDto
        {
            Id = driver.Id,
            Username = driver.Username,
        };
    }
}
