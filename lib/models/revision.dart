/// A superseded version of an entry's text.
///
/// Entries are editable, because writers revise and would not forgive an app
/// that froze a typo forever. But the history stays visible: for a story told
/// in instalments, the author's second thoughts are part of what readers came
/// for.
class Revision {
  const Revision({
    required this.id,
    required this.entryId,
    required this.body,
    required this.sequence,
    required this.replacedAt,
  });

  final String id;
  final String entryId;

  /// The text as it read before the edit.
  final String body;

  /// Which version this text was, counting from 0 for the original.
  ///
  /// History is ordered by this rather than by [replacedAt]: two edits can
  /// land in the same millisecond, and a timestamp then gives no stable order.
  final int sequence;

  /// When this text was replaced, in UTC.
  final DateTime replacedAt;

  @override
  String toString() => 'Revision(v$sequence of $entryId)';
}
