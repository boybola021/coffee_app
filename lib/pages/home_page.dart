import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/coffee/coffee_bloc.dart';
import '../service/constants/colors.dart';
import '../views/animated_coffee_image.dart';
import '../views/animated_text_widget.dart';
import '../views/animeted_app_bar.dart';
import '../views/app_bar_widget.dart';
import '../views/draggable_widget.dart';
import '../views/only_three_widget.dart';
import '../views/text_field_controller.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late CarouselController _carouselController;

  late AnimationController _controller;
  late Animation<Alignment> _animation;

  late AnimationController _controllerSize;
  late Animation<double> _animationSize;

  late AnimationController _controllerScale;
  late Animation<double> _animationScale;

  late TextEditingController _searchController;

  @override
  void initState() {
    _carouselController = CarouselController();

    _searchController = TextEditingController();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation =
        Tween<Alignment>(begin: Alignment.centerRight, end: Alignment.center)
            .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInQuart,
          ),
        );
    _controller.forward();

    _controllerSize = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _controllerScale =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationScale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controllerScale,
        curve: Curves.easeInQuart,
      ),
    );
    _controllerScale.forward();
    BlocProvider.of<CoffeeBloc>(context).add(GetInitial());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationSize = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controllerSize,
        // curve: Curves.easeOutCubic,
        curve: Curves.easeInQuart,
      ),
    );
    _controllerSize.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int findIndex({required int index}) {
    return index == 0
        ? 3
        : index == 1
        ? 6
        : index == 2
        ? 11
        : index;
  }

  double present = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.white,
      child: Stack(
        children: [
          Column(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    height: MediaQuery.sizeOf(context).height *
                        _controller.value /
                        2,
                    color: CustomColors.gray_100,
                  );
                },
              ),
              Container(
                height: MediaQuery.sizeOf(context).height / 2,
                color: Colors.white,
              )
            ],
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      AnimetedAppBarWidget(
                        animationScale: _animationScale,
                        controllerScale: _controllerScale,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AnimatedTextWidget(
                          animationScale: _animationScale,
                          controllerScale: _controllerScale),
                      const SizedBox(
                        height: 20,
                      ),

                      AnimatedBuilder(
                        animation: _animationScale,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _controllerScale.value,
                            child: TextFieldWidget(
                              controller: _searchController,
                            ),
                          );
                        },
                      ),
                      AnimatedCoffeeImage(
                          animationScale: _animationScale,
                          controllerScale: _controllerScale),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  height: MediaQuery.sizeOf(context).height * (1 - present),
                  child: Transform.scale(
                    scale: (1 - present) > 0.6 ? (1 - present) : 0.6,
                    child: AnimatedBuilder(
                      animation: _animationSize,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animationSize.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: SizedBox(
                              height: 390,
                              child: BlocBuilder<CoffeeBloc, CoffeeState>(
                                builder:
                                    (BuildContext context, CoffeeState state) {
                                  return CarouselSlider(
                                    carouselController: _carouselController,
                                    options: CarouselOptions(
                                      clipBehavior: Clip.none,
                                      enableInfiniteScroll: false,
                                      autoPlayInterval:
                                      const Duration(seconds: 3),
                                      viewportFraction: 0.65,
                                      padEnds: true,
                                      autoPlayCurve: Curves.linear,
                                      height: 270,
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                    ),
                                    items: state.initial
                                        .map((coffee) => SizedBox(
                                      width: 210,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  DetailPage(
                                                    coffee: coffee,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: OnlyThreeWidget(
                                          assetImage: coffee.assetImage,
                                          explain: coffee.description,
                                          title: coffee.type.name,
                                          name: coffee.title,
                                          prise:
                                          coffee.price.toString(),
                                          scale: 1.2,
                                          assetScale: 1.5,
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationSize,
                  builder: (context, child) {
                    return NotificationListener<
                        DraggableScrollableNotification>(
                      onNotification: (notification) {
                        final present1 = 2 * notification.extent - 0.4;
                        present = present1 > 1 ? 1 : present1;
                        setState(() {});
                        return true;
                      },
                      child: Transform.scale(
                          scale: _animationSize.value,
                          child: const DraggableWidget()),
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  height: 140 * present,
                  child: const AppBarWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
