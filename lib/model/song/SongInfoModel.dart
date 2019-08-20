class SongInfo{
  int fileHead;
  int q;
  Extra extra;
  int fileSize;
  String choricSinger;
  String albumImg;
  String topicRemark;
  String url;
  int time;
  TransParam transParam;
  int albumid;
  String singerName;
  String topicUrl;
  String extName;
  String songName;
  String singerHead;
  String hash;
  String mvhash;
  String storeType;
  String error;
  String imgUrl;
  int albumAudioId;
  String areaCode;
  int ctype;
  int i128privilege;
  int bitRate;
  int status;
  int stype;
  String reqHash;
  int i320privilege;
  String intro;
  int singerId;
  int privilege;
  String fileName;
  int errcode;
  int sqprivilege;
  List<String> backupUrl;
  int timeLength;



  SongInfo(
      {this.fileHead,
        this.q,
        this.extra,
        this.fileSize,
        this.choricSinger,
        this.albumImg,
        this.topicRemark,
        this.url,
        this.time,
        this.transParam,
        this.albumid,
        this.singerName,
        this.topicUrl,
        this.extName,
        this.songName,
        this.singerHead,
        this.hash,
        this.mvhash,
        this.storeType,
        this.error,
        this.imgUrl,
        this.albumAudioId,
        this.areaCode,
        this.ctype,
        this.i128privilege,
        this.bitRate,
        this.status,
        this.stype,
        this.reqHash,
        this.i320privilege,
        this.intro,
        this.singerId,
        this.privilege,
        this.fileName,
        this.errcode,
        this.sqprivilege,
        this.backupUrl,
        this.timeLength});

  SongInfo.fromJson(Map<String, dynamic> json) {
    fileHead = json['fileHead'];
    q = json['q'];
    extra = json['extra'] != null ? new Extra.fromJson(json['extra']) : null;
    fileSize = json['fileSize'];
    choricSinger = json['choricSinger'];
    albumImg = json['album_img'];
    topicRemark = json['topic_remark'];
    url = json['url'];
    time = json['time'];
    transParam = json['trans_param'] != null
        ? new TransParam.fromJson(json['trans_param'])
        : null;
    albumid = json['albumid'];
    singerName = json['singerName'];
    topicUrl = json['topic_url'];
    extName = json['extName'];
    songName = json['songName'];
    singerHead = json['singerHead'];
    hash = json['hash'];
    mvhash = json['mvhash'];
    storeType = json['store_type'];
    error = json['error'];
    imgUrl = json['imgUrl'];
    albumAudioId = json['album_audio_id'];
    areaCode = json['area_code'];
    ctype = json['ctype'];
    i128privilege = json['128privilege'];
    bitRate = json['bitRate'];
    status = json['status'];
    stype = json['stype'];
    reqHash = json['req_hash'];
    i320privilege = json['320privilege'];
    intro = json['intro'];
    singerId = json['singerId'];
    privilege = json['privilege'];
    fileName = json['fileName'];
    errcode = json['errcode'];
    sqprivilege = json['sqprivilege'];
    backupUrl = json['backup_url'].cast<String>();
    timeLength = json['timeLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileHead'] = this.fileHead;
    data['q'] = this.q;
    if (this.extra != null) {
      data['extra'] = this.extra.toJson();
    }
    data['fileSize'] = this.fileSize;
    data['choricSinger'] = this.choricSinger;
    data['album_img'] = this.albumImg;
    data['topic_remark'] = this.topicRemark;
    data['url'] = this.url;
    data['time'] = this.time;
    if (this.transParam != null) {
      data['trans_param'] = this.transParam.toJson();
    }
    data['albumid'] = this.albumid;
    data['singerName'] = this.singerName;
    data['topic_url'] = this.topicUrl;
    data['extName'] = this.extName;
    data['songName'] = this.songName;
    data['singerHead'] = this.singerHead;
    data['hash'] = this.hash;
    data['mvhash'] = this.mvhash;
    data['store_type'] = this.storeType;
    data['error'] = this.error;
    data['imgUrl'] = this.imgUrl;
    data['album_audio_id'] = this.albumAudioId;
    data['area_code'] = this.areaCode;
    data['ctype'] = this.ctype;
    data['128privilege'] = this.i128privilege;
    data['bitRate'] = this.bitRate;
    data['status'] = this.status;
    data['stype'] = this.stype;
    data['req_hash'] = this.reqHash;
    data['320privilege'] = this.i320privilege;
    data['intro'] = this.intro;
    data['singerId'] = this.singerId;
    data['privilege'] = this.privilege;
    data['fileName'] = this.fileName;
    data['errcode'] = this.errcode;
    data['sqprivilege'] = this.sqprivilege;
    data['backup_url'] = this.backupUrl;
    data['timeLength'] = this.timeLength;
    return data;
  }
}

class Extra {
  int i320filesize;
  int sqfilesize;
  String sqhash;
  String s128hash;
  String s320hash;
  int i128filesize;

  Extra(
      {this.i320filesize,
        this.sqfilesize,
        this.sqhash,
        this.s128hash,
        this.s320hash,
        this.i128filesize});

  Extra.fromJson(Map<String, dynamic> json) {
    i320filesize = json['320filesize'];
    sqfilesize = json['sqfilesize'];
    sqhash = json['sqhash'];
    s128hash = json['128hash'];
    s320hash = json['320hash'];
    i128filesize = json['128filesize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['320filesize'] = this.i320filesize;
    data['sqfilesize'] = this.sqfilesize;
    data['sqhash'] = this.sqhash;
    data['128hash'] = this.s128hash;
    data['320hash'] = this.s320hash;
    data['128filesize'] = this.i128filesize;
    return data;
  }
}

class TransParam {
  int cid;
  int payBlockTpl;
  int musicpackAdvance;
  int displayRate;
  int display;

  TransParam(
      {this.cid,
        this.payBlockTpl,
        this.musicpackAdvance,
        this.displayRate,
        this.display});

  TransParam.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    payBlockTpl = json['pay_block_tpl'];
    musicpackAdvance = json['musicpack_advance'];
    displayRate = json['display_rate'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['pay_block_tpl'] = this.payBlockTpl;
    data['musicpack_advance'] = this.musicpackAdvance;
    data['display_rate'] = this.displayRate;
    data['display'] = this.display;
    return data;
  }
}