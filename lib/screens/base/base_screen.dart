import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/admin_users/admin_users_screen.dart';
import 'package:loja_virtual/screens/home/home_screen.dart';
import 'package:loja_virtual/screens/products/products_screen.dart';
import 'package:provider/provider.dart';


class BaseScreen extends StatelessWidget {

  final PageController pageController =PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              Scaffold(
                drawer: const CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Pedidos "EM BREVE"'),
                  centerTitle: true,
                ),
              ),
              Scaffold(
                drawer: const CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Endereços'),
                  centerTitle: true,
                ),
              ),
              if(userManager.adminEnabled)
                ...[
                  AdminUsersScreen(),
                  Scaffold(
                    drawer: const CustomDrawer(),
                    appBar: AppBar(
                      title: const Text('Pedidos'),
                      centerTitle: true,
                    ),
                  ),
                ]
            ],
          );
        },
      ),
    );
  }
}
