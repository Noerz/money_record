import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultMargin = 24.0;
const double minimumMargin = 16.0;

final h1 = GoogleFonts.inter(fontSize: 48.0, fontWeight: FontWeight.w800);
final h2 = GoogleFonts.inter(fontSize: 30.0, fontWeight: FontWeight.w600);
final h3 = GoogleFonts.inter(fontSize: 24.0, fontWeight: FontWeight.w600);
final h4 = GoogleFonts.inter(fontSize: 20.0, fontWeight: FontWeight.w600);
final p = GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.w400);
final pBold = GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.w600);
final bodyMedium =
    GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w500);
final subtle = GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w400);
final smallRegular =
    GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w400);
final small2 = GoogleFonts.inter(fontSize: 10.0, fontWeight: FontWeight.w400);

final roundedNone = BorderRadius.circular(0);
final roundedSm = BorderRadius.circular(2);
final rounded = BorderRadius.circular(4);
final roundedMd = BorderRadius.circular(6);
final roundedLg = BorderRadius.circular(8);
final roundedXl = BorderRadius.circular(12);
final rounded2Xl = BorderRadius.circular(16);
final rounded3Xl = BorderRadius.circular(24);
final roundedFull = BorderRadius.circular(50);

const shadowSm = [
  BoxShadow(
    offset: Offset(0.0, 1.0),
    blurRadius: 2.0,
    color: Color.fromRGBO(0, 0, 0, 0.05),
  ),
];
const shadow = [
  BoxShadow(
    offset: Offset(0.0, 1.0),
    blurRadius: 2.0,
    color: Color.fromRGBO(0, 0, 0, 0.06),
  ),
  BoxShadow(
    offset: Offset(0.0, 1.0),
    blurRadius: 3.0,
    color: Color.fromRGBO(0, 0, 0, 0.1),
  ),
];
const shadowMd = [
  BoxShadow(
    offset: Offset(0.0, 2.0),
    blurRadius: 4.0,
    spreadRadius: -1,
    color: Color.fromRGBO(0, 0, 0, 0.06),
  ),
  BoxShadow(
    offset: Offset(0.0, 4.0),
    blurRadius: 6.0,
    spreadRadius: -1,
    color: Color.fromRGBO(0, 0, 0, 0.1),
  ),
];
const shadowLg = [
  BoxShadow(
    offset: Offset(0.0, 4.0),
    blurRadius: 6.0,
    spreadRadius: -2,
    color: Color.fromRGBO(0, 0, 0, 0.05),
  ),
  BoxShadow(
    offset: Offset(0.0, 10.0),
    blurRadius: 15.0,
    spreadRadius: -3,
    color: Color.fromRGBO(0, 0, 0, 0.1),
  ),
];
const shadowXl = [
  BoxShadow(
    offset: Offset(0.0, 10.0),
    blurRadius: 10.0,
    spreadRadius: -5,
    color: Color.fromRGBO(0, 0, 0, 0.04),
  ),
  BoxShadow(
    offset: Offset(0.0, 20.0),
    blurRadius: 25.0,
    spreadRadius: -5,
    color: Color.fromRGBO(0, 0, 0, 0.1),
  ),
];
const shadow2Xl = [
  BoxShadow(
    offset: Offset(0.0, 25.0),
    blurRadius: 50.0,
    spreadRadius: -12,
    color: Color.fromRGBO(0, 0, 0, 0.25),
  ),
];

abstract class CustomColors {
  static const Color wireframe50 = Color(0xFFF8FAFC);
  static const Color wireframe100 = Color(0xFFF1F5F9);
  static const Color wireframe200 = Color(0xFFE2E8F0);
  static const Color wireframe300 = Color(0xFFCBD5E1);
  static const Color wireframe400 = Color(0xFF94A3B8);
  static const Color wireframe500 = Color(0xFF64748B);
  static const Color wireframe600 = Color(0xFF475569);
  static const Color wireframe700 = Color(0xFF334155);
  static const Color wireframe800 = Color(0xFF1E293B);
  static const Color wireframe900 = Color(0xFF0F172A);
}
