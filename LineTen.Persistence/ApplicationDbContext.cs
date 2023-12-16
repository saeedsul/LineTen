﻿using LineTen.Persistence.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage;

namespace LineTen.Persistence
{
    public class ApplicationDbContext : DbContext, IApplicationDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
            var dbCreater = Database.GetService<IDatabaseCreator>() as RelationalDatabaseCreator;
            if (dbCreater != null)
            {
                // Create Database 
                if (!dbCreater.CanConnect())
                {
                    dbCreater.Create();
                }

                // Create Tables
                if (!dbCreater.HasTables())
                {
                    dbCreater.CreateTables();
                }
            }
        }

        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<Order> Orders { get; set; }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            return base.SaveChangesAsync(cancellationToken);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Customer>().ToTable("Customers");
            modelBuilder.Entity<Product>().ToTable("Products");
            modelBuilder.Entity<Order>().ToTable("Orders");

            modelBuilder.Entity<Order>()
                 .Property(o => o.CreatedDate)
                 .ValueGeneratedOnAdd();

            modelBuilder.Entity<Order>()
                .HasOne(o => o.Product)
                .WithMany(p => p.Orders)
                .HasForeignKey(o => o.ProductId);

            modelBuilder.Entity<Order>()
                .HasOne(o => o.Customer)
                .WithMany(c => c.Orders)
                .HasForeignKey(o => o.CustomerId);

            
            modelBuilder.Entity<Customer>().HasData(
             new Customer { Id = 1, FirstName = "John", LastName = "Doe", Phone = "1234567890", Email = "john@example.com" },
             new Customer { Id = 2, FirstName = "Jane", LastName = "Smith", Phone = "9876543210", Email = "jane@example.com" },
             new Customer { Id = 3, FirstName = "Mike", LastName = "Johnson", Phone = "5551234567", Email = "mike@example.com" }
             );

            // Seed data for Products
            modelBuilder.Entity<Product>().HasData(
                new Product { Id = 1, Name = "Product A", Description = "Description for Product A", SKU = "SKU-001" },
                new Product { Id = 2, Name = "Product B", Description = "Description for Product B", SKU = "SKU-002" },
                new Product { Id = 3, Name = "Product C", Description = "Description for Product C", SKU = "SKU-003" }
            );

            // Seed data for Orders
            modelBuilder.Entity<Order>().HasData(
               new Order { Id = 1, ProductId = 1, CustomerId = 1, Status = "Pending", CreatedDate = DateTime.UtcNow, UpdatedDate = DateTime.UtcNow },
               new Order { Id = 2, ProductId = 2, CustomerId = 2, Status = "Shipped", CreatedDate = DateTime.UtcNow, UpdatedDate = DateTime.UtcNow },
               new Order { Id = 3, ProductId = 3, CustomerId = 3, Status = "Delivered", CreatedDate = DateTime.UtcNow, UpdatedDate = DateTime.UtcNow }
           );
        }
    }
}