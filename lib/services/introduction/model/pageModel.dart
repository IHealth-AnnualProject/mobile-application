class PageModel {
  final String title;
  final List<dynamic> pageColor;
  final String bubble;
  final String mainImage;
  final String body;

  PageModel({this.title, this.pageColor, this.bubble, this.mainImage, this.body});

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      title: json['Title'],
      pageColor: json['PageColor'],
      bubble: json['Bubble'],
      body: json['Body'],
      mainImage: json['MainImage']
    );
  }

  @override
  String toString() {
    return "title, $title - pageColor, $pageColor - bubble, $bubble - mainImage, $mainImage";
  }
}
