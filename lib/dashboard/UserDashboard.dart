import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  String _selectedMenu = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ======================= APP BAR ============================
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        // === GRADIENT APP BAR ===
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        actions: [
          // ========== SEARCH BAR ==============
          Container(
            width: 250,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Cari surat...",
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, size: 20, color: Colors.white),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF667eea)),
            ),
          ),
        ],
      ),

      // ======================= DRAWER ==============================
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF667eea)),
                ),
                title: Text(
                  "User Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "user@gmail.com",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const Divider(color: Colors.white24),

              _menuItem(Icons.dashboard_outlined, "Dashboard"),
              _menuItem(Icons.cloud_upload_outlined, "Upload Document"),
              _menuItem(Icons.folder_open, "List Documents"),
              _menuItem(Icons.verified_outlined, "Document Status"),
              _menuItem(Icons.search, "Search Document"),
              _menuItem(Icons.person_outline, "Profile"),
              _menuItem(Icons.settings, "Settings"),

              const Spacer(),
              const Divider(color: Colors.white24),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // ======================= BODY ==============================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selamat Datang 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Ringkasan aktivitas dokumen Anda",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            // ================= STAT CARDS ==================
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Disetujui",
                    "10",
                    Icons.check_circle,
                    const Color(0xFF22C55E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    "Ditolak",
                    "5",
                    Icons.cancel,
                    const Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    "Ditunda",
                    "2",
                    Icons.hourglass_empty,
                    const Color(0xFFF59E0B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ================= QUICK MENU ==================
            const Text(
              "Akses Cepat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _quickMenu(Icons.upload_file, "Upload"),
                _quickMenu(Icons.folder, "Dokumen"),
                _quickMenu(Icons.verified, "Status"),
                _quickMenu(Icons.search, "Cari"),
              ],
            ),

            const SizedBox(height: 30),

            // ================= RECENT DOCS =================
            const Text(
              "Dokumen Terbaru",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _recentDocument(
              "Surat Keterangan Aktif",
              "Disetujui",
              Colors.green,
            ),
            _recentDocument("Surat Permohonan Dana", "Ditolak", Colors.red),
            _recentDocument("Surat Undangan Acara", "Menunggu", Colors.orange),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WIDGET: MENU ITEM DRAWER
  // ============================================================
  Widget _menuItem(IconData icon, String title) {
    bool selected = _selectedMenu == title;
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      selectedTileColor: Colors.white24,
      onTap: () {
        setState(() => _selectedMenu = title);
        Navigator.pop(context);
      },
    );
  }

  // ============================================================
  // WIDGET: CARD STATISTIK
  // ============================================================
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  // ============================================================
  // WIDGET: QUICK MENU
  // ============================================================
  Widget _quickMenu(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 30, color: const Color(0xFF667eea)),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }

  // ============================================================
  // WIDGET: RECENT DOCUMENT ITEM
  // ============================================================
  Widget _recentDocument(String title, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD DECORATION REUSABLE
  // ============================================================
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
