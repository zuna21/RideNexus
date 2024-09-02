using System;

namespace API.DTOs.Params;

public class BasicParams
{
    public int PageIndex { get; set; } = 0;
    public int PageSize { get; set;} = 20;
}
