import 'package:get/get.dart';
import 'package:spontracker/controllers/cart_controller.dart';
import 'package:spontracker/data/repository/popular_sponsor_repo.dart';
import 'package:spontracker/models/cart_model.dart';
import 'package:spontracker/models/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 1;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = cart.existInCart(product);
    //if exist
    //get from storage _inCartItems=3
    //print("ada atau kaga " + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    //print("Jumlah yg di kart ada " + _inCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);

    _quantity = 0;

    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          "The quantity is" +
          value.quantity.toString());
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
