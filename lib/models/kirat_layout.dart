class KiratKey {
  final String primaryChar;
  final String? shiftChar;
  final double width;
  final bool isSpecial;

  const KiratKey({
    required this.primaryChar,
    this.shiftChar,
    this.width = 1.0,
    this.isSpecial = false,
  });
}

class KiratKeyboardLayout {
  // Kirat Layout with numbers row
  static const List<List<KiratKey>> kiratLayout = [
    // Row 1 - Numbers
    [
      KiratKey(primaryChar: '᥇'), // 1
      KiratKey(primaryChar: '᥈'), // 2
      KiratKey(primaryChar: '᥉'), // 3
      KiratKey(primaryChar: '᥊'), // 4
      KiratKey(primaryChar: '᥋'), // 5
      KiratKey(primaryChar: '᥌'), // 6
      KiratKey(primaryChar: '᥍'), // 7
      KiratKey(primaryChar: '᥎'), // 8
      KiratKey(primaryChar: '᥏'), // 9
      KiratKey(primaryChar: '᥆'), // 0
    ],
    // Row 2 - Kirat consonants
    [
      KiratKey(primaryChar: 'ᤁ'),
      KiratKey(primaryChar: 'ᤃ'),
      KiratKey(primaryChar: 'ᤅ'),
      KiratKey(primaryChar: 'ᤇ'),
      KiratKey(primaryChar: 'ᤉ'),
      KiratKey(primaryChar: 'ᤋ'),
      KiratKey(primaryChar: 'ᤍ'),
      KiratKey(primaryChar: 'ᤏ'),
      KiratKey(primaryChar: 'ᤑ'),
      KiratKey(primaryChar: 'ᤓ'),
    ],
    // Row 3 - More Kirat characters
    [
      KiratKey(primaryChar: 'ᤕ'),
      KiratKey(primaryChar: 'ᤗ'),
      KiratKey(primaryChar: 'ᤙ'),
      KiratKey(primaryChar: 'ᤛ'),
      KiratKey(primaryChar: 'ᤝ'),
      KiratKey(primaryChar: 'ᤠ'),
      KiratKey(primaryChar: 'ᤢ'),
      KiratKey(primaryChar: 'ᤣ'),
      KiratKey(primaryChar: 'ᤥ'),
      KiratKey(primaryChar: 'ᤧ'),
    ],
    // Row 4 - Additional Kirat characters
    [
      KiratKey(primaryChar: 'ᤩ'),
      KiratKey(primaryChar: 'ᤫ'),
      KiratKey(primaryChar: '᤭'),
      KiratKey(primaryChar: '᤯'),
      KiratKey(primaryChar: 'ᤰ'),
      KiratKey(primaryChar: 'ᤱ'),
      KiratKey(primaryChar: 'ᤲ'),
      KiratKey(primaryChar: 'ᤳ'),
      KiratKey(primaryChar: 'ᤴ'),
      KiratKey(primaryChar: 'ᤵ'),
    ],
    // Row 5 - Controls
    [
      KiratKey(primaryChar: '⇧', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '!#1', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: 'ᤀ'),
      KiratKey(primaryChar: 'ᤂ'),
      KiratKey(primaryChar: 'ᤄ'),
      KiratKey(primaryChar: 'ᤆ'),
      KiratKey(primaryChar: 'ᤈ'),
      KiratKey(primaryChar: '⌫', isSpecial: true, width: 1.5),
    ],
    // Row 6 - Space and enter
    [
      KiratKey(primaryChar: '🌐', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: ',', width: 1.0),
      KiratKey(primaryChar: '॥', width: 1.0), // Kirat double danda
      KiratKey(primaryChar: ' ', width: 3.0), // Longer space
      KiratKey(primaryChar: '.', width: 1.0),
      KiratKey(primaryChar: '⏎', isSpecial: true, width: 1.5),
    ],
  ];

  // Kirat Symbols Layout
  static const List<List<KiratKey>> KiratSymbolsLayout = [
    // Row 1 - Numbers
    [
      KiratKey(primaryChar: '᥇'), // 1
      KiratKey(primaryChar: '᥈'), // 2
      KiratKey(primaryChar: '᥉'), // 3
      KiratKey(primaryChar: '᥊'), // 4
      KiratKey(primaryChar: '᥋'), // 5
      KiratKey(primaryChar: '᥌'), // 6
      KiratKey(primaryChar: '᥍'), // 7
      KiratKey(primaryChar: '᥎'), // 8
      KiratKey(primaryChar: '᥏'), // 9
      KiratKey(primaryChar: '᥆'), // 0
    ],
    // Row 2 - Symbols
    [
      KiratKey(primaryChar: '!'),
      KiratKey(primaryChar: '@'),
      KiratKey(primaryChar: '#'),
      KiratKey(primaryChar: '\$'),
      KiratKey(primaryChar: '%'),
      KiratKey(primaryChar: '^'),
      KiratKey(primaryChar: '&'),
      KiratKey(primaryChar: '*'),
      KiratKey(primaryChar: '('),
      KiratKey(primaryChar: ')'),
    ],
    // Row 3 - More symbols
    [
      KiratKey(primaryChar: '-'),
      KiratKey(primaryChar: '_'),
      KiratKey(primaryChar: '='),
      KiratKey(primaryChar: '+'),
      KiratKey(primaryChar: '['),
      KiratKey(primaryChar: ']'),
      KiratKey(primaryChar: '{'),
      KiratKey(primaryChar: '}'),
      KiratKey(primaryChar: '|'),
      KiratKey(primaryChar: '\\'),
    ],
    // Row 4 - Additional symbols
    [
      KiratKey(primaryChar: ';'),
      KiratKey(primaryChar: ':'),
      KiratKey(primaryChar: '"'),
      KiratKey(primaryChar: "'"),
      KiratKey(primaryChar: '<'),
      KiratKey(primaryChar: '>'),
      KiratKey(primaryChar: '?'),
      KiratKey(primaryChar: '/'),
      KiratKey(primaryChar: '~'),
      KiratKey(primaryChar: '`'),
    ],
    // Row 5 - Controls
    [
      KiratKey(primaryChar: '⇧', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: 'ABC', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '₹'),
      KiratKey(primaryChar: '€'),
      KiratKey(primaryChar: '£'),
      KiratKey(primaryChar: '¥'),
      KiratKey(primaryChar: '°'),
      KiratKey(primaryChar: '⌫', isSpecial: true, width: 1.5),
    ],
    // Row 6 - Space and enter
    [
      KiratKey(primaryChar: '🌐', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: ',', width: 1.0),
      KiratKey(primaryChar: '॥', width: 1.0),
      KiratKey(primaryChar: ' ', width: 3.0), // Longer space
      KiratKey(primaryChar: '.', width: 1.0),
      KiratKey(primaryChar: '⏎', isSpecial: true, width: 1.5),
    ],
  ];

  // English Layout with numbers row
  static const List<List<KiratKey>> englishLayout = [
    // Row 1 - Numbers
    [
      KiratKey(primaryChar: '1'),
      KiratKey(primaryChar: '2'),
      KiratKey(primaryChar: '3'),
      KiratKey(primaryChar: '4'),
      KiratKey(primaryChar: '5'),
      KiratKey(primaryChar: '6'),
      KiratKey(primaryChar: '7'),
      KiratKey(primaryChar: '8'),
      KiratKey(primaryChar: '9'),
      KiratKey(primaryChar: '0'),
    ],
    // Row 2 - First row letters
    [
      KiratKey(primaryChar: 'q'),
      KiratKey(primaryChar: 'w'),
      KiratKey(primaryChar: 'e'),
      KiratKey(primaryChar: 'r'),
      KiratKey(primaryChar: 't'),
      KiratKey(primaryChar: 'y'),
      KiratKey(primaryChar: 'u'),
      KiratKey(primaryChar: 'i'),
      KiratKey(primaryChar: 'o'),
      KiratKey(primaryChar: 'p'),
    ],
    // Row 3 - Second row letters
    [
      KiratKey(primaryChar: 'a'),
      KiratKey(primaryChar: 's'),
      KiratKey(primaryChar: 'd'),
      KiratKey(primaryChar: 'f'),
      KiratKey(primaryChar: 'g'),
      KiratKey(primaryChar: 'h'),
      KiratKey(primaryChar: 'j'),
      KiratKey(primaryChar: 'k'),
      KiratKey(primaryChar: 'l'),
      KiratKey(primaryChar: ';'),
    ],
    // Row 4 - Third row letters
    [
      KiratKey(primaryChar: 'z'),
      KiratKey(primaryChar: 'x'),
      KiratKey(primaryChar: 'c'),
      KiratKey(primaryChar: 'v'),
      KiratKey(primaryChar: 'b'),
      KiratKey(primaryChar: 'n'),
      KiratKey(primaryChar: 'm'),
      KiratKey(primaryChar: ','),
      KiratKey(primaryChar: '.'),
      KiratKey(primaryChar: '/'),
    ],
    // Row 5 - Controls
    [
      KiratKey(primaryChar: '⇧', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '!#1', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '@'),
      KiratKey(primaryChar: '#'),
      KiratKey(primaryChar: '\$'),
      KiratKey(primaryChar: '&'),
      KiratKey(primaryChar: '*'),
      KiratKey(primaryChar: '⌫', isSpecial: true, width: 1.5),
    ],
    // Row 6 - Space and enter
    [
      KiratKey(primaryChar: '🌐', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: ',', width: 1.0),
      KiratKey(primaryChar: '!', width: 1.0),
      KiratKey(primaryChar: '?', width: 1.0),
      KiratKey(primaryChar: ' ', width: 3.0), // Longer space
      KiratKey(primaryChar: '.', width: 1.0),
      KiratKey(primaryChar: '⏎', isSpecial: true, width: 1.5),
    ],
  ];

  // English Symbols Layout
  static const List<List<KiratKey>> englishSymbolsLayout = [
    // Row 1 - Numbers
    [
      KiratKey(primaryChar: '1'),
      KiratKey(primaryChar: '2'),
      KiratKey(primaryChar: '3'),
      KiratKey(primaryChar: '4'),
      KiratKey(primaryChar: '5'),
      KiratKey(primaryChar: '6'),
      KiratKey(primaryChar: '7'),
      KiratKey(primaryChar: '8'),
      KiratKey(primaryChar: '9'),
      KiratKey(primaryChar: '0'),
    ],
    // Row 2 - Symbols
    [
      KiratKey(primaryChar: '!'),
      KiratKey(primaryChar: '@'),
      KiratKey(primaryChar: '#'),
      KiratKey(primaryChar: '\$'),
      KiratKey(primaryChar: '%'),
      KiratKey(primaryChar: '^'),
      KiratKey(primaryChar: '&'),
      KiratKey(primaryChar: '*'),
      KiratKey(primaryChar: '('),
      KiratKey(primaryChar: ')'),
    ],
    // Row 3 - More symbols
    [
      KiratKey(primaryChar: '-'),
      KiratKey(primaryChar: '_'),
      KiratKey(primaryChar: '='),
      KiratKey(primaryChar: '+'),
      KiratKey(primaryChar: '['),
      KiratKey(primaryChar: ']'),
      KiratKey(primaryChar: '{'),
      KiratKey(primaryChar: '}'),
      KiratKey(primaryChar: '|'),
      KiratKey(primaryChar: '\\'),
    ],
    // Row 4 - Additional symbols
    [
      KiratKey(primaryChar: ';'),
      KiratKey(primaryChar: ':'),
      KiratKey(primaryChar: '"'),
      KiratKey(primaryChar: "'"),
      KiratKey(primaryChar: '<'),
      KiratKey(primaryChar: '>'),
      KiratKey(primaryChar: '?'),
      KiratKey(primaryChar: '/'),
      KiratKey(primaryChar: '~'),
      KiratKey(primaryChar: '`'),
    ],
    // Row 5 - Controls
    [
      KiratKey(primaryChar: '⇧', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: 'ABC', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '₹'),
      KiratKey(primaryChar: '€'),
      KiratKey(primaryChar: '£'),
      KiratKey(primaryChar: '¥'),
      KiratKey(primaryChar: '°'),
      KiratKey(primaryChar: '⌫', isSpecial: true, width: 1.5),
    ],
    // Row 6 - Space and enter
    [
      KiratKey(primaryChar: '🌐', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: ',', width: 1.0),
      KiratKey(primaryChar: '!', width: 1.0),
      KiratKey(primaryChar: '?', width: 1.0),
      KiratKey(primaryChar: ' ', width: 3.0), // Longer space
      KiratKey(primaryChar: '.', width: 1.0),
      KiratKey(primaryChar: '⏎', isSpecial: true, width: 1.5),
    ],
  ];
}
