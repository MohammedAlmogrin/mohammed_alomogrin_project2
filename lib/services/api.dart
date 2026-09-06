import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mohammed_almogrin_project2/models/place_iteme.dart';
import 'package:mohammed_almogrin_project2/models/place_detail.dart';
class Api {
Future<List<PlaceIteme>> getData() async {
String link = "https://en.wikipedia.org/w/api.php?action=query&generator=categorymembers&gcmtitle=Category:Archaeological_sites_in_Saudi_Arabia&gcmlimit=25&prop=pageimages&piprop=thumbnail&pithumbsize=600&format=json&origin=*";

   var uri = Uri.parse(link);

    var response = await http.get(uri);
    var responseBody = response.body;
    var jsonBody = jsonDecode(
      responseBody,
    );
    
    List<PlaceIteme> list = [];

    var pages = jsonBody["query"]["pages"];

    for (var place in pages.values) {
      PlaceIteme model = PlaceIteme.fromJson(place);
      list.add(model);
    }
    return list;
}
Future<PlaceDetail> getDetailData(int pageId) async {
    String link = "https://en.wikipedia.org/w/api.php?action=query&prop=extracts|pageimages&exintro&explaintext&pithumbsize=1000&pageids=$pageId&format=json&origin=*";
    
    var uri = Uri.parse(link);
    var response = await http.get(uri);
    var responseBody = response.body;
    var jsonBody = jsonDecode(responseBody);

    var pageData = jsonBody["query"]["pages"][pageId.toString()];
    return PlaceDetail.fromJson(pageData);

}
}