import 'package:flutter/material.dart';

class MusicTable {
  String text;
  String tab;

  MusicTable(this.text, this.tab);
}

final List<MusicTable> musicList = <MusicTable>[
  new MusicTable("歌曲", "Song"),
  new MusicTable("文件夹", "Folder"),
  new MusicTable("专辑", "Album"),
];

class TabNavigation extends StatelessWidget {
//  TabNavigation({this});
  TabNavigation({this.curMusicTable, this.onSelectTab});

  MusicTable curMusicTable;
  ValueChanged<MusicTable> onSelectTab;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    return Row(
        children: musicList.map((item){
          return GestureDetector(    //手势监听控件，用于监听各种手势
              child: Container(
                padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: Text(item.text,style: TextStyle(color: _colorTabMatching(item)),),
              ),
              onTap: ()=>onSelectTab(item,)
            //onSelectTab函数的使用非常巧妙，
            //相当于定义了一个接口，可操控当前控件以外的数据
          );
        }).toList()
    );

  }

  Color _colorTabMatching(MusicTable table){
    return curMusicTable==table?Colors.black:Colors.grey;
  }
}
