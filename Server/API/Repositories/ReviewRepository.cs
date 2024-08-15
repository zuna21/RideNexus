using System;
using API.Entities;
using API.Repositories.Contracts;

namespace API.Repositories;

public class ReviewRepository(
    DataContext dataContext
) : IReviewRepository
{
    private readonly DataContext _dataContext = dataContext;

    public void Add(Review review)
    {
        _dataContext.Reviews.Add(review);
    }

    public async Task<bool> SaveAllAsync()
    {
        return await _dataContext.SaveChangesAsync() > 0;
    }
}
