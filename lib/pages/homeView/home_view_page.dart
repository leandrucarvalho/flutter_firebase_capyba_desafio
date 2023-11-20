import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/pages/restricted/restricted_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/custom_drawer.dart';
import '../home/home_page.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  PageController pageController = PageController(initialPage: 0);
  int posicaoPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Desafio App Flutter"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        drawer: const CustomDrawer(),
        body: PageView(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              posicaoPage = value;
            });
          },
          children: const [
            HomePage(),
            RestrictedPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green,
          onTap: (value) {
            pageController.jumpToPage(value);
          },
          currentIndex: posicaoPage,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: FaIcon(
                FontAwesomeIcons.house,
              ),
            ),
            BottomNavigationBarItem(
              label: "Restrito",
              icon: FaIcon(
                FontAwesomeIcons.lock,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
