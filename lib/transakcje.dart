import 'package:flutter/material.dart';

class Transakcja { //to nie ma byc widget tylko plan objektu, nie chce zeby to bylo renderowane wiec nie ma extends

final String id;
final String title;
final double amount;
final DateTime date;    //wbudowane w dart

Transakcja({
  @required this.id,
  @required this.title,
  @required this.amount,
  @required this.date,
});
}