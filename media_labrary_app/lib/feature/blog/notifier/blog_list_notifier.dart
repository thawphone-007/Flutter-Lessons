import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/blog_list_model.dart';
import '../data/services/blog_services.dart';
import 'blog_list_state_model.dart';

typedef BlogListProvider =
    NotifierProvider<BlogListNotifier, BlogListStateModel>;

class BlogListNotifier extends Notifier<BlogListStateModel> {
  final BlogServices _blogServices = BlogServices();

  @override
  BlogListStateModel build() {
    return BlogListStateModel();
  }

  void getBlogList() async {
    try {
      state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
      BlogListModel blogListModel = await _blogServices.getBlogList();
      state = state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        blogListModel: blogListModel,
      );
    } catch (e) {
      state = state.copyWith(isError: true, isLoading: false, isSuccess: false);
    }
  }
}
