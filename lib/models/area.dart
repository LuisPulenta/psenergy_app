class Area {
  String nombrearea = '';

  Area({required this.nombrearea});

  Area.fromJson(Map<String, dynamic> json) {
    nombrearea = json['nombrearea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombrearea'] = nombrearea;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'nombrearea': nombrearea,
    };
  }
}
