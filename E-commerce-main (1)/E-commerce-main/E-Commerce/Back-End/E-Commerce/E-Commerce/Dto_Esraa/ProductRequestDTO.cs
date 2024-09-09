namespace E_Commerce.Dto_Esraa
{
    public class ProductRequestDTO
    {


        public string? Name { get; set; }

        public string? Description { get; set; }

        public IFormFile Image { get; set; }

        public decimal? Price { get; set; }

        public int? CategoryId { get; set; }

        public string? Color { get; set; }

        public int? FlowerColorId { get; set; }

        public decimal? PriceWithDiscount { get; set; }













    }
}
