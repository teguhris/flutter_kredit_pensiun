import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kredit_pensiun/screens/homepage.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  Future saveProduct() async{
    final response = await http.post(Uri.parse("http://teguhcodein.com/laravel-cruds/api/products"),body:{
      "name":  _nameController.text,
      "description":  _descriptionController.text,
      "price":  _priceController.text,
      "image_url":  _imageUrlController.text,
    });

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Add Product")
      ),
      body:Form(
        key:_formKey,
        child:Padding(
          padding: const EdgeInsets.fromLTRB(30.0,30.0,40,40),
          child: Column(
            
            children: [
              TextFormField(
                controller : _nameController,
                decoration:InputDecoration(labelText: "Name") ,
                validator:(value){
                  if(value == null || value.isEmpty){
                    return "Please Enter product name";
                  }
                  return null;
                }
                ), 
              TextFormField(
                controller: _descriptionController,
                decoration:InputDecoration(labelText: "Description") ,
                 validator:(value){
                  if(value == null || value.isEmpty){
                    return "Please Enter product Description";
                  }
                  return null;
                }
                ),
              TextFormField(
                controller: _priceController,
                decoration:InputDecoration(labelText: "Price") ,
                validator:(value){
                  if(value == null || value.isEmpty){
                    return "Please Enter product price";
                  }
                  return null;
                }
                ),
              TextFormField(
                controller: _imageUrlController,
                decoration:InputDecoration(labelText: "Image URL") ,
                 validator:(value){
                  if(value == null || value.isEmpty){
                    return "Please Enter image url";
                  }
                  return null;
                }
                ),
                SizedBox(
                  height:20
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        saveProduct().then((value) {
                          Navigator.push(
                          context,
                         MaterialPageRoute(builder: (context)=>HomePage()));
                          ScaffoldMessenger.of(context)
                         .showSnackBar(SnackBar(content: Text("Produk Berhasil di buat")));
              
                        });
                        
                      }
                    }, 
                  child: Text("Save")),
                )
            ],
          ),
        ) ,)
    );
  }
}