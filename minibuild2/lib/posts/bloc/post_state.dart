part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

sealed class PostState extends Equatable {
  const PostState(
      {this.status = PostStatus.initial,
      this.posts = const <Post>[],
      this.hasReachedMax = false});
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
}
