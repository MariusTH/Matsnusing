class Day {
  String? dag;
  String? middag;
  String? link;
  String? tid;

  Day({this.dag, this.middag, this.link, this.tid});

  Day.fromJson(Map<String, dynamic> json) {
    dag = json['dag'];
    middag = json['middag'];
    link = json['link'];
    tid = json['tid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dag'] = this.dag;
    data['middag'] = this.middag;
    data['link'] = this.link;
    data['tid'] = this.tid;
    return data;
  }
}