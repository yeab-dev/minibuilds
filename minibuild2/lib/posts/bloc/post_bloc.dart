import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:minibuild2/posts/models/post.dart';
part 'post_event.dart';
part 'post_state.dart';

const int _postLimit = 20;

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(_onPostFetched);
  }
  final http.Client httpClient;

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts(startIndex: state.posts.length);
        if (posts.isEmpty) {
          return emit(state.copyWith(hasReachedMax: true));
        }
        emit(
          state.copyWith(
              status: PostStatus.success, posts: [...state.posts, ...posts]),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts({required int startIndex}) async {
    final response = await httpClient.get(
      Uri.https(
        "jsonplaceholder.typicode.com",
        "/posts",
        <String, String>{'_start': '{$startIndex}', '_limit': '$_postLimit'},
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map["id"] as int,
          title: map["title"] as String,
          body: map["body"] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
