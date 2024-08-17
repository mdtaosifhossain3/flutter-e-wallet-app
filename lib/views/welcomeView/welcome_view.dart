import 'package:ewallet/globals/custom_button.dart';
import 'package:ewallet/utils/colors.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: CircularBottomClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Appcolor.primary, // Replace with Appcolor.primary
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 96,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "UpayApp",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                    bottom: 100,
                    child: Text.rich(
                      style: TextStyle(color: Colors.white),
                      TextSpan(
                        text: 'The Most Secure Methods for ', // Non-bold text
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Transferring Money', // Bold text
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
            height: size.height * .24,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CustomButton(title: "Create New account"),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Alredy Have an Account?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CircularBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50); // Adjust this value for curve depth
    path.quadraticBezierTo(
      size.width / 2, size.height + 50, // Adjust this value for curve height
      size.width, size.height - 50, // Adjust this value for curve depth
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CircularBottomClipper oldClipper) => false;
}
