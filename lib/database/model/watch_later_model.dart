class WatchLater {
  int? id;
  String title;
  String imageUrl;
  double rating;
  String date;
  bool isChecked;

  WatchLater(
      {this.id,
      required this.title,
      required this.imageUrl,
      required this.rating,
      required this.date,
      required this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
      'date': date,
      'isChecked': isChecked ? 1 : 0
    };
  }

  static WatchLater fromMap(Map<String, dynamic> map) {
    return WatchLater(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      rating: map['rating'],
      date: map['date'],
      isChecked: map['isChecked'] == 1,
    );
  }
}
