import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_labrary_app/features/blog/ui/screens/blog_items_widget.dart';
import '../../../../const/common_widgets/cover_image_widget.dart';
import '../../../../const/common_widgets/empty_list_widget.dart';
import '../../../../const/common_widgets/try_again_widget.dart';
import '../../data/model/blog_list_model.dart';
import '../../notifier/blog_list_notifier.dart';
import '../../notifier/blog_list_state_model.dart';

class BlogScreen extends ConsumerStatefulWidget {
  const BlogScreen({super.key});

  @override
  ConsumerState<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends ConsumerState<BlogScreen> {
  final BlogListProvider _blogListProvider = BlogListProvider(() {
    return BlogListNotifier();
  });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_blogListProvider.notifier).getBlogList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    BlogListStateModel stateModel = ref.watch(_blogListProvider);

    if (stateModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (stateModel.isError) {
      return TryAgainWidget(colorScheme: colorScheme);
    } else {
      List<BlogData>? blogList = stateModel.blogListModel?.data;
      if (blogList?.isEmpty == true) {
        return EmptyListWidget(
          colorScheme: colorScheme,
          showName: "Empty Blog List",
        );
      }
      return ListView.builder(
        itemCount: blogList!.length,
        itemBuilder: (content, index) {
          BlogData blog = blogList[index];
          return BlogItemsWidget(imageUrl: blog.coverImage);
        },
      );
    }
  }
}


