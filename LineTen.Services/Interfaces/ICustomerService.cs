using LineTen.Common.Dtos.Customer;

namespace LineTen.Services.Interfaces
{
    public interface ICustomerService
    {
        Task<CustomerDto?> GetCustomerById(int id);
        Task<IEnumerable<CustomerDto>> GetAllCustomers();
        Task<CustomerDto?> CreateCustomer(AddCustomerDto addCustomerDto);
        Task<CustomerDto?> UpdateCustomer(int id, UpdateCustomerDto customer);
        Task<bool> DeleteCustomer(int id);
    }
}
