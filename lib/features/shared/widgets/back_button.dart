import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(211, 209, 216, 0.3),
            offset: Offset(5, 10), // Desplazamiento horizontal y vertical
            blurRadius: 20, // Radio de desenfoque
            spreadRadius: 0, // Extensión de la sombra
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          context.pop();
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
          ),
        ),
      ),
    );
  }
}
