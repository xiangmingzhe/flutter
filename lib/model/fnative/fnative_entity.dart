class FnativeEntity {
	String head;
	String body;

	FnativeEntity({this.head, this.body});

	FnativeEntity.fromJson(Map<String, dynamic> json) {
		head = json['head'];
		body = json['body'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['head'] = this.head;
		data['body'] = this.body;
		return data;
	}
}
