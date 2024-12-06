class ChannelModel {
  ChannelModel({
    required this.tName,
    required this.uName,
    required this.s,
    required this.pc,
    required this.l,
    required this.a,
    required this.image,
    required this.p,
  });

  final String? tName;
  final String? uName;
  final int? s;
  final String? pc;
  final String? l;
  final String? a;
  final String? image;
  final int? p;

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      tName: json["t"],
      uName: json["u"],
      s: json["s"],
      pc: json["pc"],
      l: json["l"],
      a: json["a"],
      image: 'https://av.combot.org/${json["i"]}',
      p: json["p"],
    );
  }

  @override
  String toString() {
    return "$tName, $uName, $s, $pc, $l, $a, $image, $p";
  }
}
