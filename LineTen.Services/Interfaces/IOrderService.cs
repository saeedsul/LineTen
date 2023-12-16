using LineTen.Common.Dtos.Order;

namespace LineTen.Services.Interfaces
{
    public interface IOrderService
    {
        Task<OrderDto?> GetOrderById(int id);
        Task<IEnumerable<OrderDto>> GetAllOrders();
        Task<OrderDto?> CreateOrder(AddOrderDto addOrderDto);
        Task<OrderDto?> UpdateOrder(UpdateOrderDto updateOrderDto);
        Task<bool> DeleteOrder(int id);
    }
}
