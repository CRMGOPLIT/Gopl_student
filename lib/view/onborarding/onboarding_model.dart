class IntroModel {
  String? image;
  String? title;
  String? discription;
  IntroModel({this.image, this.title, this.discription});
}

List<IntroModel> contents = [
  IntroModel(
    title: 'Career Counselling',
    image: 'assets/images/on1.png',
    discription:
        'Global Opportunities Pvt Ltd has experienced counselors with years of expertise.',
  ),
  IntroModel(
    title: 'Visa',
    image: 'assets/images/visaimg1.png',
    discription:
        'Our visa expert always know the shortest route to process the Visa faster.',
  ),
  IntroModel(
    title: 'Our Services',
    image: 'assets/images/intro3.png',
    discription:
        'IELTS,GRE,GMAT,SAT and PTE Coaching British council registered faculty for Coaching & insights on how to score a good band.',
  )
];
