import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presensi_universitas_bina_insan_app/core/theme/color_theme.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.outfit(
        color: color ?? ColorApp.black,
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
      textAlign: textAlign,
    );
  }
}

class TextH1 extends StatelessWidget {
  const TextH1({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.outfit(
          color: color ?? ColorApp.black,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      textAlign: textAlign,
    );
  }
}

class TextH2 extends StatelessWidget {
  const TextH2({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.outfit(
          color: color ?? ColorApp.black,
          fontSize: 17,
          fontWeight: FontWeight.bold),
      textAlign: textAlign,
    );
  }
}

class TextP extends StatelessWidget {
  const TextP({
    super.key,
    this.maxlines,
    required this.text,
    this.color,
    this.textAlign,
  });

  final int? maxlines;
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.outfit(
        color: color ?? ColorApp.secondary,
        fontSize: 15,
      ),
      maxLines: maxlines,
      overflow: TextOverflow.visible,
      textAlign: textAlign,
    );
  }
}

class TextC extends StatelessWidget {
  const TextC({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.outfit(
        color: color ?? ColorApp.secondary.withOpacity(0.7),
        fontSize: 13,
      ),
      textAlign: textAlign,
    );
  }
}
