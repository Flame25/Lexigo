import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;
  final String navigateTo;
  final double progress; // Progress dalam nilai 0.0 hingga 1.0
  final Function() func;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
    required this.navigateTo,
    required this.progress,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, navigateTo).then((result) {
          if (result == true) {
            func();
          }
        });
      },
      child: Container(
        width: 343,
        height: 260, // Tambahkan tinggi yang cukup
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(-1, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(1, -1),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gambar di sisi kiri atas
            Positioned(
              left: 10,
              top: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  imagePath,
                  width: 109,
                  height: 135,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Informasi teks di tengah kanan
            Positioned(
              left: 135,
              right: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(
                    8), // Tambahkan padding jika diperlukan
                decoration: BoxDecoration(
                  color: Colors
                      .transparent, // Background transparan untuk melihat warna kartu
                  borderRadius:
                      BorderRadius.circular(13), // Samakan radius dengan kartu
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28, // Kurangi ukuran font jika perlu
                        fontWeight: FontWeight.w400,
                        height:
                            1.2, // Atur line-height agar tidak terlalu besar
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14, // Sesuaikan ukuran font untuk deskripsi
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.4, // Atur line-height agar lebih proporsional
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Progress bar container
            Positioned(
              left: 8,
              top: 165,
              child: Container(
                width: 328,
                height: 80, // Tinggi container disesuaikan
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your progress',
                      style: TextStyle(
                        color: Color(0xFF8D8D8D),
                        fontSize: 8,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.50,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${(progress * 100).toInt()}%',
                              style: const TextStyle(
                                color: Color(0xFF003566),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'to complete',
                              style: TextStyle(
                                color: Color(0xFF003566),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Progress bar
                    Container(
                      width: double.infinity,
                      height: 12, // Tinggi progress bar
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0), // Warna dasar abu-abu
                        borderRadius: BorderRadius.circular(
                            64), // Border melengkung penuh
                      ),
                      child: Stack(
                        children: [
                          // Bagian progress
                          FractionallySizedBox(
                            widthFactor: progress, // Proporsi progress
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFF003566), // Warna biru untuk progress
                                borderRadius: BorderRadius.circular(
                                    64), // Border melengkung penuh
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol Start
            Positioned(
              left: 206.50,
              top: 170,
              child: Container(
                width: 113, // Lebar tombol ditingkatkan
                height: 45,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Color(0xFFE5E5E5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Pisahkan teks dan ikon
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Teks START
                    Text(
                      'START',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF58CC02),
                        fontSize: 16, // Sesuaikan ukuran teks
                        fontFamily: 'Baloo',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF58CC02),
                      size: 25, // Sesuaikan ukuran ikon
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
