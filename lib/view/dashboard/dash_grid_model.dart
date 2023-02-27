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
      image: 'assets/images/admission.png',
      color: Color(0xffE4EEF8)),
  GridModel(
      title: 'Upload Document',
      image: 'assets/images/document.png',
      color: Color(0xffF7E9E8)),
  GridModel(
      title: 'Course Serarch',
      image: 'assets/images/batch.png',
      color: Color(0xffE1F2E2)),
  GridModel(
      title: 'Application Information',
      image: 'assets/images/aps.png',
      color: Color(0xffD9EAF2)),
  GridModel(
      title: 'Batch Details',
      image: 'assets/images/course.png',
      color: Color(0xffE1E1F2)),
  GridModel(
      title: 'Event Details',
      image: 'assets/images/event.png',
      color: Color(0xffF2E1E5)),
  GridModel(
      title: 'Branch Location',
      image: 'assets/images/location.png',
      color: Color(0xffF2F0E1)),
  GridModel(
      title: 'Apply Visa Upload',
      image: 'assets/images/Visad.png',
      color: Color(0xffE1F2EB)),

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
    image: 'assets/images/Ukicon.png',
  ),
  GridModel(
    title: 'Germany',
    image: 'assets/images/Germanyicon.png',
  ),
  GridModel(
    title: 'Canada',
    image: 'assets/images/canadaicon.png',
  ),
  GridModel(
    title: 'Australia',
    image: 'assets/images/Australiaicon.png',
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
