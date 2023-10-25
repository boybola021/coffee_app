



import 'package:coffee_app/service/constants/colors.dart';
import 'package:coffee_app/service/constants/fonts.dart';
import 'package:coffee_app/service/constants/icons.dart';
import 'package:coffee_app/service/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/coffee/coffee_bloc.dart';
import 'home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  late AnimationController _controllerScale1;
  late Animation<double> _animationScale1;

  late AnimationController _controllerScale2;
  late Animation<double> _animationScale2;

  late AnimationController _controllerBorderRadius;
  late Animation<BorderRadius?> _animationBorderRadius;


  @override
  void dispose() {
    _controller.dispose();
    _controllerScale1.dispose();
    _controllerScale2.dispose();
    _controllerBorderRadius.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerBorderRadius = AnimationController(vsync: this,
    duration: const Duration(seconds: 1),);
    _animationBorderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(360.0).r,
      end:  BorderRadius.circular(0),
    ).animate(
      CurvedAnimation(parent: _controllerBorderRadius, curve: Curves.easeInQuart)
    );
    _controllerBorderRadius.forward();

    _controller = AnimationController(vsync: this,
    duration: const Duration(milliseconds: 1400),
    );
    _animation = Tween<Alignment>(begin: Alignment.centerLeft,end: Alignment.center).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInQuart,
      ),
    );
    _controller.forward();

    _controllerScale2 = AnimationController(vsync: this,
     duration: const Duration(seconds: 1),
    );
    _animationScale2 = Tween<double>(begin: 0,end: 1).animate(
      CurvedAnimation(parent: _controllerScale2, curve: Curves.easeInQuart),
    );
    _controllerScale2.forward();

     _controllerScale1 = AnimationController(vsync: this,
     duration: const Duration(seconds: 2),
    );
    _animationScale1 = Tween<double>(begin: 0,end: 1).animate(
      CurvedAnimation(parent: _controllerScale1, curve: Curves.easeInQuart),
    );
    _controllerScale1.forward();
    navigate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CoffeeBloc>()..add(GetInitial())..add(GetTradicional());
  }

  void navigate()async{
    await Future.delayed(
      const Duration(seconds: 5),
    );
    if(mounted) Navigator.of(context).push (_createRout());
  }

  Route _createRout(){

    return PageRouteBuilder(
      pageBuilder: (context,animation,secondaryAnimation) => const HomePage(),
      transitionsBuilder: (context,animation,secondaryAnimation,child){
        const begin = Offset(1, 0);
        const end = Offset(0, 0);
        const curve = Curves.linear;
        var tween = Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
        animation.drive(tween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: CustomColors.purpleDark,
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _animationScale1,
              builder: (context, child) {
                return AnimatedBuilder(
                  animation: _animationBorderRadius,
                  builder: (context, child) {
                    return Container(
                      height: height *
                          _animationScale1.value,
                      width: width *
                          _animationScale1.value,
                      decoration: BoxDecoration(
                        borderRadius: _animationBorderRadius.value,
                        color: CustomColors.purple,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return SizedBox(
                    width: width * _controller.value / 2,
                    child: Center(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              height: 100,
                              width: 60,
                              child: Image(image: CustomIcons.coffeeIcon),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            FadeTransition(
                              opacity: _animationScale1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Strings.coffee,
                                      style: textStyleForRobotoW700(
                                          color: Colors.white,
                                          fontSize: 35,
                                          height: 1)),
                                  Text(
                                    Strings.delivery,
                                    style: textStyleForRoboto(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      fontSize: 30,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                    ),
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}
