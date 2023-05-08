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
      title: 'Admission Details',
      image: 'assets/images/addnew1.png',
      color: Color(0xffEEF5FF)),
  GridModel(
      title: 'Upload Document',
      image: 'assets/images/documentic.png',
      color: Color(0xffFFEEF0)),
  GridModel(
      title: 'Course Serarch',
      image: 'assets/images/courseic.png',
      color: Color(0xffF4F3FF)),
  GridModel(
      title: 'Application Information',
      image: 'assets/images/applicationic.png',
      color: Color(0xffF2F9F6)),
  GridModel(
      title: 'Batch Details',
      image: 'assets/images/batchic.png',
      color: Color(0xffF9F2F6)),
  GridModel(
      title: 'Event Details',
      image: 'assets/images/eventic.png',
      color: Color(0xffFFEEF9)),
  GridModel(
      title: 'Branch Location',
      image: 'assets/images/locationic.png',
      color: Color(0xffFFF6EE)),
  GridModel(
      title: 'Apply Visa Upload',
      image: 'assets/images/Visaic.png',
      color: Color(0xffF3FCFF)),

  // GridModel(
  //   title: 'Admission Details',
  //   image: 'assets/images/timer.json',
  // ),
  // GridModel(
  //   title: 'Upload Document',
  //   image: 'assets/images/edu.json',
  // ),
  // GridModel(
  //   title: 'Course Serarch',
  //   image: 'assets/images/timer.json',
  // ),
  // GridModel(
  //   title: 'Application Information',
  //   image: 'assets/images/edu.json',
  // ),
  // GridModel(
  //   title: 'Batch Details',
  //   image: 'assets/images/timer.json',
  // ),
  // GridModel(
  //   title: 'Event Details',
  //   image: 'assets/images/edu.json',
  // ),
  // GridModel(
  //   title: 'Branch Location',
  //   image: 'assets/images/timer.json',
  // ),
  // GridModel(
  //   title: 'Apply Visa Upload',
  //   image: 'assets/images/edu.json',
  // ),
];

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

List<GridModel> universitylist = [
  GridModel(
    title: 'SRD Berlin University of Applied SciencesRanking',
    image: 'assets/images/uicon1.png',
  ),
  GridModel(
    title: 'The University of Findlay',
    image: 'assets/images/uicon2.png',
  ),
  GridModel(
    title: 'Cambrian College',
    image: 'assets/images/uicon3.png',
  ),
];
