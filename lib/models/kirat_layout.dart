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
    // Row 2 (Consonats)
    [
      KiratKey(primaryChar: 'ᤀ', shiftChar: null),
      KiratKey(primaryChar: 'ᤁ', shiftChar: 'ᤰ'), // ᤁ => ᤰ
      KiratKey(primaryChar: 'ᤂ', shiftChar: null),
      KiratKey(primaryChar: 'ᤃ', shiftChar: null),
      KiratKey(primaryChar: 'ᤅ', shiftChar: 'ᤱ'), // ᤅ => ᤱ
      KiratKey(primaryChar: 'ᤆ', shiftChar: null),
      KiratKey(primaryChar: 'ᤇ', shiftChar: null),
      KiratKey(primaryChar: 'ᤈ', shiftChar: null),
      KiratKey(primaryChar: 'ᤏ', shiftChar: 'ᤴ'), // ᤏ => ᤴ
    ],
    // Row 3 - More Consonants
    [
      KiratKey(primaryChar: 'ᤋ', shiftChar: 'ᤳ'), // ᤋ => ᤳ
      KiratKey(primaryChar: 'ᤌ', shiftChar: null),
      KiratKey(primaryChar: 'ᤍ', shiftChar: null),
      KiratKey(primaryChar: 'ᤎ', shiftChar: null),
      KiratKey(primaryChar: 'ᤐ', shiftChar: 'ᤵ'), // ᤐ => ᤵ
      KiratKey(primaryChar: 'ᤑ', shiftChar: null),
      KiratKey(primaryChar: 'ᤓ', shiftChar: null),
      KiratKey(primaryChar: 'ᤔ', shiftChar: 'ᤶ'), // ᤔ => ᤶ
      KiratKey(primaryChar: 'ᤕ', shiftChar: null),
    ],
    // Row 4 - Additional Consonants and Vowels
    [
      KiratKey(primaryChar: 'ᤖ', shiftChar: null),
      KiratKey(primaryChar: 'ᤗ', shiftChar: 'ᤸ'), // ᤗ => ᤸ
      KiratKey(primaryChar: 'ᤘ', shiftChar: null),
      KiratKey(primaryChar: 'ᤙ', shiftChar: null),
      KiratKey(primaryChar: 'ᤛ', shiftChar: null),
      KiratKey(primaryChar: 'ᤜ', shiftChar: null),
      KiratKey(primaryChar: 'ᤄ', shiftChar: null),
      KiratKey(primaryChar: 'ᤪ', shiftChar: null), // Special diacritic ^
      KiratKey(primaryChar: 'ᤠ', shiftChar: null), // Vowel
      KiratKey(primaryChar: 'ᤡ', shiftChar: null), // Vowel
      KiratKey(primaryChar: 'ᤢ', shiftChar: null), // Vowel
    ],
    // Row 5 - Vowels and Controls
    [
      KiratKey(primaryChar: '⇧', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: 'ᤣ', shiftChar: null), // Vowel
      KiratKey(primaryChar: 'ᤤ', shiftChar: null), // Vowel
      KiratKey(primaryChar: 'ᤥ', shiftChar: null), // Vowel
      KiratKey(primaryChar: 'ᤦ', shiftChar: null), // Vowel
      KiratKey(primaryChar: 'ᤧ', shiftChar: null), // Vowel
      KiratKey(primaryChar: 'ᤨ', shiftChar: null), // Vowel
      KiratKey(primaryChar: '⌫', isSpecial: true, width: 1.5),
    ],
    // Row 6 - Space and Controls
    [
      KiratKey(primaryChar: '!#᥇', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '🌐', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: ','),
      KiratKey(primaryChar: ' ', width: 3.0),
      KiratKey(primaryChar: '॥'),
      KiratKey(primaryChar: '.'),
      KiratKey(primaryChar: '⏎', isSpecial: true, width: 1.5),
    ],
  ];

  // Kirat Symbols Layout
  static const List<List<KiratKey>> kiratSymbolsLayout = [
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
      KiratKey(primaryChar: '€'),
      KiratKey(primaryChar: '£'),
      KiratKey(primaryChar: '¥'),
      KiratKey(primaryChar: '\$'),
      KiratKey(primaryChar: '☆'),
      KiratKey(primaryChar: '¿'),
      KiratKey(primaryChar: '♤'),
      KiratKey(primaryChar: '♡'),
      KiratKey(primaryChar: '◇'),
      KiratKey(primaryChar: '♧'),
      KiratKey(primaryChar: '{'),
      KiratKey(primaryChar: '}'),
    ],
    // Row 3 - More symbols
    [
      KiratKey(primaryChar: '+'),
      KiratKey(primaryChar: '×'),
      KiratKey(primaryChar: '÷'),
      KiratKey(primaryChar: '='),
      KiratKey(primaryChar: '/'),
      KiratKey(primaryChar: '_'),
      KiratKey(primaryChar: '<'),
      KiratKey(primaryChar: '>'),
      KiratKey(primaryChar: '['),
      KiratKey(primaryChar: ']'),
    ],
    // Row 4 - Additional symbols
    [
      KiratKey(primaryChar: '!'),
      KiratKey(primaryChar: '@'),
      KiratKey(primaryChar: '#'),
      KiratKey(primaryChar: '₹'),
      KiratKey(primaryChar: "%"),
      KiratKey(primaryChar: '^'),
      KiratKey(primaryChar: '&'),
      KiratKey(primaryChar: '*'),
      KiratKey(primaryChar: '('),
      KiratKey(primaryChar: ')'),
    ],
    // Row 5 - Controls
    [
      KiratKey(primaryChar: "'"),
      KiratKey(primaryChar: '"'),
      KiratKey(primaryChar: ':'),
      KiratKey(primaryChar: ';'),
      KiratKey(primaryChar: ','),
      KiratKey(primaryChar: '?'),
      KiratKey(primaryChar: '⌫', isSpecial: true, width: 1.5),
    ],
    // Row 6 - Space and enter
    [
      KiratKey(primaryChar: 'ᤁᤂᤃ', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '🌐', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: ',', width: 1.0),
      KiratKey(primaryChar: ' ', width: 3.0),
      KiratKey(primaryChar: '॥', width: 1.0),
      KiratKey(primaryChar: '.', width: 1.0),
      KiratKey(primaryChar: '⏎', isSpecial: true, width: 1.5),
    ],
  ];

  /* *********************English************************************************  */
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
      KiratKey(primaryChar: 'q', shiftChar: 'Q'),
      KiratKey(primaryChar: 'w', shiftChar: 'W'),
      KiratKey(primaryChar: 'e', shiftChar: 'E'),
      KiratKey(primaryChar: 'r', shiftChar: 'R'),
      KiratKey(primaryChar: 't', shiftChar: 'T'),
      KiratKey(primaryChar: 'y', shiftChar: 'Y'),
      KiratKey(primaryChar: 'u', shiftChar: 'U'),
      KiratKey(primaryChar: 'i', shiftChar: 'I'),
      KiratKey(primaryChar: 'o', shiftChar: 'O'),
      KiratKey(primaryChar: 'p', shiftChar: 'P'),
    ],
    // Row 3 - Second row letters
    [
      KiratKey(primaryChar: 'a', shiftChar: 'A'),
      KiratKey(primaryChar: 's', shiftChar: 'S'),
      KiratKey(primaryChar: 'd', shiftChar: 'D'),
      KiratKey(primaryChar: 'f', shiftChar: 'F'),
      KiratKey(primaryChar: 'g', shiftChar: 'G'),
      KiratKey(primaryChar: 'h', shiftChar: 'H'),
      KiratKey(primaryChar: 'j', shiftChar: 'J'),
      KiratKey(primaryChar: 'k', shiftChar: 'K'),
      KiratKey(primaryChar: 'l', shiftChar: 'L'),
    ],
    // Row 4 - Third row letters
    [
      KiratKey(primaryChar: '⇧', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: 'z', shiftChar: 'Z'),
      KiratKey(primaryChar: 'x', shiftChar: 'X'),
      KiratKey(primaryChar: 'c', shiftChar: 'C'),
      KiratKey(primaryChar: 'v', shiftChar: 'V'),
      KiratKey(primaryChar: 'b', shiftChar: 'B'),
      KiratKey(primaryChar: 'n', shiftChar: 'N'),
      KiratKey(primaryChar: 'm', shiftChar: 'M'),
      KiratKey(primaryChar: '⌫', isSpecial: true, width: 1.5),
    ],
    // Row 5 - Space and enter
    [
      KiratKey(primaryChar: '!#1', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '🌐', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: ',', width: 1.0),
      KiratKey(primaryChar: ' ', width: 3.0),
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
      KiratKey(primaryChar: '€'),
      KiratKey(primaryChar: '£'),
      KiratKey(primaryChar: '¥'),
      KiratKey(primaryChar: '\$'),
      KiratKey(primaryChar: '☆'),
      KiratKey(primaryChar: '¿'),
      KiratKey(primaryChar: '♤'),
      KiratKey(primaryChar: '♡'),
      KiratKey(primaryChar: '◇'),
      KiratKey(primaryChar: '♧'),
      KiratKey(primaryChar: '{'),
      KiratKey(primaryChar: '}'),
    ],
    // Row 3 - More symbols
    [
      KiratKey(primaryChar: '+'),
      KiratKey(primaryChar: '×'),
      KiratKey(primaryChar: '÷'),
      KiratKey(primaryChar: '='),
      KiratKey(primaryChar: '/'),
      KiratKey(primaryChar: '_'),
      KiratKey(primaryChar: '<'),
      KiratKey(primaryChar: '>'),
      KiratKey(primaryChar: '['),
      KiratKey(primaryChar: ']'),
    ],
    // Row 4 - Additional symbols
    [
      KiratKey(primaryChar: '!'),
      KiratKey(primaryChar: '@'),
      KiratKey(primaryChar: '#'),
      KiratKey(primaryChar: '₹'),
      KiratKey(primaryChar: "%"),
      KiratKey(primaryChar: '^'),
      KiratKey(primaryChar: '&'),
      KiratKey(primaryChar: '*'),
      KiratKey(primaryChar: '('),
      KiratKey(primaryChar: ')'),
    ],
    // Row 5 - Controls
    [
      KiratKey(primaryChar: "'"),
      KiratKey(primaryChar: '"'),
      KiratKey(primaryChar: ':'),
      KiratKey(primaryChar: ';'),
      KiratKey(primaryChar: ','),
      KiratKey(primaryChar: '?'),
      KiratKey(primaryChar: '⌫', isSpecial: true, width: 1.5),
    ],
    // Row 6 - Space and enter
    [
      KiratKey(primaryChar: 'ABC', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: '🌐', isSpecial: true, width: 1.5),
      KiratKey(primaryChar: ',', width: 1.0),
      KiratKey(primaryChar: ' ', width: 3.0),
      KiratKey(primaryChar: '.', width: 1.0),
      KiratKey(primaryChar: '⏎', isSpecial: true, width: 1.5),
    ],
  ];
}
