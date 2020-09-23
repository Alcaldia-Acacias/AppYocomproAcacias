import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
           id: 'search',
           builder: (state){
           return Scaffold(
                   appBar: AppBar(
                           title: TextField(
                                  style      : TextStyle(fontSize: 18),
                                  autofocus  : true,
                                  decoration : InputDecoration(
                                               hintText: "Buscar",
                                               hintStyle: TextStyle(fontSize: 15),
                                               border: InputBorder.none
                                               ),
                                  onChanged  : (value) {
                                   
                                  } 
                           ),
                           elevation: 0,
                    )
           );
           }
           );
  }
}