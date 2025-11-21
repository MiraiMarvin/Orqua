class OrquaProducts {
  // Catégories Orqua - sobres
  static const String categoryFreshSeafood = 'POISSONS FRAIS';
  static const String categoryShellfish = 'COQUILLAGES';
  static const String categoryCrustaceans = 'CRUSTACÉS';
  static const String categoryPreserves = 'CONSERVES';
  static const String categorySpecialties = 'SPÉCIALITÉS';

  // Descriptions des catégories
  static const Map<String, String> categoryDescriptions = {
    categoryFreshSeafood: 'Poissons de nos côtes, pêchés quotidiennement',
    categoryShellfish: 'Huîtres, moules et coquillages sélectionnés',
    categoryCrustaceans: 'Homards, crabes et langoustines',
    categoryPreserves: 'Conserves artisanales de qualité',
    categorySpecialties: 'Produits transformés et spécialités maison',
  };

  // Couleurs par catégorie (sobres)
  static const Map<String, int> categoryColors = {
    categoryFreshSeafood: 0xFF1A4D6D, // Bleu marine
    categoryShellfish: 0xFF8FB8A8, // Vert mousse
    categoryCrustaceans: 0xFFE8927C, // Corail
    categoryPreserves: 0xFF6B9CB8, // Bleu clair
    categorySpecialties: 0xFF2C3E50, // Gris foncé
  };

  // Abréviations pour les chips
  static const Map<String, String> categoryShortNames = {
    categoryFreshSeafood: 'POISSONS',
    categoryShellfish: 'COQUILLAGES',
    categoryCrustaceans: 'CRUSTACÉS',
    categoryPreserves: 'CONSERVES',
    categorySpecialties: 'SPÉCIALITÉS',
  };
}

