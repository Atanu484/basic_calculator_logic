class HistoryModel {
  final int id;
  final String calculation;
  final DateTime timestamp;

  HistoryModel({
    required this.id,
    required this.calculation,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'calculation': calculation,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static HistoryModel fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'],
      calculation: map['calculation'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  HistoryModel copyWith({
    int? id,
    String? calculation,
    DateTime? timestamp,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      calculation: calculation ?? this.calculation,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}