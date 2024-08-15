using System;
using API.Entities;

namespace API.Repositories.Contracts;

public interface IReviewRepository
{
    void Add(Review review);
    Task<bool> SaveAllAsync();
}
