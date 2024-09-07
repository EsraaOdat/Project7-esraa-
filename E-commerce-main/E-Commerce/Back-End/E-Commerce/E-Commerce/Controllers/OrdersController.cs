using E_Commerce.Dto;
using E_Commerce.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace E_Commerce.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class OrdersController : ControllerBase
    {

        private readonly MyDbContext _db;

        public OrdersController(MyDbContext db)
        {
            _db = db;

        }


        [HttpGet]
        [Route("AllOrders")]
        public IActionResult GetAllOrders()
        {
            var orders = _db.Orders
                .Select(order => new OrderResponseDto
                {
                    OrderId = order.OrderId,
                    Date = order.Date,

                    // Customer information
                    Customer = new UserDto
                    {
                        Name = order.User.Name
                    },

                    // Calculate the total number of items
                    NumberOfItems = order.OrderItems.Sum(oi => oi.Quantity ?? 0),

                    // Calculate the total price of the order
                    Total = order.OrderItems.Sum(oi => (oi.Quantity ?? 0) * (oi.Product.Price ?? 0)),

                    // Status of the order
                    Status = order.Status,

                    // Map each order item to OrderItemDto
                    OrderItems = order.OrderItems.Select(oi => new OrderItemDto
                    {
                        ProductId = oi.Product.ProductId,
                        ProductName = oi.Product.Name,
                        Quantity = oi.Quantity,
                        Price = oi.Product.Price
                    }).ToList()
                })
                .ToList();

            return Ok(orders);
        }


        [HttpGet]
        [Route("GetOrdersByUser/{userId}")]
        public IActionResult GetOrdersByUserId(int userId)
        {
            // Retrieve all orders that belong to the specified user
            var orders = _db.Orders
                .Where(order => order.UserId == userId) // Filter by UserId
                .Select(order => new OrderResponseDto
                {
                    OrderId = order.OrderId,
                    Date = order.Date,
                    Customer = new UserDto
                    {
                        Name = order.User.Name
                    },
                    NumberOfItems = order.OrderItems.Sum(oi => oi.Quantity ?? 0),
                    Total = order.OrderItems.Sum(oi => (oi.Quantity ?? 0) * (oi.Product.Price ?? 0)),
                    Status = order.Status,
                    OrderItems = order.OrderItems.Select(oi => new OrderItemDto
                    {
                        ProductId = oi.Product.ProductId,
                        ProductName = oi.Product.Name,
                        Quantity = oi.Quantity,
                        Price = oi.Product.Price
                    }).ToList()
                })
                .ToList();

            // Check if the user has any orders
            if (orders.Count == 0)
            {
                return NotFound(new { message = "No orders found for this user." });
            }

            return Ok(orders);
        }


        [HttpGet]
        [Route("GetUserById/{id}")]
        public IActionResult GetUserById(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new { message = "Invalid ID. The ID must be a positive integer." });
            }

            var user = _db.Users.Find(id);

            if (user == null)
            {
                return NotFound(new { message = $"User with ID {id} not found." });
            }

            return Ok(user);
        }








        [HttpPut]
        [Route("UpdateUser/{id}")]
        public IActionResult UpdateUser(int id, [FromForm] UsersRequestDTO updatedUser)
        {
            var existingUser = _db.Users.Find(id);
            if (existingUser == null)
            {
                return NotFound(new { message = $"User with ID {id} not found." });
            }
            existingUser.Name = updatedUser.Name ?? existingUser.Name;

            existingUser.Email = updatedUser.Email ?? existingUser.Email;

          
            existingUser.PhoneNumber = updatedUser.PhoneNumber ?? existingUser.PhoneNumber;
            existingUser.Password = updatedUser.Password ?? existingUser.Password;

            _db.Users.Update(existingUser);
            _db.SaveChanges();
            return Ok(new { message = "User updated successfully.", user = existingUser });
        }









    }
}