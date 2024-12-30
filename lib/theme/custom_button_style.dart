import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  static BoxDecoration get fullyBlack => BoxDecoration(
        borderRadius: BorderRadius.circular(24.h),
        color: Colors.black,
      );
  static BoxDecoration
      get gradientOnErrorContainerToOnErrorContainerDecoration => BoxDecoration(
            borderRadius: BorderRadius.circular(24.h),
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.5),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: const Offset(
                  4,
                  38,
                ),
              )
            ],
            gradient: LinearGradient(
              begin: const Alignment(0.32, 0),
              end: const Alignment(0.75, 0),
              colors: [
                theme.colorScheme.onErrorContainer.withOpacity(0.7),
                theme.colorScheme.onErrorContainer.withOpacity(0.7)
              ],
            ),
          );

  static BoxDecoration get gradientGrayBToOnErrorContainerDecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(24.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.5),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              4,
              38,
            ),
          )
        ],
        color: Colors.black,
        gradient: LinearGradient(
          begin: const Alignment(0.32, 0),
          end: const Alignment(0.75, 0),
          colors: [
            appTheme.black900,
            theme.colorScheme.onErrorContainer.withOpacity(1)
          ],
        ),
      );

  static BoxDecoration get gradientWhiteAToWhiteADecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(17.h),
        gradient: LinearGradient(
          begin: const Alignment(0.32, 0),
          end: const Alignment(0.75, 0),
          colors: [
            appTheme.whiteA700.withOpacity(0.7),
            appTheme.whiteA700.withOpacity(0.7)
          ],
        ),
      );
// Outline button style
  static ButtonStyle get outlineBlack => ElevatedButton.styleFrom(
        backgroundColor: appTheme.blueA100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        shadowColor: appTheme.black900.withOpacity(0.4),
        elevation: 2,
      );
// text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );

  // Filled button style
  static ButtonStyle get fillBlueA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.blueA20001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21.h),
        ),
      );
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
      );
  static ButtonStyle get fillPrimaryTL16 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.h),
        ),
      );
  static ButtonStyle get fillWhiteA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.whiteA700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
      );
// Gradient button style
  static BoxDecoration get gradientGrayBToWhiteADecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(24.h),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.5),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              4,
              38,
            ),
          )
        ],
        gradient: LinearGradient(
          begin: Alignment(0.32, 0),
          end: Alignment(0.75, 0),
          colors: [appTheme.gray100B2, appTheme.whiteA700.withOpacity(0.7)],
        ),
      );

  static BoxDecoration get gradientWhiteAToWhiteATL25Decoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(25.h),
        gradient: LinearGradient(
          begin: Alignment(0.32, 0),
          end: Alignment(0.75, 0),
          colors: [
            appTheme.whiteA700.withOpacity(0.7),
            appTheme.whiteA700.withOpacity(0.7)
          ],
        ),
      );
}
