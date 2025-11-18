import 'package:flutter/material.dart';

void main() {
  runApp(const JS5());
}

class JS5 extends StatelessWidget {
  const JS5({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Welcome Back,', style: TextStyle(fontSize: 12, color: Colors.white)),
              Text('Flutter Demo Home Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              FlutterLogo(
                size: 24,
              ),
            ],
          ),
          backgroundColor: Colors.blueAccent,
          // leading: const Icon(Icons.menu),
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 16),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.amber,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hello World', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              const Text('Welcome to Flutter', style: TextStyle(fontSize: 16, color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.thumb_up, color: Colors.white),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Add your button logic here
                    },
                    child: const Text('Like'),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add your icon button logic here
                    },
                    icon: const Icon(Icons.favorite, color: Colors.white),
                  )
                ],
              ),
            ],
          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
        ),
      )
    );
  }
}
