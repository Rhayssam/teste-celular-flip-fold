import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: FoldTestScreen()));
}

class FoldTestScreen extends StatelessWidget {
  const FoldTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final displayFeatures = mediaQuery.displayFeatures;

    DisplayFeature? foldFeature;

    for (final feature in displayFeatures) {
      if (feature.type == DisplayFeatureType.fold || feature.type == DisplayFeatureType.hinge) {
        foldFeature = feature;
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Teste Fold')),
      body: Builder(
        builder: (_) {
          /// Não possui dobra
          if (foldFeature == null) {
            return _buildNormalLayout(context);
          }

          /// Dobra vertical (livro)
          final isBookMode = foldFeature.bounds.height > foldFeature.bounds.width;

          if (isBookMode) {
            return _buildBookMode(context);
          }

          /// Dobra horizontal (tabletop)
          return _buildTableTopMode(context);
        },
      ),
    );
  }

  Widget _buildNormalLayout(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: const Center(
        child: Text("CELULAR NORMAL", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBookMode(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.orange,
            child: const Center(child: Text("TELA ESQUERDA", style: TextStyle(fontSize: 24))),
          ),
        ),
        Container(width: 2, color: Colors.black),
        Expanded(
          child: Container(
            color: Colors.green,
            child: const Center(child: Text("TELA DIREITA", style: TextStyle(fontSize: 24))),
          ),
        ),
      ],
    );
  }

  Widget _buildTableTopMode(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.purple,
            child: const Center(
              child: Text("PARTE SUPERIOR", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
        ),
        Container(height: 2, color: Colors.black),
        Expanded(
          child: Container(
            color: Colors.teal,
            child: const Center(
              child: Text("PARTE INFERIOR", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
        ),
      ],
    );
  }
}
