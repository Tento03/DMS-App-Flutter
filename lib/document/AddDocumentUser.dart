import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddDocumentPage extends StatefulWidget {
  const AddDocumentPage({super.key});

  @override
  State<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String? selectedCategory;
  File? selectedFile;

  final List<String> categories = [
    "Surat Keterangan",
    "Permohonan",
    "Laporan",
    "Dokumen Umum",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Upload Dokumen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Form Tambah Dokumen",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Lengkapi data berikut untuk mengupload dokumen.",
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 25),

              // ================== INPUT JUDUL ==================
              _inputCard(
                "Judul Dokumen",
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Contoh: Surat Permohonan Dana",
                    border: InputBorder.none,
                  ),
                  validator:
                      (value) =>
                          value!.isEmpty ? "Judul tidak boleh kosong" : null,
                ),
              ),

              const SizedBox(height: 18),

              // ================== PILIH KATEGORI ==================
              _inputCard(
                "Kategori",
                DropdownButtonFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  items:
                      categories
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  value: selectedCategory,
                  hint: const Text("Pilih kategori"),
                  onChanged: (value) {
                    setState(() => selectedCategory = value);
                  },
                  validator:
                      (value) =>
                          value == null ? "Kategori belum dipilih" : null,
                ),
              ),

              const SizedBox(height: 18),

              // ================== DESKRIPSI ==================
              _inputCard(
                "Deskripsi",
                TextFormField(
                  controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Tulis deskripsi singkat...",
                    border: InputBorder.none,
                  ),
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? "Deskripsi tidak boleh kosong"
                              : null,
                ),
              ),

              const SizedBox(height: 18),

              // ================== UPLOAD FILE ==================
              _inputCard(
                "Upload File",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: pickFile,
                      icon: const Icon(Icons.upload_file),
                      label: const Text("Pilih File"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF667eea),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (selectedFile != null) ...[
                      Text(
                        "File Terpilih:",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        selectedFile!.path.split("/").last,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================== SUBMIT BUTTON ==================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitDocument,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF667eea),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Upload Dokumen"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== PICK FILE ======================
  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "jpg", "jpeg", "png"],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  // ===================== SUBMIT ======================
  void submitDocument() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Silahkan pilih file terlebih dahulu")),
      );
      return;
    }

    // TODO: Kirim data ke backend API
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Dokumen berhasil diupload!")));
  }

  // ================== CARD WRAPPER REUSABLE ==================
  Widget _inputCard(String label, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
