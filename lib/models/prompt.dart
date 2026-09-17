/// A writing prompt.
///
/// The seed corpus is the quote list the app started as: a quote is now the
/// thing you write *against*, not the product itself.
class Prompt {
  const Prompt({
    required this.id,
    required this.text,
    this.attributedTo,
    this.source,
    this.attributionDisputed = false,
  });

  final String id;
  final String text;

  /// Who said it, where the prompt is a quotation.
  final String? attributedTo;

  /// Where the attribution can be checked. Null means unsourced.
  final String? source;

  /// Set when the attribution is popular but unverified. Much of the quote
  /// web is apocrypha; saying so is cheaper than repeating it.
  final bool attributionDisputed;

  bool get isAttributed => attributedTo != null;
  bool get isSourced => source != null && !attributionDisputed;

  @override
  String toString() => 'Prompt($id, ${attributedTo ?? "unattributed"})';
}
