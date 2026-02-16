import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget quoteCard(BuildContext context, Map<String, String> currentQuote) {
  final quote = currentQuote['quote'] ?? '';
  final author = currentQuote['author'] ?? '';

  return LayoutBuilder(
    builder: (context, c) {
      // Responsive sizing based on available width
      final w = c.maxWidth.clamp(320.0, 900.0);
      final quoteSize = (w * 0.055).clamp(20.0, 34.0);   // main text
      final authorSize = (w * 0.028).clamp(12.0, 18.0);  // author
      final markSize = (w * 0.22).clamp(72.0, 150.0);    // big quote symbol
      final lineHeight = (w * 0.07).clamp(28.0, 44.0);

      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: [
              // Big decorative quote mark
              Positioned(
                top: -18,
                left: -10,
                child: IgnorePointer(
                  child: Text(
                    '“',
                    style: GoogleFonts.inter(
                      fontSize: markSize,
                      fontWeight: FontWeight.w800,
                      color: Colors.black.withOpacity(0.06),
                      height: 0.9,
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 22, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '“$quote”',
                      style: GoogleFonts.inter(
                        fontSize: quoteSize,
                        fontWeight: FontWeight.w600,
                        height: lineHeight / quoteSize, // consistent rhythm
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '— $author',
                        style: GoogleFonts.inter(
                          fontSize: authorSize,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Colors.black.withOpacity(0.70),
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}