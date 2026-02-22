import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schreib/widgets/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Color colorFromHex(String colorCode) {
    final hexCode = colorCode.replaceAll('#', '');
    Color newColor = Color(int.parse('FF$hexCode', radix: 16));
    return newColor;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> quotes = [
    {
      "quote":
          "Be yourself; everyone else is already taken. The silent lantern folds into a quiet horizon of scattered echoes while crystal staircases drift sideways through humming air and a paper compass turns slowly beneath violet clouds that whisper in reverse directions across mirrored skies.",
      "author": "Oscar Wilde"
    },
    {
      "quote":
          "In the middle of difficulty lies opportunity. Golden threads weave through invisible corridors of time as soft winds trace circles around floating shadows and a distant bell hums in silver fragments of dusk that shimmer beneath transparent constellations.",
      "author": "Albert Einstein"
    },
    {
      "quote":
          "Do what you can, with what you have, where you are. A staircase of glass leans into forgotten skylines while quiet footsteps echo across folded sunlight and the horizon exhales slowly in scattered reflections of drifting amber light.",
      "author": "Theodore Roosevelt"
    },
    {
      "quote":
          "Success is not final, failure is not fatal. Amber clouds dissolve into mirrored rain while the wind rearranges silent architecture of thought and midnight corridors shimmer beneath soft electric light that bends around invisible corners.",
      "author": "Winston Churchill"
    },
    {
      "quote":
          "The best way to predict the future is to create it. Invisible ink paints tomorrow in drifting spirals while a silver door hums behind quiet mountains and lanterns blink softly inside transparent echoes of distant twilight.",
      "author": "Peter Drucker"
    },
    {
      "quote":
          "Dream big and dare to fail. The sky folds inward like quiet paper wings while hidden engines murmur beneath floating bridges and time drips softly through glowing corridors shaped like silent reflections.",
      "author": "Norman Vaughan"
    },
    {
      "quote":
          "Turn your wounds into wisdom. Shattered light gathers into golden threads of reflection while a whispering wind rearranges silent constellations and glass rivers hum beneath a slow turning moon.",
      "author": "Oprah Winfrey"
    },
    {
      "quote":
          "What we think, we become. Thoughts ripple outward like quiet reflections in water while the ceiling of time tilts gently toward dawn and soft echoes trace invisible geometry across the air.",
      "author": "Buddha"
    },
    {
      "quote":
          "Happiness depends upon ourselves. Lanterns glow behind mirrored staircases while a silent clock breathes in violet tones and paper mountains shift beneath drifting sunlight that hums faintly.",
      "author": "Aristotle"
    },
    {
      "quote":
          "If you tell the truth, you don’t have to remember anything. The air bends gently around floating ink while quiet corridors shimmer in soft reflection and time rests briefly in golden silence beneath unseen skies.",
      "author": "Mark Twain"
    },
    {
      "quote":
          "The only thing we have to fear is fear itself. Silver bridges stretch across weightless skies while shadows bloom into translucent echoes and a distant whisper folds into light like glass dissolving into dawn.",
      "author": "Franklin D. Roosevelt"
    },
    {
      "quote":
          "That which does not kill us makes us stronger. Stone towers hum beneath drifting starlight while invisible strings vibrate across the horizon and quiet embers glow in widening circles of amber air.",
      "author": "Friedrich Nietzsche"
    },
    {
      "quote":
          "Life is what happens when you’re busy making other plans. Clouds rearrange themselves in rhythmic silence while paper clocks drift across violet skies and golden reflections echo quietly across distant corridors.",
      "author": "John Lennon"
    },
    {
      "quote":
          "The purpose of our lives is to be happy. Crystal beams shimmer beneath folded sunlight while quiet rivers hum with silver echoes and the horizon breathes slowly in luminous patterns of light.",
      "author": "Dalai Lama"
    },
    {
      "quote":
          "Get busy living or get busy dying. Invisible stairs rise into glowing dusk while soft winds trace circles of reflection and amber light drips through silent corridors carved from mirrored air.",
      "author": "Stephen King"
    },
    {
      "quote":
          "You miss 100% of the shots you don’t take. Glass ceilings bend into drifting constellations while echoes flicker like distant fireflies and time exhales gently in widening spirals of quiet light.",
      "author": "Wayne Gretzky"
    },
    {
      "quote":
          "Whether you think you can or you think you can’t, you’re right. Silent doors open into mirrored horizons while the wind rearranges hidden geometry and soft lanterns glow faintly in violet air.",
      "author": "Henry Ford"
    },
    {
      "quote":
          "I think, therefore I am. Reflections shimmer inside quiet chambers of light while the air folds gently around drifting shapes and time hums steadily in silver tones beneath unseen skies.",
      "author": "René Descartes"
    },
    {
      "quote":
          "Stay hungry, stay foolish. Paper lanterns float above mirrored skies while invisible currents whisper in gold fragments and midnight breathes quietly into endless reflections.",
      "author": "Steve Jobs"
    },
    {
      "quote":
          "The journey of a thousand miles begins with one step. Amber stairways shimmer in drifting twilight while echoes stretch across quiet mountains and light folds gently into shadowed air.",
      "author": "Lao Tzu"
    },
    {
      "quote":
          "Act as if what you do makes a difference. It does. The wind sketches circles in silent dust while crystal towers glow beneath violet dawn and a distant hum vibrates faintly beneath floating horizons.",
      "author": "William James"
    },
    {
      "quote":
          "Believe you can and you’re halfway there. Invisible bridges rise over golden silence while reflections bend gently toward morning and the horizon whispers softly in glowing echoes.",
      "author": "Theodore Roosevelt"
    },
    {
      "quote":
          "Everything you can imagine is real. Silver corridors twist into drifting constellations while a quiet lantern hums beneath folded skies and paper shadows glow faintly across endless reflections.",
      "author": "Pablo Picasso"
    },
    {
      "quote":
          "Simplicity is the ultimate sophistication. Crystal lines trace quiet geometry of thought while the wind rearranges amber silence and a distant glow lingers across mirrored horizons.",
      "author": "Leonardo da Vinci"
    },
    {
      "quote":
          "Whatever you are, be a good one. Lanterns drift across mirrored dusk while the air bends gently around silent staircases and echoes ripple outward through transparent skies.",
      "author": "Abraham Lincoln"
    },
    {
      "quote":
          "If opportunity doesn’t knock, build a door. Invisible hinges hum beneath violet light while paper frames shimmer softly and a distant wind circles through mirrored corridors of amber glow.",
      "author": "Milton Berle"
    },
    {
      "quote":
          "Try to be a rainbow in someone’s cloud. Amber light refracts into drifting echoes while silver droplets hum quietly and the sky breathes gently beneath folded reflections.",
      "author": "Maya Angelou"
    },
    {
      "quote":
          "What you do speaks so loudly that I cannot hear what you say. Crystal corridors shimmer in silent reflection while the horizon tilts softly and a distant glow vibrates beneath transparent air.",
      "author": "Ralph Waldo Emerson"
    },
    {
      "quote":
          "Do one thing every day that scares you. Invisible stairs rise through golden dusk while lanterns blink in rhythmic silence and time folds gently inward like drifting paper light.",
      "author": "Eleanor Roosevelt"
    },
    {
      "quote":
          "It always seems impossible until it’s done. Silver towers drift across mirrored skies while echoes ripple in violet tones and light bends softly beneath floating constellations.",
      "author": "Nelson Mandela"
    },
  ];

  final Random _random = Random();

  late Map<String, String> currentQuote;

  // Direction: true = new enters from right (old exits left)
  bool slideFromRight = true;

  Map<String, String> findRandomQuote() {
    return quotes[_random.nextInt(quotes.length)];
  }

  void _nextQuote() {
    setState(() {
      slideFromRight = true;

      // Optional: avoid repeating the same quote twice in a row
      Map<String, String> next = findRandomQuote();
      if (quotes.length > 1) {
        while (next == currentQuote) {
          next = findRandomQuote();
        }
      }
      currentQuote = next;
    });
  }

  @override
  void initState() {
    super.initState();
    currentQuote = findRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    final currentKey = ValueKey(
      '${currentQuote['quote']}_${currentQuote['author']}',
    );

    return GestureDetector(
      onTap: _nextQuote,
      child: Scaffold(
        backgroundColor: HomeScreen.colorFromHex('#F2F8FC'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),

                  GestureDetector(
                    onTap: (){},
                    child: SizedBox(
                      child: Padding( 
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _NavItem(label: 'Home', onTap: () {}),
                              const SizedBox(width: 28),
                              _NavItem(label: 'Join', onTap: () {}),
                              const SizedBox(width: 28),
                              _NavItem(label: 'About', onTap: () {}),
                              const SizedBox(width: 28),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    final isIncoming = child.key == currentKey;
              
                    final inTween = Tween<Offset>(
                      begin: slideFromRight
                          ? const Offset(1.0, 0.0) 
                          : const Offset(-1.0, 0.0), 
                      end: Offset.zero,
                    );
              
                    final outTween = Tween<Offset>(
                      begin: Offset.zero,
                      end: slideFromRight
                          ? const Offset(-1.0, 0.0) 
                          : const Offset(1.0, 0.0), 
                    );
              
                    return ClipRect(
                      child: SlideTransition(
                        position:
                            (isIncoming ? inTween : outTween).animate(animation),
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: KeyedSubtree(
                    key: currentKey,
                    child: quoteCard(context, currentQuote),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: _hovered ? FontWeight.w800 : FontWeight.w600,
            color: _hovered
                ? Colors.black.withOpacity(0.85)
                : Colors.black.withOpacity(0.45),   
            letterSpacing: 0.1,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
