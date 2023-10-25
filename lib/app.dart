
import 'package:coffee_app/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/coffee/coffee_bloc.dart';
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CoffeeBloc()),
      ],
      child:  ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: const IntroPage(),
        ),
      ),
    );
  }
}
