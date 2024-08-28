import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Item 1',
      'price': '\$20',
      'description': 'This is a great product for daily use.',
      'imageUrl': 'https://via.placeholder.com/150',
      'quantity': 10,
    },
    {
      'name': 'Item 2',
      'price': '\$35',
      'description': 'High-quality product with a stylish design.',
      'imageUrl': 'https://via.placeholder.com/150',
      'quantity': 0,
    },
    {
      'name': 'Item 3',
      'price': '\$15',
      'description': 'Affordable and reliable for everyone.',
      'imageUrl': 'https://via.placeholder.com/150',
      'quantity': 5,
    },
    {
      'name': 'Item 4',
      'price': '\$10',
      'description': 'A reliable and durable product.',
      'imageUrl': 'https://via.placeholder.com/150',
      'quantity': null,
    },
  ];

  final List<Map<String, dynamic>> cartItems = [];

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${item['name']} added to cart")),
    );
  }

  void _removeFromCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  void _finalizePurchase() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreditCardInputPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    int cartCount = cartItems.length;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final int quantity = item['quantity'] ?? 0;

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.network(
                      item['imageUrl'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item['price'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    quantity > 0
                        ? ElevatedButton(
                      onPressed: () {
                        _addToCart(item);
                      },
                      child: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 94, 132),
                        foregroundColor: Colors.white,
                      ),
                    )
                        : Text(
                      'Coming Soon',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Show cart items in a dialog
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: Text('Cart Items'),
                        content: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/shopcart.png'), // Your background image path
                              fit: BoxFit.none,
                            ),
                          ),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: cartItems.length,
                                    itemBuilder: (context, index) {
                                      final cartItem = cartItems[index];
                                      return Card(
                                        margin: EdgeInsets.symmetric(vertical: 8),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                cartItem['imageUrl'],
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cartItem['name'],
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      cartItem['description'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      cartItem['price'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.cancel),
                                                onPressed: () {
                                                  _removeFromCart(cartItem);
                                                  setState(() {}); // Refresh dialog state
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                    _finalizePurchase(); // Proceed to payment
                                  },
                                  child: Text('Buy'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(255, 0, 94, 132),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            child: Icon(Icons.shopping_cart),
            backgroundColor: Color.fromARGB(255, 0, 94, 132),
          ),
          if (cartCount > 0)
            Positioned(
              top: -4,
              left: -4,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                constraints: BoxConstraints(
                  minWidth: 24,
                  minHeight: 24,
                ),
                child: Center(
                  child: Text(
                    '$cartCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
class CreditCardInputPage extends StatelessWidget {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter Credit Card Details'),
          backgroundColor: Color.fromARGB(255, 0, 94, 132),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
                prefixIcon: Icon(Icons.credit_card),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _expiryDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Expiry Date (MM/YY)',
                prefixIcon: Icon(Icons.date_range),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _cvvController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CVV',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            Center(
            child: ElevatedButton(
            onPressed: () {
        // Here you would normally handle the payment process
        ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful")),
    );
    Navigator.pop(context); // Close payment page after success
  },
    child: Text('Pay Now'),
    style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 0, 94, 132),
      foregroundColor: Colors.white,),
            ),
            ),
              ],
            ),
        ),
    );
  }
}
