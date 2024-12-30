import 'package:cricyard/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'theme_helper.dart';

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get openSans {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }

  TextStyle get dMSans {
    return copyWith(
      fontFamily: 'DM Sans',
    );
  }

  TextStyle get sourceSansPro {
    return copyWith(
      fontFamily: 'Source Sans Pro',
    );
  }

  TextStyle get dMMono {
    return copyWith(
      fontFamily: 'DM Mono',
    );
  }

  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }

  TextStyle get hammersmithOne {
    return copyWith(
      fontFamily: 'Hammersmith One',
    );
  }

  TextStyle get urbanist {
    return copyWith(
      fontFamily: 'Urbanist',
    );
  }

  TextStyle get sFPro {
    return copyWith(
      fontFamily: 'SF Pro',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  static get titleLargePoppinsBlack40 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 40.fSize,
      );
  static get titleSmallPoppinsWhite =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22.fSize,
      );
  static get titleSmallRed700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.red700,
        fontWeight: FontWeight.w700,
      );
  static get titleLargePoppinsBlack =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: Colors.black,
        fontSize: 30.fSize,
      );
  static get titleMediumMediumWhit => theme.textTheme.titleMedium!.copyWith(
      fontSize: 16.fSize, fontWeight: FontWeight.w500, color: Colors.white);

  // Headline text style
  static get headlineLargePoppinsBlack900 =>
      theme.textTheme.headlineLarge!.poppins.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
// Label text style
  static get labelLargeCyan900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.cyan900,
      );
  static get labelLargeGray500 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray500,
        fontWeight: FontWeight.w500,
      );
// Title text style
  static get titleSmallMontserratBlack900 =>
      theme.textTheme.titleSmall!.montserrat.copyWith(
        color: appTheme.black900,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallPoppinsWhiteA700 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.whiteA700,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w700,
      );

  static get headlineSmallBlack900 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallBlack900_1 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
      );
// Headline text style
  static get headlineLargeGray900 => theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.gray900,
      );
// Title text style
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumErrorContainer => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18.fSize,
      );

  static get titleSmallDeeppurpleA400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.deepPurpleA400,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get titleSmallGray600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray600,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppinsBlack900 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallPoppinsDeeppurpleA400 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.deepPurpleA400,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallPoppinsGray90001 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.gray90001,
      );
  static get titleSmallPoppinsPrimaryContainer =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppinsPrimaryContainer_1 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.primaryContainer,
      );

  static get titleSmallPrimaryContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );

  // Body text style
  static get bodyMediumPoppinsBluegray50 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.blueGray50,
      );
  static get bodySmallMontserratBluegray400 =>
      theme.textTheme.bodySmall!.montserrat.copyWith(
        color: appTheme.blueGray400,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallOpenSansOnPrimaryContainer =>
      theme.textTheme.bodySmall!.openSans.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontWeight: FontWeight.w400,
      );
  static get bodySmallRegular => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallYellow900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.yellow900,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
      );
// Headline text style
  static get headlineLargeBold => theme.textTheme.headlineLarge!.copyWith(
        fontSize: 32.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineLargeExtraBold => theme.textTheme.headlineLarge!.copyWith(
        fontSize: 32.fSize,
        fontWeight: FontWeight.w800,
      );
  static get headlineSmallOnPrimaryContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 24.fSize,
      );
  static get headlineSmallSemiBold => theme.textTheme.headlineSmall!.copyWith(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w600,
      );
// Label text style
  static get labelLargeBluegray700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray700,
      );
  static get labelLargeMontserratCyan900 =>
      theme.textTheme.labelLarge!.montserrat.copyWith(
        color: appTheme.cyan900,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeMontserratGray500 =>
      theme.textTheme.labelLarge!.montserrat.copyWith(
        color: appTheme.gray500,
      );
  static get labelLargeMontserratTeal100 =>
      theme.textTheme.labelLarge!.montserrat.copyWith(
        color: appTheme.teal100,
        fontWeight: FontWeight.w700,
      );
  static get labelMediumGray500 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.gray500,
      );
  static get labelMediumGreen80001 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.green80001,
      );
  static get labelMediumMontserratCyan900 =>
      theme.textTheme.labelMedium!.montserrat.copyWith(
        color: appTheme.cyan900,
        fontWeight: FontWeight.w700,
      );
  static get labelMediumOpenSans =>
      theme.textTheme.labelMedium!.openSans.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get labelMediumRed700 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.red700,
      );
  static get labelSmallBold => theme.textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
// Open text style
  static get openSansOnPrimaryContainer => TextStyle(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).openSans;
// Title text style
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPoppinsOnPrimaryContainer =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPoppinsOnPrimaryContainerMedium =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPoppinsOnPrimaryContainer_1 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );

  static get bodySmallOpenSansOnErrorContainer =>
      theme.textTheme.bodySmall!.openSans.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 8.fSize,
      );
// Headline text style
  static get headlineLargeSemiBold => theme.textTheme.headlineLarge!.copyWith(
        fontSize: 30.fSize,
        fontWeight: FontWeight.w600,
      );
  static get headlineSmallOnErrorContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 24.fSize,
      );

// Label text style
  static get labelLargeDMSansOnPrimaryContainer =>
      theme.textTheme.labelLarge!.dMSans.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 13.fSize,
      );
  static get labelLargeDMSansOnPrimaryContainer_1 =>
      theme.textTheme.labelLarge!.dMSans.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get labelLargeErrorContainer => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get labelLarge_1 => theme.textTheme.labelLarge!;

// Open text style
  static get openSansOnErrorContainer => TextStyle(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).openSans;
// Title text style
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBlack900Medium => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumGray300 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray300,
      );
  static get titleMediumGray50 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray50,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumSourceSansPro =>
      theme.textTheme.titleMedium!.sourceSansPro.copyWith(
        fontSize: 16.fSize,
      );

  static get titleSmallPoppinsOnErrorContainer =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );

  // Body text style
  static get bodyLargeGray50 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray50,
      );
// Label text style
  static get labelLargeAmber300 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.amber300,
      );
  static get labelLargePoppinsGray50 =>
      theme.textTheme.labelLarge!.poppins.copyWith(
        color: appTheme.gray50,
        fontWeight: FontWeight.w700,
      );
  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargePrimaryBold => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static get labelLargePrimaryExtraBold => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w800,
      );
  static get labelLargeSFProTextErrorContainer =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeSFProTextErrorContainer_1 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get labelLargeSFProTextPrimary =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeSFProTextPrimaryMedium =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.53),
        fontWeight: FontWeight.w500,
      );
  static get labelLargeSFProTextPrimaryMedium_1 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.56),
        fontWeight: FontWeight.w500,
      );
  static get labelLargeSFProTextPrimary_1 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.7),
      );
  static get labelLargeSFProTextPrimary_2 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargeSFProTextRed600 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: appTheme.red600,
      );
  static get labelLargeSFProTextWhiteA700 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w500,
      );
  static get labelLargeWhiteA700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get labelLargeWhiteA700ExtraBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w800,
      );
  static get labelLargeWhiteA700_1 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA700.withOpacity(0.9),
      );
  static get labelLargeWhiteA700_2 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA700.withOpacity(0.9),
      );
  static get labelMediumPrimary => theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w800,
      );
  static get labelMediumSFProTextRed600 =>
      theme.textTheme.labelMedium!.sFProText.copyWith(
        color: appTheme.red600,
      );
  static get labelMediumWhiteA700 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w600,
      );
  static get labelMediumWhiteA700ExtraBold =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.whiteA700.withOpacity(0.7),
        fontWeight: FontWeight.w800,
      );
  static get labelMediumWhiteA700ExtraBold_1 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w800,
      );
// Title text style
  static get titleLargeWhiteA700 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleLargeWhiteA700_1 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleMediumDeeporange300 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.deepOrange300,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w800,
      );
  static get titleMediumPoppins =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPoppinsGray50 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.gray50,
        fontSize: 18.fSize,
      );
  static get titleMediumRed600 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.red600,
      );
  static get titleMediumSFProText => theme.textTheme.titleMedium!.sFProText;
}
