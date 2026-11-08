import 'dart:convert';
import 'dart:io';

// Run: dart run tool/check_arb.dart
// gen_l10n silently falls back to the template language when a key is missing,
// so the key sets are compared here.
void main() {
  final arbFiles = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.arb'))
      .toList();
  final template = arbFiles.firstWhere(
    (file) => file.path.endsWith('app_en.arb'),
  );
  final expectedKeys = _messageKeys(template);

  var hasProblems = false;
  for (final file in arbFiles) {
    final keys = _messageKeys(file);
    for (final key in expectedKeys.difference(keys)) {
      stdout.writeln('${file.path}: missing "$key"');
      hasProblems = true;
    }
    for (final key in keys.difference(expectedKeys)) {
      stdout.writeln('${file.path}: extra "$key"');
      hasProblems = true;
    }
  }

  if (hasProblems) {
    exitCode = 1;
  } else {
    stdout.writeln('OK: all locales have the same keys');
  }
}

Set<String> _messageKeys(File arbFile) {
  final content =
      jsonDecode(arbFile.readAsStringSync()) as Map<String, dynamic>;
  return content.keys.where((key) => !key.startsWith('@')).toSet();
}
