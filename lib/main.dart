import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Firebase initialization failed: \$e');
    }
  } else {
    print('Skipping Firebase initialization on web (awaiting config)');
  }
  runApp(AdminApp());
}

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AdminDashboardPage(),
    );
  }
}

class AdminDashboardPage extends StatefulWidget {
  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final List<Map<String, String>> staticStudents = [
    {'name': 'ASAP Rocky'},
    {'name': 'Kendrick Lamar'},
    {'name': 'Syd Barret'},
    {'name': 'Roberto Lopez'},
    {'name': 'Crip Mac'},
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Scaffold(
      appBar: isWide
          ? null
          : AppBar(
              title: const Text('Admin Dashboard'),
            ),
      drawer: isWide
          ? null
          : Drawer(
              child: ListView(
                children: const [
                  DrawerHeader(child: Text('Admin Dashboard')),
                  ListTile(leading: Icon(Icons.people_outline), title: Text('Students')),
                  ListTile(leading: Icon(Icons.school_outlined), title: Text('Tutors')),
                ],
              ),
            ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: 0,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.people_outline),
                  label: Text('Students'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.school_outlined),
                  label: Text('Tutors'),
                ),
              ],
            ),
          if (isWide) const VerticalDivider(width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Students', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Add New Student'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search students...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: staticStudents.length,
                      itemBuilder: (context, index) {
                        final student = staticStudents[index]['name']!;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: isWide
                                ? Row(
                                    children: [
                                      Expanded(flex: 4, child: Text(student)),
                                      IconButton(
                                        icon: const Icon(Icons.edit_outlined),
                                        onPressed: () {},
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[700],
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: const Text('View'),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(student, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit_outlined),
                                            onPressed: () {},
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey[700],
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                            child: const Text('View'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}