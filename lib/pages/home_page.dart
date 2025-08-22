import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caregiver Network'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Connect Skills',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Caregiver List
          Expanded(
            child: ListView(
              children: [
                CaregiverCard(
                  name: 'Yonum Epemil',
                  skills: ['Tout enfer nurse', 'Skil at archéal', 'suc en arge'],
                  rating: 4.5,
                  imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOqaFcW2Rnce5bcZSlq9OThlxT59uoec68taTjE-hQO6WNjTPfn3P4ehXG&s=10', // Placeholder image
                ),
                CaregiverCard(
                  name: 'Theod Witts',
                  skills: ['Endnuet and ager', 'be much archéal', 'indat do ange'],
                  rating: 4.0,
                  imageUrl: 'https://media.istockphoto.com/id/1329569957/photo/happy-young-female-doctor-looking-at-camera.jpg?s=612x612&w=0&k=20&c=7Wq_Y2cl0T4op6Wg_3DFc-xtZfCqTTDvfaXkPGyrHDM=',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CaregiverCard extends StatelessWidget {
  final String name;
  final List<String> skills;
  final double rating;
  final String imageUrl;

  CaregiverCard({
    required this.name,
    required this.skills,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: skills.map((skill) => Text(skill)).toList(),
        ),
        trailing: Text('$rating/5.0'),
      ),
    );
  }
}