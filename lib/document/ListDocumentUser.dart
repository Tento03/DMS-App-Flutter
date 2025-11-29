import 'package:flutter/material.dart';

class ListDocumentsPage extends StatefulWidget {
  const ListDocumentsPage({super.key});

  @override
  State<ListDocumentsPage> createState() => _ListDocumentsPageState();
}

class _ListDocumentsPageState extends State<ListDocumentsPage> {
  String selectedFilter = "All";

  final List<Map<String, dynamic>> documents = [
    {
      "title": "Surat Keterangan Aktif",
      "date": "12 Nov 2025",
      "status": "Approved",
    },
    {
      "title": "Permohonan Dana Kegiatan",
      "date": "10 Nov 2025",
      "status": "Rejected",
    },
    {
      "title": "Undangan Rapat Koordinasi",
      "date": "11 Nov 2025",
      "status": "Pending",
    },
    {
      "title": "Surat Peminjaman Ruangan",
      "date": "09 Nov 2025",
      "status": "Approved",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Documents",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // -------------------- SEARCH BAR ---------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Cari dokumen...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, size: 20),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // -------------------- FILTER BUTTONS ---------------------
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterButton("All"),
                  const SizedBox(width: 8),
                  _filterButton("Approved"),
                  const SizedBox(width: 8),
                  _filterButton("Pending"),
                  const SizedBox(width: 8),
                  _filterButton("Rejected"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // -------------------- LIST DOCUMENTS ---------------------
            Expanded(
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var doc = documents[index];

                  if (selectedFilter != "All" &&
                      doc["status"] != selectedFilter) {
                    return const SizedBox();
                  }

                  return _documentCard(
                    doc["title"],
                    doc["date"],
                    doc["status"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FILTER BUTTON
  // ============================================================
  Widget _filterButton(String filter) {
    bool active = selectedFilter == filter;

    return GestureDetector(
      onTap: () => setState(() => selectedFilter = filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF667eea) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF667eea)),
        ),
        child: Text(
          filter,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF667eea),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DOCUMENT CARD - FIXED FOR MOBILE
  // ============================================================
  Widget _documentCard(String title, String date, String status) {
    Color statusColor = Colors.grey;

    if (status == "Approved") statusColor = Colors.green;
    if (status == "Rejected") statusColor = Colors.red;
    if (status == "Pending") statusColor = Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Date & Status in Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),

              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
