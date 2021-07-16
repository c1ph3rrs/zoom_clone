import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle myStyle(double size,[Color? colors, FontWeight fw = FontWeight.w700]){
  return GoogleFonts.montserrat(
    fontSize: size,
    color: colors,
    fontWeight: fw,
  );
}

CollectionReference userCollection = FirebaseFirestore.instance.collection("users");