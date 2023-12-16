using LineTen.Persistence.Entities;
using Microsoft.EntityFrameworkCore;

namespace LineTen.Persistence
{
    public interface IApplicationDbContext
    {
        DbSet<Customer> Customers { get; set; }
        DbSet<Product> Products { get; set; }
        DbSet<Order> Orders { get; set; }

        Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
    }
}