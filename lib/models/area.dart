class Area {
  String nombrearea = '';

  Area({required this.nombrearea});

  Area.fromJson(Map<String, dynamic> json) {
    nombrearea = json['nombrearea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombrearea'] = this.nombrearea;
    return data;
  }
}
