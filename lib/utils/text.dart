import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

/// all [Global] size texts with fonts
/// linkifyText Widget

Text capText(
  String text,
  BuildContext context, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  bool? isButton,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
                color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: fontSize,
                height: lineHeight,
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                decoration: decoration),
      ),
    );
Text bodyMedText(
  String text,
  BuildContext context, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  bool? isButton,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
                color: color ??
                    (isButton != null
                        ? (isButton
                            ? (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            : null)
                        : null),
                decorationColor: color,
                fontSize: fontSize,
                height: lineHeight,
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                decoration: decoration),
      ),
    );
Text bodyLargeText(
  String text,
  BuildContext context, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  bool? isButton,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: fontWeight ?? FontWeight.bold,
                letterSpacing: letterSpacing,
                color: color ??
                    (isButton != null
                        ? (isButton
                            ? (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            : null)
                        : null),
                decorationColor: color,
                fontSize: fontSize,
                height: lineHeight,
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                decoration: decoration),
      ),
    );
Text titleLargeText(
  String text,
  BuildContext context, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  bool? isButton,
  double? fontSize = 18,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: fontWeight ?? FontWeight.bold,
                letterSpacing: letterSpacing,
                color: color ??
                    (isButton != null
                        ? (isButton
                            ? (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            : null)
                        : null),
                decorationColor: color,
                fontSize: fontSize,
                height: lineHeight,
                fontFamily: Theme.of(context).textTheme.bodySmall?.fontFamily,
                decoration: decoration),
      ),
    );

class ShadowText extends StatelessWidget {
  const ShadowText(
      {super.key, required this.data, this.shadowData, this.style});

  final Widget data;
  final Widget? shadowData;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          // new Positioned(
          //   top: 1.0,
          //   left: 1.0,
          //   bottom: 1,
          //   child: data,
          // ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: data,
          ),
          // new BackdropFilter(
          //   filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          //   child: data,
          // ),
        ],
      ),
    );
  }
}

linkifyText(String text,
        [double fs = 11.0,
        TextStyle style = const TextStyle(color: Colors.grey),
        TextStyle linkStyle = const TextStyle(color: Colors.blue)]) =>
    Linkify(
      onOpen: (link) async {
        if (!await launchUrl(Uri.parse(link.url),
            mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch ${link.url}');
        }
      },
      text: text,
      style: style.copyWith(fontSize: fs),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      linkStyle: linkStyle.copyWith(fontSize: fs),
    );



class AadhaarNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final trimmedValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (trimmedValue.length <= 12) {
      // Format the Aadhaar number into groups of 4 digits
      final formattedValue = trimmedValue.replaceAllMapped(
        RegExp(r'(\d{4})(?=\d)'),
            (Match match) => '${match.group(1)} ',
      );

      return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }

    return oldValue;
  }
}

class PanCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newValueText = newValue.text;

    if (newValueText.length <= 5) {
      // Format the first 5 characters as uppercase letters
      final formattedValue = newValueText.toUpperCase();
      return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    } else if (newValueText.length > 5 && newValueText.length < 10) {
      // Format the next 4 characters as digits
      final formattedValue =
          '${newValueText.substring(0, 5)}${newValueText.substring(5, 9).replaceAll(RegExp('[^0-9]'), '')}';

      return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    } else if (newValueText.length > 9 && newValueText.length == 10) {
      // Format the first 5 characters as uppercase letters
      final formattedValue =
          '${newValueText.substring(0, 9)}${newValueText.substring(9, 10).replaceAll(RegExp('[^a-z]'), '').toUpperCase()}';
      print(formattedValue);
      print('${newValueText.substring(9, 10)}');
      return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    } else {
      // Restrict input length to 10 characters
      return oldValue;
    }
  }
}

class NoDoubleDecimalFormatter extends TextInputFormatter {
  NoDoubleDecimalFormatter({this.allowOneDecimal = 0});
  final int allowOneDecimal;
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Check if the new value contains more than one decimal point
    final decimalCount = newValue.text.split('.').length - 1;
    if (decimalCount > allowOneDecimal) {
      // Return the old value to prevent the double decimal input
      return oldValue;
    }

    return newValue;
  }
}
