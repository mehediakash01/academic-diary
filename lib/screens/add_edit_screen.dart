import 'package:flutter/material.dart';
import '../services/record_service.dart';
import '../models/academic_record.dart';

class AddEditScreen extends StatefulWidget {
  final AcademicRecord? record;

  const AddEditScreen({super.key, this.record});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String type = 'Assignment';

  final service = RecordService();

  @override
  void initState() {
    super.initState();
    if (widget.record != null) {
      titleController.text = widget.record!.title;
      descController.text = widget.record!.description;
      type = widget.record!.type;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title is required')),
      );
      return;
    }

    try {
      if (widget.record == null) {
        await service.addRecord(
          title: titleController.text.trim(),
          description: descController.text.trim(),
          type: type,
        );
      } else {
        await service.updateRecord(
          id: widget.record!.id,
          title: titleController.text.trim(),
          description: descController.text.trim(),
          type: type,
        );
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.record == null ? 'Add Record' : 'Edit Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: type,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'Assignment', child: Text('Assignment')),
                DropdownMenuItem(value: 'Note', child: Text('Note')),
                DropdownMenuItem(value: 'Schedule', child: Text('Schedule')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => type = value);
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}