class Product{
  final String id;
  final String name;
  final String price;
  final int stock_quantity;
  final String url;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock_quantity,
    required this.url
  });

  factory Product.fromMap(Map <String, dynamic> product){
    return Product(
        id: product['id'],
        name: product['name'],
        price: product['price'],
        stock_quantity: product['stock_quantity'],
        url: product['url']
    );
  }
}

