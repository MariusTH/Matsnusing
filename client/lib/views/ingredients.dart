import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ingredients extends StatelessWidget {
  final ingredients;
  const Ingredients(this.ingredients, {super.key});

  @override
  Widget build(BuildContext context) {
    print(ingredients);
    print(ingredients.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate back to first route when tapped.
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return Text( ingredients[index]);
              }
            ),
          ],
            
        )
      ),
    );
  }
}