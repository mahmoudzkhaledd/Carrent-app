import 'package:carrent/Features/Core/Packages/AllPackages/View/AllPackages.dart';
import 'package:carrent/GeneralWidgets/Image.dart';
import 'package:carrent/Helper/Helper.dart';
import 'package:carrent/Shared/SharedTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../GeneralWidgets/AppText.dart';
import '../../../../../services/GeneralServices/NetworkService.dart';
import '../../../../../services/GeneralServices/StorageService.dart';
import '../../../../Home/HomePage/View/HomePage.dart';
import '../../../StartingPage/View/StartingPage.dart';
import '../../Services/SplashScreenService.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> fade;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fade = Tween<double>(begin: 1, end: 0).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback(loginTokne);
    super.initState();
  }

  void loginTokne(a) async {
    String? token = StorageServices.instance.getUserToken();

    if (token == null) {
      Get.offAll(() => const LandingPage());
      return;
    }
    NetworkService.refreshAccessToken(token);
    bool res = await SplashScreenService().checkAuth();
    if (res) {
      Get.offAll(() => const HomePage());
    } else {
      Get.offAll(() => const LandingPage());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildBackground() {
    return ClipPath(
      clipper: ClipContainer(),
      child: Container(
        width: double.infinity,
        height: Helper.size(context).height - 100,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomImage(
                'Vehicle Sale-amico.png',
                width: 300,
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: fade,
                builder: (ctx, ani) => FadeTransition(
                  opacity: fade,
                  child: AppText(
                    "Car Rent",
                    style: FontStyles.bigTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ClipContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height;
    path.lineTo(0, height - 50);
    final firstControlPoint = Offset(size.width / 4, height);
    final firstEndPoint = Offset(size.width / 2, height - 60);
    final secondControlPoint =
        Offset(size.width - (size.width / 4), height - 110);
    final secondEndPoint = Offset(size.width, height - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
