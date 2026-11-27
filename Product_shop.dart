import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedCategory = "All";

  final List<Map<String, dynamic>> products = [
    {
      "name": "Nike Shoes",
      "price": "\$12.00",
      "image": "best_shoes.jpg",
      "category": "Footwear",
      "color": const Color.fromARGB(255, 248, 7, 176),
      "icon": Icons.directions_run,
    },
    {
      "name": "Sports Shoes",
      "price": "\$15.00",
      "image": "nice_shoes.png",
      "category": "Footwear",
      "color": const Color.fromARGB(255, 5, 208, 240),
      "icon": Icons.directions_run,
    },
    {
      "name": "Running Shoes",
      "price": "\$18.00",
      "image": "bs_shoes.png",
      "category": "Footwear",
      "color": const Color.fromARGB(255, 245, 128, 32),
      "icon": Icons.directions_run,
    },
    {
      "name": "Watch",
      "price": "\$20.00",
      "image": "best_watch.jpg",
      "category": "Watch",
      "color": const Color.fromARGB(255, 105, 37, 241),
      "icon": Icons.watch,
    },
    {
      "name": "Smart Watch",
      "price": "\$25.00",
      "image": "new_watch.jpg",
      "category": "Watch",
      "color": const Color.fromARGB(255, 12, 140, 238),
      "icon": Icons.watch,
    },
    {
      "name": "Hand Bag",
      "price": "\$14.00",
      "image": "best_bags.jpg",
      "category": "Bags",
      "color": const Color.fromARGB(255, 236, 114, 48),
      "icon": Icons.shopping_bag,
    },
    {
      "name": "Travel Bag",
      "price": "\$22.00",
      "image": "nice_bag.png",
      "category": "Bags",
      "color": const Color.fromARGB(255, 20, 216, 118),
      "icon": Icons.shopping_bag,
    },
    {
      "name": "Chair",
      "price": "\$10.00",
      "image": "do_furniture.jpg",
      "category": "Furniture",
      "color": const Color.fromARGB(255, 238, 58, 73),
      "icon": Icons.chair,
    },
    {
      "name": "Sofa",
      "price": "\$35.00",
      "image": "image_furniture).jpg",
      "category": "Furniture",
      "color": const Color.fromARGB(255, 226, 143, 34),
      "icon": Icons.weekend,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = selectedCategory == "All"
        ? products
        : products.where((p) => p["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const Center(child: Icon(Icons.apps, color: Colors.white)),
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 221, 220, 220),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  'white_flower.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) =>
                      const CircleAvatar(radius: 19, child: Icon(Icons.person)),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SearchBar(
                hintText: "Search...",
                trailing: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: Colors.black),
                    tooltip: "Search",
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.apps, color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 223, 1, 167),
                    Color.fromARGB(255, 3, 243, 55),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '50%\nOFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ClipOval(
                    child: Image.asset(
                      'best_shoes.jpg',
                      width: 200,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            SizedBox(
              height: 65,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  categoryItem(Icons.apps, "All"),
                  categoryItem(Icons.directions_run, "Footwear"),
                  categoryItem(Icons.watch, "Watch"),
                  categoryItem(Icons.shopping_bag, "Bags"),
                  categoryItem(Icons.chair, "Furniture"),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedCategory == "All" ? "Popular" : selectedCategory,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => selectedCategory = "All");
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(color: Color.fromARGB(255, 10, 4, 8)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final p = filteredProducts[index];

                  return productCard(
                    name: p["name"],
                    price: p["price"],
                    image: p["image"],
                    color: p["color"],
                    icon: p["icon"],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: const Color.fromARGB(255, 212, 9, 168),
        unselectedItemColor: const Color.fromARGB(255, 219, 6, 148),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget categoryItem(IconData icon, String title) {
    final isSelected = selectedCategory == title;

    return GestureDetector(
      onTap: () => setState(() => selectedCategory = title),
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 230, 240, 99)
              : const Color.fromARGB(255, 217, 64, 248),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 77, 19, 214)
                : const Color.fromARGB(0, 2, 1, 1),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 233, 26, 88).withOpacity(0.12),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? const Color.fromARGB(255, 100, 16, 255)
                  : Colors.black87,
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? const Color.fromARGB(255, 19, 209, 35)
                      : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productCard({
    required String name,
    required String price,
    required String image,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 29, 224, 23),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "New",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stack) => Icon(
                  icon ?? Icons.shopping_bag,
                  size: 65,
                  color: Colors.black54,
                ),
              ),
            ),
          ),

          Text(
            name,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),

          const SizedBox(height: 3),

          Text(
            price,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagePage(
                      productName: name,
                      productPrice: price,
                      productImage: image,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 12, 12, 10),
                foregroundColor: const Color.fromARGB(255, 235, 232, 232),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Order Now %",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagePage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  const MessagePage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 245, 25),

      appBar: AppBar(
        title: const Text("Message", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 5, 2, 4),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  widget.productImage,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stack) => const Icon(
                    Icons.shopping_bag,
                    size: 80,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Product: ${widget.productName}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 12),

            Text(
              "Price: ${widget.productPrice}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            const Text(
              "Your order is ready to be discussed.",
              style: TextStyle(fontSize: 16),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Your order is submitted successfully!"),
                      backgroundColor: Color.fromARGB(255, 54, 54, 43),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 29, 8, 219),
                  foregroundColor: const Color.fromARGB(255, 236, 238, 237),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Order Now",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 15, width: 30),
          ],
        ),
      ),
    );
  }
}
