/*ToggleButtons(
              //찾기 토글 버튼
              borderColor: Colors.white, //보더색
              fillColor: HexColor("0057FF"), //버튼 색
              borderWidth: 0, //보더 두깨
              selectedBorderColor: Colors.black, // 선택시 보더 색
              selectedColor: Colors.white, // 선택시 텍스트 색
              borderRadius: BorderRadius.circular(10),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Device', // search by device
                    style: TextStyle(fontSize: 25),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Time', // serach by time
                    style: TextStyle(fontSize: 25),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ), 
              ],
              onPressed: (int index) {
                setState(() {
                  //when one toggle option is selected, de-select the other
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] =  (i == index); //if i == index, set isSelected[i] = true, if i != index, set isSelcted[i] = false
                                      
                  }
                });
              },
              isSelected: isSelected,
            ),
          ],*/
