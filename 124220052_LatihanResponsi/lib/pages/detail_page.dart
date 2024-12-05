import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final String menu;
  final int id;

  DetailPage({required this.menu, required this.id});

  Future<Map<String, dynamic>> fetchDetail() async {
    final response = await http
        .get(Uri.parse('https://api.spaceflightnewsapi.net/v4/$menu/$id/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load detail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return Column(
              children: [
                Text(data['title'],
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(data['url']);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url,
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw 'Could not launch ${data['url']}';
                    }
                  },
                  child: Text('Open in Browser'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
