class RankMusic {
  int jSCSSDATE;
  String kgDomain;
  String src;
  Null fr;
  String ver;
  Rank rank;
  String sTpl;

  RankMusic(
      {this.jSCSSDATE,
        this.kgDomain,
        this.src,
        this.fr,
        this.ver,
        this.rank,
        this.sTpl});

  RankMusic.fromJson(Map<String, dynamic> json) {
    jSCSSDATE = json['JS_CSS_DATE'];
    kgDomain = json['kg_domain'];
    src = json['src'];
    fr = json['fr'];
    ver = json['ver'];
    rank = json['rank'] != null ? new Rank.fromJson(json['rank']) : null;
    sTpl = json['__Tpl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['JS_CSS_DATE'] = this.jSCSSDATE;
    data['kg_domain'] = this.kgDomain;
    data['src'] = this.src;
    data['fr'] = this.fr;
    data['ver'] = this.ver;
    if (this.rank != null) {
      data['rank'] = this.rank.toJson();
    }
    data['__Tpl'] = this.sTpl;
    return data;
  }
}

class Rank {
  int total;
  List<RankMusicInfo> list;

  Rank({this.total, this.list});

  Rank.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = new List<RankMusicInfo>();
      json['list'].forEach((v) {
        list.add(new RankMusicInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RankMusicInfo {
  int rankid;
  int id;
  String updateFrequency;
  String intro;
  String jumpUrl;
  String jumpTitle;
  String imgurl;
  String banner7url;
  int isvol;
  String bannerurl;
  int customType;
  String rankname;
  int ranktype;

  RankMusicInfo(
      {this.rankid,
        this.id,
        this.updateFrequency,
        this.intro,
        this.jumpUrl,
        this.jumpTitle,
        this.imgurl,
        this.banner7url,
        this.isvol,
        this.bannerurl,
        this.customType,
        this.rankname,
        this.ranktype});

  RankMusicInfo.fromJson(Map<String, dynamic> json) {
    rankid = json['rankid'];
    id = json['id'];
    updateFrequency = json['update_frequency'];
    intro = json['intro'];
    jumpUrl = json['jump_url'];
    jumpTitle = json['jump_title'];
    imgurl = json['imgurl'];
    banner7url = json['banner7url'];
    isvol = json['isvol'];
    bannerurl = json['bannerurl'];
    customType = json['custom_type'];
    rankname = json['rankname'];
    ranktype = json['ranktype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rankid'] = this.rankid;
    data['id'] = this.id;
    data['update_frequency'] = this.updateFrequency;
    data['intro'] = this.intro;
    data['jump_url'] = this.jumpUrl;
    data['jump_title'] = this.jumpTitle;
    data['imgurl'] = this.imgurl;
    data['banner7url'] = this.banner7url;
    data['isvol'] = this.isvol;
    data['bannerurl'] = this.bannerurl;
    data['custom_type'] = this.customType;
    data['rankname'] = this.rankname;
    data['ranktype'] = this.ranktype;
    return data;
  }
}