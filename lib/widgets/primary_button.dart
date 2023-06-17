import 'package:FurEverHome/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? width;
  final double height;
  final GestureTapCallback? onPressed;
  final bool isLoading;
  final double borderRadius;
  final EdgeInsets? margin;
  final Widget? child;
  final bool isActive;

  final double elevation;

  const PrimaryButton(this.text,
      {Key? key,
      this.fontSize = 18,
      this.width,
      this.height = 48,
      this.onPressed,
      this.borderRadius = 8,
      this.margin = EdgeInsets.zero,
      this.isLoading = false,
      this.child,
      this.elevation = 4,
      this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      margin: margin,
      height: height,
      decoration: BoxDecoration(
        color: isActive ? AppColors.buttonColor : AppColors.buttonInActiveColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black03,
            blurRadius: elevation,
          ),
        ],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        color: onPressed == null ? Colors.white38 : Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Align(
            child: !isLoading
                ? child ??
                    FittedBox(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                      ),
                    )
                : const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
