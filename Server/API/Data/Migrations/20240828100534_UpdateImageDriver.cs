using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API.Data.Migrations
{
    /// <inheritdoc />
    public partial class UpdateImageDriver : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ProfileImagePath",
                table: "Drivers");

            migrationBuilder.RenameColumn(
                name: "ProfileImageUrl",
                table: "Drivers",
                newName: "ImageUrl");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "ImageUrl",
                table: "Drivers",
                newName: "ProfileImageUrl");

            migrationBuilder.AddColumn<string>(
                name: "ProfileImagePath",
                table: "Drivers",
                type: "text",
                nullable: true);
        }
    }
}
