import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_labrary_app/feature/blog/data/model/blog_list_model.dart';
import 'package:media_labrary_app/feature/blog/notifier/blog_list_state_model.dart';

import '../notifier/blog_list_notifier.dart';

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
    BlogListStateModel stateModel = ref.watch(_blogListProvider);
    if (stateModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (stateModel.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Something Wrong"),
            FilledButton(
              onPressed: () {
                ref.read(_blogListProvider.notifier).getBlogList();
              },
              child: Text("Try Again"),
            ),
          ],
        ),
      );
    } else {
      List<BlogData> blogList = stateModel.blogListModel?.data ?? [];
      if (blogList.isEmpty) {
        return Center(child: Text("Empty Blog List"));
      }
      return ListView.builder(
        itemCount: blogList.length,
        itemBuilder: (content, index) {
          BlogData blog = blogList[index];
          String? coverImage = blog.coverImage;
          String? comment = blog.comments?.length.toString() ?? "";
          return Column(
            children: [
              coverImage == null
                  ? Icon(Icons.image_outlined)
                  : Image.network(coverImage),
              Text(blog.title ?? ""),
              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(blog.author ?? ""),
                  Text("$comment-comments")

                ],
              )
            ],
          );
        },
      );
    }
  }
}
