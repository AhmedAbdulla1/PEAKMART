import 'dart:io';

void main() {
  print("Enter the feature name:");
  String? featureName = stdin.readLineSync()?.trim();

  if (featureName == null || featureName.isEmpty) {
    print("Feature name cannot be empty!");
    return;
  }

  generateFeatureFiles(featureName);
}

void generateFeatureFiles(String featureName) {
  final baseDir = Directory('lib/features/$featureName');
  final dataDir = Directory('${baseDir.path}/data');
  final modelDir = Directory('${dataDir.path}/model');
  final requestDir = Directory('${modelDir.path}/request');
  final responseDir = Directory('${modelDir.path}/response');
  final domainDir = Directory('${baseDir.path}/domain/entity');
  final repoDir = Directory('${baseDir.path}/repository');

  final dirs = [baseDir, dataDir, modelDir, requestDir, responseDir, domainDir, repoDir];

  // Create directories
  for (var dir in dirs) {
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print("Created directory: ${dir.path}");
    }
  }

  // Create files
  final requestFile = File('${requestDir.path}/${featureName}_request.dart');
  final responseFile = File('${responseDir.path}/${featureName}_response.dart');
  final entityFile = File('${domainDir.path}/${featureName}_entity.dart');
  final repoFile = File('${repoDir.path}/${featureName}_repo.dart');

  createFileWithTemplate(requestFile, 'Request', featureName);
  createFileWithTemplate(responseFile, 'Response', featureName);
  createFileWithTemplate(entityFile, 'Entity', featureName);
  createFileWithTemplate(repoFile, 'Repository', featureName);

  print("Files for feature '$featureName' generated successfully!");
}

void createFileWithTemplate(File file, String type, String featureName) {
  if (!file.existsSync()) {
    file.writeAsStringSync('''
class ${featureName.capitalize()}$type {
  // Add fields and methods for $type
}
''');
    print("Created file: ${file.path}");
  } else {
    print("File already exists: ${file.path}");
  }
}

extension StringExtensions on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
