using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;

namespace API;

public class DriverAuthService(
    IConfiguration configuration
) : IDriverAuthService
{
    private readonly IConfiguration _config = configuration;

    public string GenerateToken(Driver driver)
    {
        var handler = new JwtSecurityTokenHandler();
        var key = Encoding.ASCII.GetBytes(
            _config.GetValue<string>("TokenKey")
        );
        var credentials = new SigningCredentials(
            new SymmetricSecurityKey(key),
            SecurityAlgorithms.HmacSha256Signature);

        var claims = new ClaimsIdentity();
        claims.AddClaim(new Claim(ClaimTypes.Name, driver.Username));

        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = claims,
            Expires = DateTime.UtcNow.AddDays(5),
            SigningCredentials = credentials,
        };

        var token = handler.CreateToken(tokenDescriptor);
        return handler.WriteToken(token);
    }
}
