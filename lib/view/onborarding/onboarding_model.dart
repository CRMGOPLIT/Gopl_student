class IntroModel {
  String? image;
  String? title;
  String? discription;
  IntroModel({this.image, this.title, this.discription});
}

List<IntroModel> contents = [
  IntroModel(
    title: 'Counselling',
    image: 'assets/images/intro1.png',
    discription:
        'Order from the best local restaurants with easy, on-demand delivery.',
  ),
  IntroModel(
    title: 'Visa',
    image: 'assets/images/visapl.png',
    discription:
        'Free delivery for new customers via Apple Pay and others payment methods.',
  ),
  IntroModel(
    title: 'Ielts Coaching',
    image: 'assets/images/intro3.png',
    discription:
        'Easily find your type of food craving and you’ll get delivery in wide range.',
  )
];
