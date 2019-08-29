class SingerListEntity {
	String kgDomain;
	SingerListSingers singers;
	int jsCssDate;
	String ver;
	int classid;
	String classname;
	String src;
	String sTpl;
	int pagesize;
	dynamic fr;

	SingerListEntity({this.kgDomain, this.singers, this.jsCssDate, this.ver, this.classid, this.classname, this.src, this.sTpl, this.pagesize, this.fr});

	SingerListEntity.fromJson(Map<String, dynamic> json) {
		kgDomain = json['kg_domain'];
		singers = json['singers'] != null ? new SingerListSingers.fromJson(json['singers']) : null;
		jsCssDate = json['JS_CSS_DATE'];
		ver = json['ver'];
		classid = json['classid'];
		classname = json['classname'];
		src = json['src'];
		sTpl = json['__Tpl'];
		pagesize = json['pagesize'];
		fr = json['fr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['kg_domain'] = this.kgDomain;
		if (this.singers != null) {
      data['singers'] = this.singers.toJson();
    }
		data['JS_CSS_DATE'] = this.jsCssDate;
		data['ver'] = this.ver;
		data['classid'] = this.classid;
		data['classname'] = this.classname;
		data['src'] = this.src;
		data['__Tpl'] = this.sTpl;
		data['pagesize'] = this.pagesize;
		data['fr'] = this.fr;
		return data;
	}
}

class SingerListSingers {
	int total;
	int pagesize;
	int page;
	SingerListSingersList xList;

	SingerListSingers({this.total, this.pagesize, this.page, this.xList});

	SingerListSingers.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		pagesize = json['pagesize'];
		page = json['page'];
		xList = json['list'] != null ? new SingerListSingersList.fromJson(json['list']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		data['pagesize'] = this.pagesize;
		data['page'] = this.page;
		if (this.xList != null) {
      data['list'] = this.xList.toJson();
    }
		return data;
	}
}

class SingerListSingersList {
	int total;
	List<SingerListSingersListInfo> info;

	SingerListSingersList({this.total, this.info});

	SingerListSingersList.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['info'] != null) {
			info = new List<SingerListSingersListInfo>();(json['info'] as List).forEach((v) { info.add(new SingerListSingersListInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SingerListSingersListInfo {
	String imgurl;
	int singerid;
	String singername;

	SingerListSingersListInfo({this.imgurl, this.singerid, this.singername});

	SingerListSingersListInfo.fromJson(Map<String, dynamic> json) {
		imgurl = json['imgurl'];
		singerid = json['singerid'];
		singername = json['singername'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imgurl'] = this.imgurl;
		data['singerid'] = this.singerid;
		data['singername'] = this.singername;
		return data;
	}
}
