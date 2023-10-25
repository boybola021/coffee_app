import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../model/coffiee_model.dart';
import '../service/constants/colors.dart';
import '../service/constants/fonts.dart';
import '../service/constants/icons.dart';
import '../service/constants/strings.dart';
import '../views/icon_image_button.dart';
import 'deliver_page.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.carrinho,
          style: textStyleForBaloo_2W700(
              color: CustomColors.gray_100, fontSize: 20),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ListView.builder(
                  itemCount: state.item.length,
                    itemBuilder: (context, index) {
                      final items = state.item;
                      print("====>$items");
                      return SizedBox(
                        height: 150,
                        child: ListTile(
                          onTap: () {},
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                items[index].coffeeModel.title,
                                style: textStyleForRobotoW400(
                                    color: CustomColors.gray_200, fontSize: 16),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    textAlign: TextAlign.end,
                                    Strings.rDollar,
                                    style: textStyleForBaloo_2W700(
                                        color: CustomColors.gray_100,
                                        fontSize: 12,
                                        height: 1.3),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    tradicionais[index].price.toString(),
                                    style: textStyleForBaloo_2W700(
                                        color: CustomColors.gray_100,
                                        fontSize: 16,
                                        height: 1.3),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          leading: Transform.scale(
                            scale: 1.5,
                            child: Transform.translate(
                              offset: const Offset(0, -30),
                              child: Image(
                                height: 90,
                                width: 90,
                                image: items[index].coffeeModel.assetImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          subtitle: SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].size.portion,
                                  style: textStyleForRobotoW400(
                                      color: CustomColors.gray_400,
                                      fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: CustomColors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              width: 1,
                                              color: CustomColors.gray_500)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconImageButton(
                                            assetImage: CustomIcons.minus,
                                            onPressed: () {
                                              items[index].quantity != 1
                                                  ? BlocProvider.of<CartBloc>(
                                                  context)
                                                  .add(CartEventCountDecrement(
                                                  item: items[index]))
                                                  : BlocProvider.of<CartBloc>(
                                                  context)
                                                  .add(CartEventItemRemove(
                                                  item: items[index]));
                                            },
                                          ),
                                          Text(
                                              items[index].quantity.toString()),
                                          IconImageButton(
                                            assetImage: CustomIcons.plus,
                                            onPressed: () {
                                              BlocProvider.of<CartBloc>(context)
                                                  .add(CartEvenCountIncrement(
                                                  item: items[index]));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconImageButton(
                                      iconSize: 50,
                                      assetImage: CustomIcons.deleteIcon,
                                      onPressed: () {
                                        BlocProvider.of<CartBloc>(context).add(
                                            CartEventItemRemove(
                                                item: items[index]));
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 200,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: CustomColors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: CustomColors.gray_700,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.valorTotal,
                          style: textStyleForRobotoW400(
                              color: CustomColors.gray_100, fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.end,
                              Strings.rDollar,
                              style: textStyleForBaloo_2W700(
                                  color: CustomColors.gray_100,
                                  fontSize: 15,
                                  height: 1.3),
                            ),
                            BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                                return Text(
                                  state.item
                                      .fold<double>(
                                      0.0,
                                          (previousValue, element) =>
                                      previousValue +
                                          element.total * element.quantity)
                                      .toStringAsFixed(2),
                                  textAlign: TextAlign.center,
                                  style: textStyleForBaloo_2W700(
                                      color: CustomColors.gray_100,
                                      fontSize: 20,
                                      height: 1.3),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.sizeOf(context).width,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => const DeliveryPage()));
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(CustomColors.yellowDark),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          Strings.confirmarPedido.toUpperCase(),
                          style: textStyleForBaloo_2W700(
                            color: CustomColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  },
);
  }
}
