import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

class AppStyledText extends StatelessWidget {
  const AppStyledText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.defaultFontWeight = FontWeight.w300,
    this.boldFontWeight = FontWeight.w500,
    this.onLinkPressed,
    this.style,
    this.textColor,
  });

  final String text;
  final Color? textColor;
  final Function()? onLinkPressed;
  final TextAlign textAlign;
  final FontWeight defaultFontWeight;
  final FontWeight boldFontWeight;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text,
      textAlign: textAlign,
      tags: {
        'bold': StyledTextTag(),
        'link': StyledTextActionTag(
          (_, attrs) => onLinkPressed?.call(),
        ),
        'underline': StyledTextActionTag(
          (_, attrs) => onLinkPressed?.call(),
        ),
      },
    );
  }
}
