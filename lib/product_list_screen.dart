import 'package:flutter/material.dart';
import 'package:untitled1/product_detail_screen.dart';

import 'product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  static const _duration = Duration(milliseconds: 500);
  List<Product> productList = [];
  late double _size;
  final _pageCoffeeController = PageController(viewportFraction: 0.3);
  final _pageTextController = PageController();
  double? _currentPage = 0.0;
  double? _currentTextPage = 0.0;

  void _coffeeScrollLister() {
    debugPrint("=_coffeeScrollLister==");
    setState(() {
      _currentPage = _pageCoffeeController.page;
    });
  }

  void _textScrollLister() {
    debugPrint("=_coffeeScrollLister==");
    setState(() {
      _currentTextPage = _pageTextController.page;
    });
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeeScrollLister);
    _pageTextController.addListener(_textScrollLister);

    productList
        .add(Product("Caramel Cold Drink", "assets/images/1.png", "100Rs"));
    productList
        .add(Product("Iced Coffe Mocha", "assets/images/2.png", "200Rs"));
    productList.add(
        Product("Caramelized Pecan Latte", "assets/images/3.png", "300Rs"));
    productList
        .add(Product("Toffee Nut Latte", "assets/images/4.png", "200Rs"));
    productList.add(Product("Capuchino", "assets/images/5.png", "120Rs"));
    productList
        .add(Product("Toffee Nut Iced Latte", "assets/images/6.png", "150Rs"));
    productList.add(Product("Americano", "assets/images/7.png", "110Rs"));
    productList.add(Product(
        "Vietnamese-Style Iced Coffee", "assets/images/8.png", "200Rs"));
    productList.add(Product("Black Tea Latte", "assets/images/9.png", "230Rs"));
    productList
        .add(Product("Classic Irish Coffee", "assets/images/10.png", "100Rs"));
    productList.add(Product("Toffee Nut ", "assets/images/11.png", "110Rs"));
    productList.add(Product("Crunch Latte", "assets/images/12.png", "110Rs"));
    productList.add(Product("Summer Juice", "assets/images/13.png", "110Rs"));
    productList.add(Product("Mix Juice", "assets/images/14.png", "90Rs"));
    productList.add(
        Product("Summer Ice Chocolate Shake", "assets/images/15.jpg", "90Rs"));

    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeeScrollLister);
    _pageTextController.removeListener(_textScrollLister);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Stack(
        children: [_productImageBuilder(size), _productNameListBuilder(size)],
      ),
    );
  }

  Widget _productNameListBuilder(Size size) {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        height: 120,
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    itemCount: productList.length,
                    controller: _pageTextController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final opacity = (1 - (index - _currentTextPage!).abs())
                          .clamp(0.0, 1.0);
                      return Opacity(
                          opacity: opacity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.2),
                            child: Hero(
                              tag: "text_${productList[index].name}",
                              child: Material(
                                child: Text(
                                  productList[index].name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                          ));
                    })),
            const SizedBox(
              height: 10,
            ),
            AnimatedSwitcher(
              duration: _duration,
              key: Key(
                productList[_currentTextPage!.toInt()].name,
              ),
              child: Text(productList[_currentTextPage!.toInt()].price,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30)),
            )
          ],
        ));
  }

  Widget _productImageBuilder(Size size) {
    return Transform.scale(
        scale: 1.6,
        alignment: Alignment.bottomCenter,
        child: PageView.builder(
          controller: _pageCoffeeController,
          scrollDirection: Axis.vertical,
          itemCount: productList.length + 1,
          onPageChanged: (value) {
            _pageTextController.animateToPage(value,
                duration: _duration, curve: Curves.linear);
          },
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox.shrink();
            }
            //  return Image.asset(productList[index-1].image);
            final result = _currentPage!! - index + 1;
            final value = -0.4 * result + 1;
            final opacity = value.clamp(0.0, 1.0);
            debugPrint(result.toString());
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 650),
                      pageBuilder: (context, animation, _) {
                        return FadeTransition(
                          opacity: animation,
                          child: ProductDetailScreen(
                            product: productList[index - 1],
                          ),
                        );
                      }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(0.0, size.height / 2.6 * (1 - value).abs())
                      ..scale(value),
                    child: Opacity(
                        opacity: opacity,
                        child: Hero(
                            tag: "img_${productList[index - 1].name}",
                            child: Material(
                                color: Colors.transparent,
                                child: Image.asset(
                                    productList[index - 1].image)))),
                  ),
                ));
          },
        ));
  }
}
