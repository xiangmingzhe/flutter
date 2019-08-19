
class SongLrc{
  List<Null> ugccandidates;
  String info;
  int status;
  String keyword;
  int ugc;
  String companys;
  int ugccount;
  String proposal;
  int hasCompleteRight;
  List<Candidates> candidates;

  SongLrc({this.ugccandidates, this.info, this.status, this.keyword, this.ugc, this.companys, this.ugccount, this.proposal, this.hasCompleteRight, this.candidates});

  SongLrc.fromJson(Map<String, dynamic> json) {
//    if (json['ugccandidates'] != null) {
//      ugccandidates = new List<Null>();
//      json['ugccandidates'].forEach((v) { ugccandidates.add(new Null.fromJson(v)); });
//    }
    info = json['info'];
    status = json['status'];
    keyword = json['keyword'];
    ugc = json['ugc'];
    companys = json['companys'];
    ugccount = json['ugccount'];
    proposal = json['proposal'];
    hasCompleteRight = json['has_complete_right'];
    if (json['candidates'] != null) {
      candidates = new List<Candidates>();
      json['candidates'].forEach((v) { candidates.add(new Candidates.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.ugccandidates != null) {
//      data['ugccandidates'] = this.ugccandidates.map((v) => v.toJson()).toList();
//    }
    data['info'] = this.info;
    data['status'] = this.status;
    data['keyword'] = this.keyword;
    data['ugc'] = this.ugc;
    data['companys'] = this.companys;
    data['ugccount'] = this.ugccount;
    data['proposal'] = this.proposal;
    data['has_complete_right'] = this.hasCompleteRight;
    if (this.candidates != null) {
      data['candidates'] = this.candidates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Candidates {
  String soundname;
  int krctype;
  String id;
  String originame;
  String accesskey;
  List<Parinfo> parinfo;
  String origiuid;
  int score;
  int hitlayer;
  int duration;
  int adjust;
  String uid;
  String song;
  String transuid;
  String transname;
  String sounduid;
  String nickname;
  int contenttype;
  String singer;
  String language;

  Candidates({this.soundname, this.krctype, this.id, this.originame, this.accesskey, this.parinfo, this.origiuid, this.score, this.hitlayer, this.duration, this.adjust, this.uid, this.song, this.transuid, this.transname, this.sounduid, this.nickname, this.contenttype, this.singer, this.language});

  Candidates.fromJson(Map<String, dynamic> json) {
    soundname = json['soundname'];
    krctype = json['krctype'];
    id = json['id'];
    originame = json['originame'];
    accesskey = json['accesskey'];
    if (json['parinfo'] != null) {
      parinfo = new List<Parinfo>();
      json['parinfo'].forEach((v) { parinfo.add(new Parinfo.fromJson(v)); });
    }
    origiuid = json['origiuid'];
    score = json['score'];
    hitlayer = json['hitlayer'];
    duration = json['duration'];
    adjust = json['adjust'];
    uid = json['uid'];
    song = json['song'];
    transuid = json['transuid'];
    transname = json['transname'];
    sounduid = json['sounduid'];
    nickname = json['nickname'];
    contenttype = json['contenttype'];
    singer = json['singer'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soundname'] = this.soundname;
    data['krctype'] = this.krctype;
    data['id'] = this.id;
    data['originame'] = this.originame;
    data['accesskey'] = this.accesskey;
    if (this.parinfo != null) {
      data['parinfo'] = this.parinfo.map((v) => v.toJson()).toList();
    }
    data['origiuid'] = this.origiuid;
    data['score'] = this.score;
    data['hitlayer'] = this.hitlayer;
    data['duration'] = this.duration;
    data['adjust'] = this.adjust;
    data['uid'] = this.uid;
    data['song'] = this.song;
    data['transuid'] = this.transuid;
    data['transname'] = this.transname;
    data['sounduid'] = this.sounduid;
    data['nickname'] = this.nickname;
    data['contenttype'] = this.contenttype;
    data['singer'] = this.singer;
    data['language'] = this.language;
    return data;
  }
}

class Parinfo {



Parinfo.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}