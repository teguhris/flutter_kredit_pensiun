import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kredit_pensiun/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  final Map product;

  EditProduct({@required this.product});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  Future updateProduct() async{
    final response = await http.put(Uri.parse("http://teguhcodein.com/laravel-cruds/api/product/"+product["id"].toString()),body:{
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
        title:Text("Edit Product")
      ),
      body:Form(
        key:_formKey,
        child:Padding(
          padding: const EdgeInsets.fromLTRB(30.0,30.0,40,40),
          child: Column(
            
            children: [
              TextFormField(
                controller : _nameController..text = product["name"],
                decoration:InputDecoration(labelText: "Name") ,
                validator:(value){
                  if(value == null || value.isEmpty){
                    return "Please Enter product name";
                  }
                  return null;
                }
                ), 
              TextFormField(
                controller: _descriptionController..text =product["description"],
                decoration:InputDecoration(labelText: "Description") ,
                 validator:(value){
                  if(value == null || value.isEmpty){
                    return "Please Enter product Description";
                  }
                  return null;
                }
                ),
              TextFormField(
                controller: _priceController..text = product["price"],
                decoration:InputDecoration(labelText: "Price") ,
                validator:(value){
                  if(value == null || value.isEmpty){
                    return "Please Enter product price";
                  }
                  return null;
                }
                ),
              TextFormField(
                controller: _imageUrlController..text = product["image_url"],
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
                        updateProduct().then((value) {
                          Navigator.push(
                          context,
                         MaterialPageRoute(builder: (context)=>HomePage()));
                         ScaffoldMessenger.of(context)
                         .showSnackBar(SnackBar(content: Text("Produk Berhasil di ubah")));
                        });
                      }
                    }, 
                  child: Text("Update")),
                )
            ],
          ),
        ) ,)
    );
  }
}