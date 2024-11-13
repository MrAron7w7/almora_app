import 'package:almora_pedidos/core/utils/utils.dart';
import 'package:almora_pedidos/features/models/product.dart';
import 'package:almora_pedidos/features/viewmodels/auth/firebase_auth_repo.dart';
import 'package:almora_pedidos/features/viewmodels/providers/product_provider.dart';
import 'package:almora_pedidos/features/views/views.dart';
import 'package:almora_pedidos/shared/components/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  static const name = 'home_view';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with TickerProviderStateMixin {
  final _pageController = PageController();
  String _selectedCategory = 'Todos'; // por dfecto
  Flutter3DController controller = Flutter3DController();

  final AuthService _auth = AuthService();

  Future<void> _signOut() async {
    showDialogDelete(
      context,
      title: 'Cerrar sesión',
      content: '¿Desea cerrar sesión?',
      actionAcept: () async {
        await _auth.logOut();
        context.pop();
      },
    );
  }

  // Controles de animaciones con variables de ejecucion tardia
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final counterCart = ref.watch(counterQuantityItemProvider);

    //print('counterCart: $counterCart');

    return Scaffold(
      appBar: _buildAppBar(counterCart),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: size.width,
        height: size.height,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                const CustomLabel(
                  text: 'Muebles en\nEstilos únicos',
                  size: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                gapH(20),

                // Filtrado de categorías
                _buildCategoryFilters(),

                gapH(20),

                // Carrusel de imágenes
                Banner(
                  message: 'Ofertas',
                  location: BannerLocation.topStart,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 180.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                    ),
                    items: [
                      'https://images.pexels.com/photos/1350789/pexels-photo-1350789.jpeg?cs=srgb&dl=pexels-eric-mufasa-578798-1350789.jpg&fm=jpg',
                      'https://images.afw.com/images/thumbs/0190889_living-room-furniture_600.jpeg',
                      'https://img.freepik.com/foto-gratis/diseno-interiores-marcos-fotos-plantas_23-2149385437.jpg',
                    ].map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),

                gapH(20),

                // Lista de productos filtrados
                Expanded(
                  child: _buildProductList(context, _selectedCategory),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Filtrado de catogiras
  Widget _buildCategoryFilters() {
    final categories = ['Todos', 'Dormitorio', 'Comedor', 'Sala'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(.1)
                    : null,
                //borderRadius: BorderRadius.circular(20),
              ),
              child: CustomLabel(
                text: category,
                color: Colors.black, // isSelected ? Colors.white :
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Listra de producto selectionados
  Widget _buildProductList(BuildContext context, String category) {
    // Filtrar los productos según la categoría seleccionada
    final filteredProducts = category == 'Todos'
        ? products
        : products.where((product) => product.category == category).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount: filteredProducts.length,
            itemBuilder: (context, int index) {
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () {
                  context.push('/${DetailView.name}', extra: product);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(.1),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Hero(
                        tag: product.description,
                        child: Image.network(
                          product.image.toString(),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabel(
                              text: product.name,
                              size: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 8),
                            CustomLabel(
                              text: '${product.price} Soles',
                              size: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const Divider(),
          if (_selectedCategory == 'Dormitorio') ...[
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Flutter3DViewer(
                controller: controller,
                src: 'assets/glb/sillon.glb',
                activeGestureInterceptor: true,
                enableTouch: true,
                progressBarColor: Colors.orange,
              ),
            ),
          ] else if (_selectedCategory == 'Comedor') ...[
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Flutter3DViewer(
                controller: controller,
                src: 'assets/glb/ropero.glb',
                activeGestureInterceptor: true,
                enableTouch: true,
                progressBarColor: Colors.orange,
              ),
            ),
          ]
        ],
      ),
    );
  }

  // Menu de circulos
  Column _buildCircleMenu() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 4,
              backgroundColor: Colors.black,
            ),
            SizedBox(width: 8),
            CircleAvatar(
              radius: 4,
              backgroundColor: Colors.black,
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 4,
              backgroundColor: Colors.black,
            ),
            SizedBox(width: 8),
            CircleAvatar(
              radius: 4,
              backgroundColor: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }

  AppBar _buildAppBar(int counterCart) {
    return AppBar(
      leading: _buildCircleMenu(),
      actions: [
        IconButton(
          onPressed: () => context.push('/${FavoriteView.name}'),
          icon: const Icon(
            Icons.favorite,
            size: 24,
            color: Color(0xff79111C),
          ),
        ),
        IconButton(
          onPressed: () => context.push('/${ShoppingCartView.name}'),
          icon: Badge(
            isLabelVisible: counterCart != 0 ? true : false,
            backgroundColor: const Color(0xff79111C),
            label: CustomLabel(text: '$counterCart'),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 24,
            ),
          ),
        ),
        IconButton(
          onPressed: _signOut,
          icon: const Icon(
            Icons.logout_outlined,
          ),
        ),
      ],
      backgroundColor: Colors.amber.shade200,
      elevation: 0,
    );
  }
}
