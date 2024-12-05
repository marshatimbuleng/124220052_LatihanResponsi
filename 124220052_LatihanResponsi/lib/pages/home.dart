import 'package:flutter/material.dart';
import 'list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Menu')),
      body: Column(
        children: [
          ListTile(
            title: Text('News'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListPage(menu: 'articles')),
              );
            },
          ),
          ListTile(
            title: Text('Blogs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListPage(menu: 'blogs')),
              );
            },
          ),
          ListTile(
            title: Text('Reports'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListPage(menu: 'reports')),
              );
            },
          ),
        ],
      ),
    );
  }
}
