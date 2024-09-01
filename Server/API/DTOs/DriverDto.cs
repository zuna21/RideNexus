public class DriverDto 
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string Token { get; set; }
}

public class RegisterDriverDto 
{
    public string Username { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Phone { get; set; }
    public string Password { get; set; }
    public string ConfirmPassword { get; set; }
    public double Price { get; set; }
    
}

public class LoginDriverDto
{
    public string Username { get; set; }
    public string Password { get; set; }
}

public class DriverCardDto
{
    public int Id { get; set; }
    public string FullName { get; set; }
    public string Car { get; set; }
    public double Price { get; set; }
    public double Rating { get; set; }
    public int RatingCount { get; set; }
    public string Location { get; set; }
}

public class DriverDetailsDto
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string FullName { get; set; }
    public string Car { get; set; }
    public string RegistrationNumber { get; set; }
    public double Price { get; set; }
    public double Rating { get; set; }
    public double RatingCount { get; set; }
    public string Phone { get; set; }
    public string Location { get; set; }
    
}

public class DriverAccountDetailsDto
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string FullName { get; set; }
    public double Price { get; set; }
    public bool HasPrice { get; set; }
    public double Rating { get; set; }
    public string Location { get; set; }
    public string ProfilePhotoUrl { get; set; }
    public int RatingCount { get; set; }
    public int UnseenChats { get; set; }
}

public class DriverUpdateBasicDetailsDto
{
    public int Id { get; set;}
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Phone { get; set; }
    public bool HasPrice { get; set; }
    public double Price { get; set; }
    public string ImageUrl { get; set; }
}

public class DriverUpdateMainDetailsDto
{
    public string Username { get; set; }
    public bool ChangePassword { get; set; }
    public string OldPassword { get; set; }
    public string NewPassword { get; set; }
    public string RepeatNewPassword { get; set; }
}