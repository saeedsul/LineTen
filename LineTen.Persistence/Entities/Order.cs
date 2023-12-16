using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace LineTen.Persistence.Entities
{ 
    public class Order
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int ProductId { get; set; }

        [Required]
        public int CustomerId { get; set; }

        [ForeignKey("ProductId")]
        public Product? Product { get; set; }

        [ForeignKey("CustomerId")]
        public Customer? Customer { get; set; }

        [Required]
        public string? Status { get; set; }

        [Required]
        public DateTime CreatedDate { get; set; }

        public DateTime UpdatedDate { get; set; }
    }
}
