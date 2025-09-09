import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bottomnav extends StatelessWidget {
  const Bottomnav({super.key, this.currentIndex = 0});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
       height: 80,
        padding: EdgeInsets.fromLTRB(0, 8, 0, 6),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: _BottomNavContent(currentIndex: currentIndex),
      ),
    );
  }
}

class _BottomNavContent extends StatelessWidget {
  const _BottomNavContent({required this.currentIndex});

  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    final bool isHome = currentIndex == 0;
    final bool isKategori = currentIndex == 1;
    final bool isPromo = currentIndex == 2;
    final bool isProfile = currentIndex == 3;
    final int isActive = 0xff6A84F9;
    final int nonActive = 0xffC2DDEA;

    Widget buildItem({
      required String activeIcon,
      required String inactiveIcon,
      required String label,
      required bool active,
      required VoidCallback onTap,
    }) {
      final String assetPath = active ? activeIcon : inactiveIcon;
      final Color textColor = active ? Color(isActive) : Color(nonActive);
      return GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(assetPath,width: 30,),
            Text(label, style: TextStyle(color: textColor))
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildItem(
          activeIcon: 'svg/active/homeActive.svg',
          inactiveIcon: 'svg/nonactive/home.svg',
          label: 'Home',
          active: isHome,
          onTap: () {
            if (!isHome) {
              Navigator.pushReplacementNamed(context, '/beranda');
            }
          },
        ),
        buildItem(
          activeIcon: 'svg/active/categoryActive.svg',
          inactiveIcon: 'svg/nonactive/category.svg',
          label: 'Kategori',
          active: isKategori,
          onTap: () {
            if (!isKategori) {
              Navigator.pushReplacementNamed(context, '/kategori');
            }
          },
        ),
        buildItem(
          activeIcon:'svg/active/promoActive.svg' ,
          inactiveIcon:'svg/nonactive/promo.svg' ,
          label:'Promo' ,
          active:isPromo ,
          onTap: () {
            if (!isPromo) {
              Navigator.pushReplacementNamed(context, '/promo');
            }
          },
        ),
        buildItem(
          activeIcon: 'svg/active/profileActive.svg',
          inactiveIcon: 'svg/nonactive/profile.svg',
          label: 'Profile',
          active: isProfile,
          onTap: () {
            if (!isProfile) {
             Navigator.pushReplacementNamed(context, '/profil');
            }
          },
        ),
      ],
    );
  }
}
