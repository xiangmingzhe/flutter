class SongInfoLrc{
  String content;
  String info;
  int status;
  String charset;
  String fmt;

  SongInfoLrc({this.content, this.info, this.status, this.charset, this.fmt});

  SongInfoLrc.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    info = json['info'];
    status = json['status'];
    charset = json['charset'];
    fmt = json['fmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['info'] = this.info;
    data['status'] = this.status;
    data['charset'] = this.charset;
    data['fmt'] = this.fmt;
    return data;
  }
}