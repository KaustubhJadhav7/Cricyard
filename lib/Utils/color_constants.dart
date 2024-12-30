import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray5001 = fromHex('#f6f7fb');

  static Color purple211 = const Color.fromARGB(255, 93, 63, 211);

  static Color gray5002 = fromHex('#f8f9fa');

  static Color black900B2 = fromHex('#b2000000');

  static Color gray5003 = fromHex('#fafcff');

  static Color lightBlue100 = fromHex('#b0e5fc');

  static Color gray80049 = fromHex('#493c3c43');

  static Color yellow9003f = fromHex('#3feb9612');

  static Color iris = fromHex('5D3FD3');

  static Color red200 = fromHex('#fa9a9a');

  static Color gray4004c = fromHex('#4cc4c4c4');

  static Color blueA200 = fromHex('#468ee5');

  static Color greenA100 = fromHex('#b5eacd');

  static Color black9003f = fromHex('#3f000000');

  static Color gray30099 = fromHex('#99e4e4e4');

  static Color black90087 = fromHex('#87000000');

  static Color whiteA70099 = fromHex('#99ffffff');

  static Color black90001 = fromHex('#000000');

  static Color blueGray90002 = fromHex('#24363c');

  static Color blueGray90001 = fromHex('#2e3637');

  static Color blueGray700 = fromHex('#535763');

  static Color blueGray900 = fromHex('#262b35');

  static Color black90003 = fromHex('#0b0a0a');

  static Color black90002 = fromHex('#090b0d');

  static Color redA700 = fromHex('#d80027');

  static Color black90004 = fromHex('#000000');

  static Color gray400 = fromHex('#c4c4c4');

  static Color blue900 = fromHex('#003399');

  static Color blueGray100 = fromHex('#d6dae2');

  static Color blue700 = fromHex('#1976d2');

  static Color blueGray300 = fromHex('#9ea8ba');

  static Color amber500 = fromHex('#feb909');

  static Color redA200 = fromHex('#fe555d');

  static Color gray80099 = fromHex('#993c3c43');

  static Color black9000c = fromHex('#0c000000');

  static Color gray200 = fromHex('#efefef');

  static Color gray60026 = fromHex('#266d6d6d');

  static Color blue50 = fromHex('#e0ebff');

  static Color indigo400 = fromHex('#4168d7');

  static Color blueGray1006c = fromHex('#6cd1d3d4');

  static Color black90011 = fromHex('#11000000');

  static Color gray40001 = fromHex('#b3b3b3');

  static Color whiteA70067 = fromHex('#67ffffff');

  static Color gray10001 = fromHex('#fbf1f2');

  static Color black90019 = fromHex('#19000000');

  static Color blueGray40001 = fromHex('#888888');

  static Color whiteA700 = fromHex('#ffffff');

  static Color blueGray50 = fromHex('#eaecf0');

  static Color red700 = fromHex('#d03329');

  static Color blueA700 = fromHex('#0061ff');

  static Color blueGray10001 = fromHex('#d6d6d6');

  static Color gray60019 = fromHex('#197e7e7e');

  static Color green600 = fromHex('#349765');

  static Color blueA70001 = fromHex('#0068ff');

  static Color gray50 = fromHex('#f9fbff');

  static Color red100 = fromHex('#f6d6d4');

  static Color blueGray20001 = fromHex('#adb5bd');

  static Color black900 = fromHex('#000919');

  static Color blueGray800 = fromHex('#37334d');

  static Color blue5001 = fromHex('#eef4ff');

  static Color deepOrange400 = fromHex('#d58c48');

  static Color deepOrangeA400 = fromHex('#ff4b00');

  static Color gray70011 = fromHex('#11555555');

  static Color indigoA20033 = fromHex('#334871e3');

  static Color gray90002 = fromHex('#0d062d');

  static Color gray700 = fromHex('#666666');

  static Color blueGray200 = fromHex('#bac1ce');

  static Color blueGray400 = fromHex('#74839d');

  static Color blue800 = fromHex('#2953c7');

  static Color blueGray600 = fromHex('#5f6c86');

  static Color gray900 = fromHex('#2a2a2a');

  static Color gray90001 = fromHex('#212529');

  static Color gray300 = fromHex('#d2efe0');

  static Color gray30001 = fromHex('#e3e4e5');

  static Color gray100 = fromHex('#f3f4f5');

  static Color black90075 = fromHex('#75000000');

  static Color deepOrangeA10033 = fromHex('#33dfa874');

  static Color gray70026 = fromHex('#26555555');

  static Color black90033 = fromHex('#33000000');

  static Color blue200 = fromHex('#a6c8ff');

  static Color purple900 = Colors.purple.shade900;

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
