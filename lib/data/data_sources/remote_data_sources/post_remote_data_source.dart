import 'package:challenge_pinapp/data/data_sources/interfaces/i_post_remote_data_source.dart';
import 'package:dio/dio.dart';


import '../../../domain/entities/failure.dart';
import '../../dtos/post_dto.dart';

class PostRemoteDataSource extends IPostRemoteDataSource{
  final Dio _dio;

  PostRemoteDataSource(this._dio);

  @override
  Future<List<PostDTO>> getPosts() async {
    try{
      final response = await _dio.get('/posts');
      final body = response.data;
      final posts = PostDTO.fromJsonList(body);
      return posts;
    }catch(e){
      throw PostFailure();
    }
  }
}