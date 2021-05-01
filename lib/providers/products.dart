import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'T-Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'Hoodie',
    //   description: 'The most amazing purple hoodie you can imagine!',
    //   price: 20.99,
    //   imageUrl:
    //       'https://www.reserved.com/media/catalog/product/Z/U/ZU289-45X-040_14.jpg',
    //   isFavorite: false,
    // ),
    // Product(
    //   id: 'p6',
    //   title: 'Cap',
    //   description: 'Stylish trendy youth',
    //   price: 8.99,
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0026/4768/7233/products/purplehat.png?v=1571752767',
    //   isFavorite: false,
    // ),
    // Product(
    //   id: 'p7',
    //   title: 'Pants',
    //   description: 'Pants are more fashionable only at Kirkorov!',
    //   price: 20.99,
    //   imageUrl:
    //       'https://cdn.cliqueinc.com/posts/275619/purple-pants-trend-275619-1545671698781-product.700x0c.jpg',
    //   isFavorite: false,
    // ),
    // Product(
    //   id: 'p8',
    //   title: 'T-Shirt',
    //   description: 'Just T-Shirt what do you want',
    //   price: 6.99,
    //   imageUrl:
    //       'https://www.weekday.com/upload/uf/386/386126993d8db02661198393b2832889.jpg',
    //   isFavorite: false,
    // ),
    // Product(
    //   id: 'p9',
    //   title: 'Sneakers',
    //   description: 'Do sport every day!',
    //   price: 109.99,
    //   imageUrl:
    //       'https://www.hervia.com/uploads/images/products/verylarge/hervia.com-raf-simons-runner-antei-purple-sneakers-160069897820798-0003-Layer-1.jpg',
    //   isFavorite: false,
    // )
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-shop-app-7c5ec-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    //await - мы ждем, пока заверится исполнение этого V куска кода,
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://flutter-shop-app-7c5ec-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    try {
      final response = await http.get(url);
      final fetchedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      fetchedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(
            Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              isFavorite: prodData['isFavorite'],
              imageUrl: prodData['imageUrl'],
            ),
          );
        },
      );
      print(json.decode(response.body));
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
