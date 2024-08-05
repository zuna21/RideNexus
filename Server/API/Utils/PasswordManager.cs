using Microsoft.AspNetCore.Identity;

namespace API;

public static class PasswordManager
{
    public static bool ArePasswordsEqual(string password1, string password2)
    {
        return password1.Equals(password2);
    }

    public static string HashDriverPassword(Driver driver, string password)
    {
        PasswordHasher<Driver> passwordHasher = new();
        return passwordHasher.HashPassword(driver, password);
    }

    public static PasswordVerificationResult VerifyDriverPassword(Driver driver, string password)
    {
        PasswordHasher<Driver> passwordHasher = new();
        return passwordHasher.VerifyHashedPassword(driver, driver.Password, password);
    }
}
