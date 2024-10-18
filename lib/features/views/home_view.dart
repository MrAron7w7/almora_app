import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const name = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _pageController = PageController();

  int _currentIndex = 0;

  //  Funcion de navegacion a otra iamgen con carousel
  void _goToNext() {
    if (_currentIndex < 9) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Funcion de navegacion a la imagen anterior
  void _goToPrevius() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; // Obtenemos el tamaño de la pantalla

    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            // Carousel de los productos
            Stack(
              children: [
                SizedBox(
                  height: 240,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 10,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://picsum.photos/id/$index/500/300'),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Botton de retroceso
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: _goToPrevius,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Ir a la imagen siguiente
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: _goToNext,
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Subtitle
            Container(
              child: const Column(
                children: [
                  //

                  // Imagen

                  // Carousel

                  // Categorias
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }
}
