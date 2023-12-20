import 'package:flutter/material.dart';

class GridModel {
  String? image;
  String? title;
  Color? color;

  GridModel({
    this.image,
    this.title,
    this.color,
  });
}

List<GridModel> dashgrid = [
  GridModel(
      title: 'Education Fair',
      image: 'assets/images/gofairimg.png',
      color: const Color(0xffF4F3FF)),
  GridModel(
      title: 'My Qualifications',
      image: 'assets/images/qualiimg.png',
      color: const Color(0xffEEF5FF)),
  GridModel(
      title: 'Upload More Document',
      image: 'assets/images/moreimg.png',
      color: const Color(0xffFFEEF0)),
  GridModel(
      title: 'Course Search',
      image: 'assets/images/searchimg.png',
      color: const Color(0xffF4F3FF)),
  GridModel(
      title: 'My Applications',
      image: 'assets/images/myappimg.png',
      color: const Color(0xffF2F9F6)),
  GridModel(
      title: 'Test Prep',
      image: 'assets/images/testimg.png',
      color: const Color(0xffF9F2F6)),
  GridModel(
      title: 'Event Details',
      image: 'assets/images/evnimg.png',
      color: const Color(0xffFFEEF9)),
  GridModel(
      title: 'Branch Office',
      image: 'assets/images/branimg.png',
      color: const Color(0xffFFF6EE)),
  GridModel(
      title: 'Upload Visa Document',
      image: 'assets/images/visimg.png',
      color: const Color(0xffF3FCFF)),
];
// ignore: non_constant_identifier_names

List<GridModel> Countrycourse = [
  GridModel(
    title: 'Uk',
    image: 'assets/images/c1.png',
  ),
  GridModel(
    title: 'Germany',
    image: 'assets/images/c2.png',
  ),
  GridModel(
    title: 'Canada',
    image: 'assets/images/c3.png',
  ),
  GridModel(
    title: 'Australia',
    image: 'assets/images/c2.png',
  ),
];

List<GridModel> batchlist = [
  GridModel(
      title: 'IELTS',
      image: 'assets/images/Ielts.png',
      color: const Color(0xffF3FCFF)),
  GridModel(
      title: 'GRE',
      image: 'assets/images/GRE.png',
      color: const Color(0xffFFEEF0)),
  GridModel(
      title: 'GMAT',
      image: 'assets/images/GMAT.png',
      color: const Color(0xffF4F3FF)),
  GridModel(
      title: 'SAT',
      image: 'assets/images/sat.png',
      color: const Color(0xffF2F9F6)),
  GridModel(
      title: 'PTE',
      image: 'assets/images/PTE.png',
      color: const Color(0xffF9F2F6)),
];

List<GridModel> gofairlist = [
  GridModel(
      title: 'Book Appointment',
      image: 'assets/images/booking.png',
      color: const Color(0xffF3FCFF)),
  GridModel(
      title: 'Visit Education Fair',
      image: 'assets/images/gpfairnew.png',
      color: const Color(0xffFFEEF0)),
  GridModel(
      title: 'Appointment History',
      image: 'assets/images/folder.png',
      color: const Color(0xffF2F9F6)),
];
