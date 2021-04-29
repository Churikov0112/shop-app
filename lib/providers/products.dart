import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Hoodie',
      description: 'The most amazing purple hoodie you can imagine!',
      price: 20.99,
      imageUrl:
          'https://www.reserved.com/media/catalog/product/Z/U/ZU289-45X-040_14.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p2',
      title: 'Cap',
      description: 'Stylish trendy youth',
      price: 8.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0026/4768/7233/products/purplehat.png?v=1571752767',
      isFavorite: false,
    ),
    Product(
      id: 'p3',
      title: 'Pants',
      description: 'Pants are more fashionable only at Kirkorov!',
      price: 20.99,
      imageUrl:
          'https://cdn.cliqueinc.com/posts/275619/purple-pants-trend-275619-1545671698781-product.700x0c.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p4',
      title: 'T-Shirt',
      description: 'Just T-Shirt what do you want',
      price: 6.99,
      imageUrl:
          'https://www.weekday.com/upload/uf/386/386126993d8db02661198393b2832889.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p5',
      title: 'Sneakers',
      description: 'Do sport every day!',
      price: 109.99,
      imageUrl:
          'https://www.hervia.com/uploads/images/products/verylarge/hervia.com-raf-simons-runner-antei-purple-sneakers-160069897820798-0003-Layer-1.jpg',
      isFavorite: false,
    )
  ];

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  // var _showFavoritesOnly = false;

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  List<Product> get items {
    // if (_showFavoritesOnly == true) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    //возвращает копию объекта, а не сам объект
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addProduct(Product product) {
    //_items.add();
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    );
    _items.add(newProduct);
    //_items.insert(0, newProduct); //at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else
      print('...');
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
