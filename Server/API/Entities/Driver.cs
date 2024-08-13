using API.Entities;

public class Driver 
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string FirstName { get; set; }   
    public string LastName { get; set; }    
    public string Phone { get; set; }
    public string Password { get; set; }
    public bool IsWork { get; set; } = false;
    public double Price { get; set; } = 0;
    public double Latitude { get; set; } = 0;
    public double Longitude { get; set; } = 0;
    public string Location { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public List<Car> Cars { get; set; } = [];
}