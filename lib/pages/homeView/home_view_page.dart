import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/custom_drawer.dart';
import '../home/home_page.dart';
import '../restricted/restricted_page.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final user = FirebaseAuth.instance.currentUser!;
  PageController pageController = PageController(initialPage: 0);
  int posicaoPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desafio App Flutter"),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            posicaoPage = value;
          });
        },
        children: [
          const HomePage(),
          user.emailVerified
              ? const RestrictedPage()
              : const Center(
                  child: Text("Acesso negado, por favor, confirme seu email")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.deepPurpleAccent,
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
    );
  }
}
