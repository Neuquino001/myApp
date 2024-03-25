class DataApi {
  final String? comando;
  final String? tipo;
  final String? status;
  final dynamic data;

  DataApi({this.comando, this.tipo, this.status, this.data});

  factory DataApi.fromJson(Map<String, dynamic> json) {
    return DataApi(
      comando: json['comando'],
      tipo: json['tipo'],
      status: json['status'],
      data: json['data'],
    );
  }
  Map<String, dynamic> toJson() => {
        'comando': comando,
        'tipo': tipo,
        'status': status,
        'data': data,
      };
}

class Data {
  final String? funcion;
  final String? tipo;
  final String? status;
  final dynamic data;

  Data({this.funcion, this.tipo, this.status, this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      funcion: json['funcion'],
      tipo: json['tipo'],
      status: json['status'],
      data: json['data'],
    );
  }
  Map<String, dynamic> toJson() => {
        'funcion': funcion,
        'tipo': tipo,
        'status': status,
        'data': data,
      };
}
