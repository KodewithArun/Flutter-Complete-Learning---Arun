import 'package:flutter/material.dart';

void main() {
  runApp(const SonicStore());
}

// =====================================================
// THEME
// =====================================================

const Color orange = Color(0xFFFF6900);
const Color dark = Color(0xFF171717);
const Color background = Color(0xFFF5F5F5);
const Color muted = Color(0xFF999999);

// =====================================================
// PRODUCT MODEL
// =====================================================

class Product {
  final String name;
  final String category;
  final double price;
  final double rating;
  final int reviews;
  final String image;
  final String tag;
  final String description;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.tag,
    required this.description,
  });
}

const List<Product> products = [
  Product(
    name: 'Sonic Air Pro',
    category: 'Earbuds',
    price: 5200,
    rating: 4.8,
    reviews: 320,
    image: 'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=600',
    tag: 'BEST SELLER',
    description: 'Experience premium sound with powerful bass, crystal-clear audio and advanced noise cancellation. Designed for everyday comfort and an immersive listening experience.',
  ),
  Product(
    name: 'Bass Buds X',
    category: 'Earbuds',
    price: 3500,
    rating: 4.6,
    reviews: 180,
    image: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=600',
    tag: 'POPULAR',
    description: 'Enjoy deep bass and balanced sound with a compact charging case and comfortable wireless design.',
  ),
  Product(
    name: 'Air Beat Max',
    category: 'Bluetooth',
    price: 4500,
    rating: 4.7,
    reviews: 210,
    image: 'https://images.unsplash.com/photo-1606400082777-ef05f3c5de2b?w=600',
    tag: 'TRENDING',
    description: 'A modern wireless audio experience with long battery life and convenient touch controls.',
  ),
  Product(
    name: 'Vortex Pro',
    category: 'Premium',
    price: 6200,
    rating: 4.9,
    reviews: 95,
    image: 'https://images.unsplash.com/photo-1631867675167-90a456a90863?w=600',
    tag: 'NEW',
    description: 'Premium earbuds with ergonomic design and a stylish charging case for everyday listening.',
  ),
];

// =====================================================
// APP
// =====================================================

class SonicStore extends StatelessWidget {
  const SonicStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sonic Store',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: orange),
        fontFamily: 'Roboto',
      ),
      home: const StoreHome(),
    );
  }
}

// =====================================================
// REUSABLE NETWORK IMAGE
// =====================================================

class ProductImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;

  const ProductImage({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;

        return const Center(
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(color: orange, strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFF0F0F0),
          alignment: Alignment.center,
          child: const Icon(
            Icons.headphones_rounded,
            size: 55,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}

// =====================================================
// HOME SCREEN
// =====================================================

class StoreHome extends StatefulWidget {
  const StoreHome({super.key});

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  int selectedTab = 0;
  int selectedCategory = 0;

  final TextEditingController searchController = TextEditingController();

  final List<String> categories = ['All', 'Earbuds', 'Premium', 'Bluetooth'];

  final Set<int> favorites = {};

  // Product index -> quantity
  final Map<int, int> cart = {};

  int get cartCount {
    return cart.values.fold<int>(0, (sum, quantity) => sum + quantity);
  }

  double get cartTotal {
    return cart.entries.fold<double>(
      0.0,
      (sum, entry) => sum + products[entry.key].price * entry.value,
    );
  }

  List<int> get filteredProducts {
    return List.generate(products.length, (index) => index).where((index) {
      final product = products[index];

      final matchesSearch = product.name.toLowerCase().contains(
        searchController.text.toLowerCase(),
      );

      final matchesCategory =
          selectedCategory == 0 ||
          product.category == categories[selectedCategory];

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void addToCart(int index, {int quantity = 1}) {
    setState(() {
      cart[index] = (cart[index] ?? 0) + quantity;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${products[index].name} added to cart'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: dark,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void openDetails(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetails(
          index: index,
          isFavorite: favorites.contains(index),
          onFavorite: () {
            setState(() {
              if (favorites.contains(index)) {
                favorites.remove(index);
              } else {
                favorites.add(index);
              }
            });
          },
          onAdd: (quantity) {
            addToCart(index, quantity: quantity);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab,
          children: [
            homeContent(),
            wishlistContent(),
            CartPage(cart: cart, onChanged: () => setState(() {})),
            profileContent(),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  // ===================================================
  // BOTTOM NAVIGATION
  // ===================================================

  Widget bottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(Icons.grid_view_rounded, 'Home', 0),
              navItem(Icons.favorite_border, 'Wishlist', 1),
              navItem(Icons.shopping_bag_outlined, 'Cart', 2),
              navItem(Icons.person_outline, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    final selected = selectedTab == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 24, color: selected ? orange : muted),
                if (index == 2 && cartCount > 0)
                  Positioned(
                    right: -9,
                    top: -7,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: selected ? orange : muted,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================
  // HOME CONTENT
  // ===================================================

  Widget homeContent() {
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        // HEADER
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 17, 20, 15),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SONIC.',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'Feel every beat.',
                      style: TextStyle(color: muted, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => selectedTab = 2);
                  },
                  icon: Badge(
                    isLabelVisible: cartCount > 0,
                    label: Text('$cartCount'),
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),

        // SEARCH
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search earbuds...',
                hintStyle: const TextStyle(fontSize: 13, color: muted),
                prefixIcon: const Icon(Icons.search, color: muted),
                suffixIcon: const Icon(Icons.tune, color: dark),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),

        // HERO BANNER
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 5),
            child: Container(
              height: 180,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: dark,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -10,
                    top: 0,
                    bottom: 0,
                    width: 170,
                    child: ProductImage(
                      url: products[0].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'NEW COLLECTION',
                          style: TextStyle(
                            color: orange,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Feel The\nBeat.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 29,
                            height: 1.1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 34,
                          child: ElevatedButton(
                            onPressed: () => openDetails(0),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 17,
                              ),
                            ),
                            child: const Text(
                              'Shop Now',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // CATEGORY TITLE
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 13),
            child: Row(
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text('Explore', style: TextStyle(color: orange, fontSize: 12)),
              ],
            ),
          ),
        ),

        // CATEGORIES
        SliverToBoxAdapter(
          child: SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final selected = selectedCategory == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? orange : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: selected ? Colors.white : dark,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // PRODUCT TITLE
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 14),
            child: Row(
              children: [
                const Text(
                  'Special For You',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${filteredProducts.length} products',
                  style: const TextStyle(fontSize: 11, color: muted),
                ),
              ],
            ),
          ),
        ),

        // RESPONSIVE PRODUCT GRID
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
          sliver: filteredProducts.isEmpty
              ? const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(35),
                    child: Center(
                      child: Text(
                        'No products found.',
                        style: TextStyle(color: muted),
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, position) {
                    final index = filteredProducts[position];

                    return productCard(index);
                  }, childCount: filteredProducts.length),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 230,
                    mainAxisExtent: 285,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 15,
                  ),
                ),
        ),
      ],
    );
  }

  // ===================================================
  // PRODUCT CARD
  // ===================================================

  Widget productCard(int index) {
    final product = products[index];
    final isFavorite = favorites.contains(index);

    return GestureDetector(
      onTap: () => openDetails(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ProductImage(
                      url: product.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        product.tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              favorites.remove(index);
                            } else {
                              favorites.add(index);
                            }
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? orange : dark,
                          size: 18,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 34,
                          minHeight: 34,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // DETAILS
            Padding(
              padding: const EdgeInsets.fromLTRB(11, 8, 11, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 13,
                        color: Color(0xFFFFB800),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 10),
                      ),
                      const Spacer(),
                      Flexible(
                        child: Text(
                          'Rs. ${product.price.toStringAsFixed(0)}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: () => addToCart(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================
  // WISHLIST
  // ===================================================

  Widget wishlistContent() {
    final saved = favorites.toList();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'My Wishlist',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: saved.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite_border, size: 65, color: muted),
                      SizedBox(height: 12),
                      Text('Your wishlist is empty'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: saved.length,
                  itemBuilder: (context, i) {
                    final index = saved[i];
                    final product = products[index];

                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: SizedBox(
                          width: 65,
                          child: ProductImage(url: product.image),
                        ),
                        title: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Rs. ${product.price.toStringAsFixed(0)}',
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              favorites.remove(index);
                            });
                          },
                          icon: const Icon(Icons.favorite, color: orange),
                        ),
                        onTap: () => openDetails(index),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ===================================================
  // PROFILE
  // ===================================================

  Widget profileContent() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outline, size: 45, color: orange),
          ),
          SizedBox(height: 15),
          Text(
            'Welcome to Sonic Store',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Your audio experience starts here.',
            style: TextStyle(color: muted),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// PRODUCT DETAILS SCREEN
// =====================================================

class ProductDetails extends StatefulWidget {
  final int index;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final Function(int) onAdd;

  const ProductDetails({
    super.key,
    required this.index,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAdd,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  int selectedColor = 0;
  int selectedSection = 0;

  final List<Color> colors = [
    const Color(0xFF9F193B),
    Colors.black,
    const Color(0xFF204B91),
    const Color(0xFF97491E),
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    final product = products[widget.index];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // HEADER
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          roundButton(
                            Icons.arrow_back,
                            () => Navigator.pop(context),
                          ),
                          const Spacer(),
                          roundButton(Icons.share_outlined, () {}),
                          const SizedBox(width: 9),
                          roundButton(
                            widget.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            widget.onFavorite,
                            color: widget.isFavorite ? orange : dark,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // PRODUCT IMAGE
                  SliverToBoxAdapter(
                    child: Container(
                      height: 280,
                      color: const Color(0xFFF8F8F8),
                      padding: const EdgeInsets.all(12),
                      child: ProductImage(
                        url: product.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // PRODUCT INFORMATION
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 9),

                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFFFB800),
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text('${product.rating}'),
                              const SizedBox(width: 6),
                              Text(
                                '(${product.reviews} Reviews)',
                                style: const TextStyle(
                                  color: muted,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Rs. ${product.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: orange,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          const Text(
                            'Color',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 13),

                          Wrap(
                            spacing: 12,
                            children: List.generate(colors.length, (i) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = i;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selectedColor == i
                                          ? dark
                                          : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: colors[i],
                                  ),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 25),

                          // RESPONSIVE TABS
                          Row(
                            children: [
                              Expanded(child: sectionTab('Description', 0)),
                              Expanded(child: sectionTab('Specifications', 1)),
                              Expanded(child: sectionTab('Reviews', 2)),
                            ],
                          ),

                          const Divider(),

                          const SizedBox(height: 12),

                          Text(
                            selectedSection == 0
                                ? product.description
                                : selectedSection == 1
                                ? 'Wireless Bluetooth connectivity\n'
                                      'Premium audio drivers\n'
                                      'Portable charging case\n'
                                      'Touch control support'
                                : 'Rated ${product.rating} out of 5 by '
                                      '${product.reviews} customers.',
                            style: const TextStyle(
                              color: muted,
                              height: 1.8,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM PURCHASE BAR
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: dark,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          quantityButton(Icons.remove, () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          }),
                          Text(
                            '$quantity',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          quantityButton(Icons.add, () {
                            setState(() => quantity++);
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: SizedBox(
                        height: 49,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onAdd(quantity);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTab(String title, int index) {
    final selected = selectedSection == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedSection = index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? orange : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: selected ? Colors.white : dark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget quantityButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, color: Colors.white, size: 17),
    );
  }
}

// =====================================================
// REUSABLE ROUND BUTTON
// =====================================================

Widget roundButton(IconData icon, VoidCallback onTap, {Color color = dark}) {
  return Container(
    decoration: const BoxDecoration(color: background, shape: BoxShape.circle),
    child: IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 19, color: color),
    ),
  );
}

// =====================================================
// CART SCREEN
// =====================================================

class CartPage extends StatefulWidget {
  final Map<int, int> cart;
  final VoidCallback onChanged;

  const CartPage({super.key, required this.cart, required this.onChanged});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController discountController = TextEditingController();

  bool discountApplied = false;

  double get subtotal {
    return widget.cart.entries.fold<double>(0.0, (sum, entry) {
      final price = products[entry.key].price;
      return sum + (price * entry.value);
    });
  }

  double get discount {
    return discountApplied ? subtotal * 0.10 : 0.0;
  }

  double get total {
    return subtotal - discount;
  }

  @override
  void dispose() {
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CART HEADER
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(width: 35),
              const Spacer(),
              const Text(
                'My Cart',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '${widget.cart.values.fold<int>(0, (a, b) => a + b)} items',
                style: const TextStyle(fontSize: 12, color: muted),
              ),
            ],
          ),
        ),

        // CART PRODUCTS
        Expanded(
          child: widget.cart.isEmpty
              ? emptyCart()
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  children: widget.cart.keys.toList().map((index) {
                    final product = products[index];
                    final quantity = widget.cart[index] ?? 0;

                    return cartItem(index, product, quantity);
                  }).toList(),
                ),
        ),

        // CHECKOUT SUMMARY
        if (widget.cart.isNotEmpty) checkoutSummary(),
      ],
    );
  }

  Widget emptyCart() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 70, color: muted),
          SizedBox(height: 15),
          Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Add your favorite earbuds to get started.',
            style: TextStyle(color: muted),
          ),
        ],
      ),
    );
  }

  // ===================================================
  // CART ITEM
  // ===================================================

  Widget cartItem(int index, Product product, int quantity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 78,
              height: 85,
              child: ProductImage(url: product.image, fit: BoxFit.contain),
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.category,
                  style: const TextStyle(color: muted, fontSize: 11),
                ),
                const SizedBox(height: 7),
                Text(
                  'Rs. ${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),

                // QUANTITY CONTROLS
                Row(
                  children: [
                    quantityControl(
                      Icons.remove,
                      () => updateQuantity(index, -1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    quantityControl(Icons.add, () => updateQuantity(index, 1)),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              setState(() {
                widget.cart.remove(index);
                discountApplied = false;
              });
              widget.onChanged();
            },
            icon: const Icon(Icons.delete_outline, color: orange),
          ),
        ],
      ),
    );
  }

  // ===================================================
  // UPDATE QUANTITY
  // ===================================================

  void updateQuantity(int index, int change) {
    setState(() {
      final newQuantity = (widget.cart[index] ?? 0) + change;

      if (newQuantity <= 0) {
        widget.cart.remove(index);
        discountApplied = false;
      } else {
        widget.cart[index] = newQuantity;
      }
    });

    widget.onChanged();
  }

  Widget quantityControl(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 27,
        width: 27,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, size: 14),
      ),
    );
  }

  // ===================================================
  // CHECKOUT SUMMARY
  // ===================================================

  Widget checkoutSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 17, 18, 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // DISCOUNT
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: discountController,
                    decoration: InputDecoration(
                      hintText: 'Enter Discount Code',
                      hintStyle: const TextStyle(fontSize: 12, color: muted),
                      filled: true,
                      fillColor: background,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: applyDiscount,
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            summaryRow('Subtotal', subtotal),

            if (discountApplied) summaryRow('Discount (10%)', -discount),

            const Divider(height: 25),

            summaryRow('Total', total, bold: true),

            const SizedBox(height: 17),

            // CHECKOUT BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: checkout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void applyDiscount() {
    final code = discountController.text.trim().toUpperCase();

    setState(() {
      discountApplied = code == 'SONIC10';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          discountApplied
              ? '10% discount applied successfully!'
              : 'Invalid code. Try SONIC10.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment gateway integration is required for checkout.'),
      ),
    );
  }

  Widget summaryRow(String label, double amount, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: bold ? dark : muted,
              fontSize: bold ? 16 : 13,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'Rs. ${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: dark,
              fontSize: bold ? 18 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
