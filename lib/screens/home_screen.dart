import 'package:flutter/material.dart';
import '../services/record_service.dart';
import '../models/academic_record.dart';
import 'add_edit_screen.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final service = RecordService();
  final auth = AuthService();

  late Future<List<AcademicRecord>> records;

  @override
  void initState() {
    records = service.fetchRecords();
    super.initState();
  }

  void refresh() {
    setState(() {
      records = service.fetchRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Diary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditScreen()),
          );
          if (result == true) refresh();
        },
      ),
      body: FutureBuilder<List<AcademicRecord>>(
        future: records,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          if (data.isEmpty) {
            return const Center(child: Text('No records yet'));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              final record = data[index];

              return ListTile(
                title: Text(record.title),
                subtitle: Text(record.type),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddEditScreen(record: record),
                          ),
                        );
                        if (result == true) refresh();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await service.deleteRecord(record.id);
                        refresh();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
