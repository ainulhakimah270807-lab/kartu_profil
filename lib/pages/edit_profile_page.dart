import 'package:flutter/material.dart';

import '../models/profile_data.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.initial});

  final ProfileData initial;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial.name);
  late final _titleController = TextEditingController(
    text: widget.initial.title,
  );
  late final _bioController = TextEditingController(text: widget.initial.bio);

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    return value == null || value.trim().isEmpty ? 'Wajib diisi' : null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      ProfileData(
        name: _nameController.text.trim(),
        title: _titleController.text.trim(),
        bio: _bioController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
              validator: _required,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Jabatan',
                border: OutlineInputBorder(),
              ),
              validator: _required,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bioController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
              validator: _required,
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _submit, child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }
}
