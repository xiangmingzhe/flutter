class Singer {
  int jSCSSDATE;
  String kgDomain;
  String src;
  Null fr;
  String ver;
  List<ListUrl> list;
  String sTpl;

  Singer(
      {this.jSCSSDATE,
        this.kgDomain,
        this.src,
        this.fr,
        this.ver,
        this.list,
        this.sTpl});

  Singer.fromJson(Map<String, dynamic> json) {
    jSCSSDATE = json['JS_CSS_DATE'];
    kgDomain = json['kg_domain'];
    src = json['src'];
    fr = json['fr'];
    ver = json['ver'];
    if (json['list'] != null) {
      list = new List<ListUrl>();
      json['list'].forEach((v) {
        list.add(new ListUrl.fromJson(v));
      });
    }
    sTpl = json['__Tpl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['JS_CSS_DATE'] = this.jSCSSDATE;
    data['kg_domain'] = this.kgDomain;
    data['src'] = this.src;
    data['fr'] = this.fr;
    data['ver'] = this.ver;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['__Tpl'] = this.sTpl;
    return data;
  }
}

class ListUrl {
  int classid;
  String classname;
  String imgurl;

  ListUrl({this.classid, this.classname, this.imgurl});

  ListUrl.fromJson(Map<String, dynamic> json) {
    classid = json['classid'];
    classname = json['classname'];
    imgurl = json['imgurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classid'] = this.classid;
    data['classname'] = this.classname;
    data['imgurl'] = this.imgurl;
    return data;
  }
}