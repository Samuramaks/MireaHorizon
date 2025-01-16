// class NewsItem {
//   final String title;
//   final String date;
//   final String imageUrl;
//   final String link;
//   final String description;

//   NewsItem({
//     required this.title,
//     required this.date,
//     required this.imageUrl,
//     required this.link,
//     required this.description,
//   });

//   factory NewsItem.fromMap(Map<String, dynamic> map) {
//     return NewsItem(
//       title: map['title'] ?? '',
//       date: map['date'] ?? '',
//       imageUrl: map['imageUrl'] ?? '',
//       link: map['link'] ?? '',
//       description: map['description'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'date': date,
//       'imageUrl': imageUrl,
//       'link': link,
//       'description': description,
//     };
//   }
// }

class NewsItem {
  final String title;
  final String date;
  final String imageUrl;
  final String link;
  final String description;

  NewsItem({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.link,
    required this.description,
  });
}
