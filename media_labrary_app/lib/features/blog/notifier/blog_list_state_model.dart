import '../data/model/blog_list_model.dart';

class BlogListStateModel {
  final BlogListModel? blogListModel;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;

  BlogListStateModel({
    this.blogListModel,
    this.isLoading = true,
    this.isError = false,
    this.isSuccess = false,
  });

  BlogListStateModel copyWith({
    BlogListModel? blogListModel,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
  }) {
    return BlogListStateModel(
      blogListModel: blogListModel ?? this.blogListModel,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
