import 'dart:convert';

import 'package:http/http.dart';

class Todo{
    final int userId; 
    final int id; 
    final String title; 
    final bool completed; 

    Todo({required this.userId, required this.id, required this.title, required this.completed});

    factory Todo.fromJson(Map<String, dynamic> json){
        return Todo(
            userId: json['userId'],
            id: json['id'], 
            title: json['title'], 
            completed: json['completed']
        ); 
    }

    @override
    String toString(){
        return ('userId: $userId \nid: $id\ntitle: $title\ncompleted: $completed\n'); 
    }
}
List<Todo> parseTodos(String jsonArray){
    final parsed = jsonDecode(jsonArray).cast<Map<String, dynamic>>(); 
    //print('parsedTodos: ${parsed}'); 
    return parsed.map<Todo>((json) => Todo.fromJson(json)).toList(); 

}
class HTTPMethods{
    Future<List<Todo>> makeGetRequest() async{
        ///get all users 
        ///if get a specific user, insert index
        var url = 'https://jsonplaceholder.typicode.com/todos'; 
        Response response = await get(Uri.parse(url)); 
        int statusCode = response.statusCode; 
        Map <String, String> headers = response.headers; 
        String contentType = headers['content-type'].toString();
        String jsonArray = response.body;
        if (statusCode == 200){
            print('Succeeded');
            return(parseTodos(jsonArray)); 
        }
        else {
          throw Exception('Failed to load data'); 
        }        
    }

    Future<void> makePostRequest() async{
        var url = 'https://jsonplaceholder.typicode.com/todos'; 
        Map <String, String> headers = {'content-type': 'application/json'}; 
        String json = '{"userId": 10, "id": 201, "title": "dunno what to write", "completed": true}'; 
        Response response = await post(Uri.parse(url), headers: headers, body: json);
        int statusCode = response.statusCode; 
        String body = response.body; 
        print('status code: $statusCode\nresponse:$body');
    }

    Future<void> makePutRequest() async{
        ///url contains index of object you want to replace 
        var url = 'https://jsonplaceholder.typicode.com/todos/1'; 
        Map <String, String> headers = {'content-type': 'application/json'}; 
        String json = '{"userId": 10, "id": 200, "title": "dunno what to write", "completed": true}'; 
        Response response = await put(Uri.parse(url), headers: headers, body: json);
        int statusCode = response.statusCode; 
        String body = response.body; 
        print('status code: $statusCode\nresponse:$body');
    }

    Future<void> makePatchRequest() async{
        var url = 'https://jsonplaceholder.typicode.com/todos/1'; 
        Map <String, String> headers = {'content-type': 'application/json'}; 
        String json = '{"userId": 10}'; 
        Response response = await patch(Uri.parse(url), headers: headers, body: json);
        int statusCode = response.statusCode; 
        String body = response.body; 
        print('status code: $statusCode\nresponse:$body');
    }

    Future<void> makeDeleteRequest() async{
        var url = 'https://jsonplaceholder.typicode.com/todos/1'; 
        Response response = await delete(Uri.parse(url)); 
        int statusCode = response.statusCode; 
        print(statusCode); 
    }
}
void main(List<String> args) async{
    HTTPMethods httpObj = HTTPMethods();
    try{
        ///GET request
        var dataTodos = await httpObj.makeGetRequest(); 
        print(dataTodos); 

        ///POST request 
        await httpObj.makePostRequest(); 

        ///PUT request
        await httpObj.makePutRequest(); 
        
        ///PATCH request
        await httpObj.makePatchRequest(); 

        ///DELETE request
        await httpObj.makeDeleteRequest(); 
    }
    catch (err){
        print(err); 
    }
      
}