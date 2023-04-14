import 'package:combustile/combustile.dart';
import 'package:yaml/yaml.dart';

/// Parses a [Placement] from a [YamlMap].
Placement parsePlacement(YamlMap map) {
  if (map.keys.first == 'absolute') {
    return parseAbsolutePlacement(map['absolute'] as YamlMap);
  } else if (map.keys.first == 'relative') {
    return parseRelativePlacement(map['relative'] as YamlMap);
  } else {
    throw ArgumentError('Invalid placement: $map');
  }
}

/// Parses an [AbsolutePlacement] from a [YamlMap].
Placement parseAbsolutePlacement(YamlMap map) {
  return AbsolutePlacement(
    position: parseVector2(map['position'] as String),
    size: parseVector2(map['size'] as String),
  );
}

/// Parses a [RelativePlacement] from a [YamlMap].
Placement parseRelativePlacement(YamlMap map) {
  return RelativePlacement(
    left: map.containsKey('left') ? (map['left'] as num).toDouble() : null,
    top: map.containsKey('top') ? (map['top'] as num).toDouble() : null,
    right: map.containsKey('right') ? (map['right'] as num).toDouble() : null,
    bottom:
        map.containsKey('bottom') ? (map['bottom'] as num).toDouble() : null,
    width: map.containsKey('width') ? (map['width'] as num).toDouble() : null,
    height:
        map.containsKey('height') ? (map['height'] as num).toDouble() : null,
  );
}
