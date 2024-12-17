import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function(BuildContext) onTap; // Menerima BuildContext

  const DashboardItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context), // Mengirim context saat onTap dipanggil
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Menambah sudut yang lebih halus
        ),
        elevation: 5, // Memberikan bayangan untuk efek 3D
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36, // Ukuran ikon lebih kecil
              color: const Color(0xFF00796B), // Warna ikon
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40), // Warna teks label
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
