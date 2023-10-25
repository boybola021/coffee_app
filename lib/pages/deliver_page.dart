import 'package:coffee_app/pages/home_page.dart';
import 'package:coffee_app/service/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../blocs/cart/cart_bloc.dart';
import '../service/constants/colors.dart';
import '../service/constants/strings.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/gif/lottie.json",
                  height: 200.h, width: MediaQuery
                      .sizeOf(context)
                      .width),
              SizedBox(
                height: 20.h,
              ),
              Text(
                Strings.uhuPedidoConfirmado,
                style: textStyleForBaloo_2W700(
                  color: CustomColors.yellowDark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  Strings.agora,
                  textAlign: TextAlign.center,
                  style: textStyleForRobotoW700(
                    fontSize: 13.sp,
                    color: CustomColors.gray_400,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 45.h,
                width: MediaQuery
                    .sizeOf(context)
                    .width / 1.7,
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: () {
                        // BlocProvider.of<CartBloc>(context).add(
                        //   CartEventItemRemove(item: ),
                        // );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(CustomColors.purpleDark),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        Strings.home.toUpperCase(),
                        style: textStyleForRobotoW700(
                          color: CustomColors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
