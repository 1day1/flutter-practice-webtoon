import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class ApiService {
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String endpointToday = 'today';

  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$endpointToday');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // logger.d(response.body);
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        // logger.d(webtoon.toString());
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(toon);
        // logger.d(toon.title);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // logger.d(response.body);
      final Map<String, dynamic> webtoon = jsonDecode(response.body);

      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(String id) async {
    List<WebtoonEpisodeModel> episodesInstance = [];

    final url = Uri.parse('$baseUrl/$id/episodes');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        final scene = WebtoonEpisodeModel.fromJson(episode);
        episodesInstance.add(scene);
      }
      return episodesInstance;
    }
    throw Error();
  }
}
