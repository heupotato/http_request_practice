import 'dart:convert';

import 'package:http/http.dart' as http;
Future<User> fetchUser() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1')); 
    if (response.statusCode == 200){
        return User.fromJson(jsonDecode(response.body)); 
    } else{
        throw Exception('Failed to load users'); 
    }
}
class User {
    final int userId; 
    final int id; 
    final String title; 
    final bool completed; 

    User({required this.userId, required this.id, required this.completed, required this.title}); 

    factory User.fromJson(Map<String, dynamic> json)
    {
        return User(
            userId: json['userId'], 
            id: json['id'], 
            completed: json['completed'], 
            title: json['title']
        );
    }

    @override
    String toString(){
        return ('userID: $userId\nid: $id\ntitle: $title\ncompleted: $completed'); 
    }
}


void main(List<String> arguments) async{
   var user = await fetchUser(); 
   print(user); 
}
