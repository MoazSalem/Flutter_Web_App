class AllReviews {
  final int? id;
  final int? page;
  final List<Reviews>? results;
  final int? totalPages;
  final int? totalResults;

  AllReviews({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  AllReviews.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        page = json['page'] as int?,
        results = (json['results'] as List?)
            ?.map((dynamic e) => Reviews.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages = json['total_pages'] as int?,
        totalResults = json['total_results'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'page': page,
        'results': results?.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults
      };
}

class Reviews {
  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final String? createdAt;
  final String? id;
  final String? updatedAt;
  final String? url;

  Reviews({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  Reviews.fromJson(Map<String, dynamic> json)
      : author = json['author'] as String?,
        authorDetails = (json['author_details'] as Map<String, dynamic>?) != null
            ? AuthorDetails.fromJson(json['author_details'] as Map<String, dynamic>)
            : null,
        content = json['content'] as String?,
        createdAt = json['created_at'] as String?,
        id = json['id'] as String?,
        updatedAt = json['updated_at'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {
        'author': author,
        'author_details': authorDetails?.toJson(),
        'content': content,
        'created_at': createdAt,
        'id': id,
        'updated_at': updatedAt,
        'url': url
      };
}

class AuthorDetails {
  final String? name;
  final String? username;
  final String? avatarPath;
  final int? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  AuthorDetails.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        username = json['username'] as String?,
        avatarPath = json['avatar_path'] as String?,
        rating = json['rating'] as int?;

  Map<String, dynamic> toJson() =>
      {'name': name, 'username': username, 'avatar_path': avatarPath, 'rating': rating};
}
