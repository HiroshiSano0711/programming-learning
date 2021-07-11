//============================================================================
//牌の配列：JSON形式
//============================================================================
var paiYama = [
	{"No":0,"paiName":"一萬","paiCode":"1m","paiNo":1},
	{"No":1,"paiName":"一萬","paiCode":"1m","paiNo":1},
	{"No":2,"paiName":"一萬","paiCode":"1m","paiNo":1},
	{"No":3,"paiName":"一萬","paiCode":"1m","paiNo":1},
	{"No":4,"paiName":"二萬","paiCode":"2m","paiNo":2},
	{"No":5,"paiName":"二萬","paiCode":"2m","paiNo":2},
	{"No":6,"paiName":"二萬","paiCode":"2m","paiNo":2},
	{"No":7,"paiName":"二萬","paiCode":"2m","paiNo":2},
	{"No":8,"paiName":"三萬","paiCode":"3m","paiNo":3},
	{"No":9,"paiName":"三萬","paiCode":"3m","paiNo":3},
	{"No":10,"paiName":"三萬","paiCode":"3m","paiNo":3},
	{"No":11,"paiName":"三萬","paiCode":"3m","paiNo":3},
	{"No":12,"paiName":"四萬","paiCode":"4m","paiNo":4},
	{"No":13,"paiName":"四萬","paiCode":"4m","paiNo":4},
	{"No":14,"paiName":"四萬","paiCode":"4m","paiNo":4},
	{"No":15,"paiName":"四萬","paiCode":"4m","paiNo":4},
	{"No":16,"paiName":"赤五萬","paiCode":"0m","paiNo":0},
	{"No":17,"paiName":"五萬","paiCode":"5m","paiNo":5},
	{"No":18,"paiName":"五萬","paiCode":"5m","paiNo":5},
	{"No":19,"paiName":"五萬","paiCode":"5m","paiNo":5},
	{"No":20,"paiName":"六萬","paiCode":"6m","paiNo":6},
	{"No":21,"paiName":"六萬","paiCode":"6m","paiNo":6},
	{"No":22,"paiName":"六萬","paiCode":"6m","paiNo":6},
	{"No":23,"paiName":"六萬","paiCode":"6m","paiNo":6},
	{"No":24,"paiName":"七萬","paiCode":"7m","paiNo":7},
	{"No":25,"paiName":"七萬","paiCode":"7m","paiNo":7},
	{"No":26,"paiName":"七萬","paiCode":"7m","paiNo":7},
	{"No":27,"paiName":"七萬","paiCode":"7m","paiNo":7},
	{"No":28,"paiName":"八萬","paiCode":"8m","paiNo":8},
	{"No":29,"paiName":"八萬","paiCode":"8m","paiNo":8},
	{"No":30,"paiName":"八萬","paiCode":"8m","paiNo":8},
	{"No":31,"paiName":"八萬","paiCode":"8m","paiNo":8},
	{"No":32,"paiName":"九萬","paiCode":"9m","paiNo":9},
	{"No":33,"paiName":"九萬","paiCode":"9m","paiNo":9},
	{"No":34,"paiName":"九萬","paiCode":"9m","paiNo":9},
	{"No":35,"paiName":"九萬","paiCode":"9m","paiNo":9},

	{"No":36,"paiName":"一筒","paiCode":"1p","paiNo":11},
	{"No":37,"paiName":"一筒","paiCode":"1p","paiNo":11},
	{"No":38,"paiName":"一筒","paiCode":"1p","paiNo":11},
	{"No":39,"paiName":"一筒","paiCode":"1p","paiNo":11},
	{"No":40,"paiName":"二筒","paiCode":"2p","paiNo":12},
	{"No":41,"paiName":"二筒","paiCode":"2p","paiNo":12},
	{"No":42,"paiName":"二筒","paiCode":"2p","paiNo":12},
	{"No":43,"paiName":"二筒","paiCode":"2p","paiNo":12},
	{"No":44,"paiName":"三筒","paiCode":"3p","paiNo":13},
	{"No":45,"paiName":"三筒","paiCode":"3p","paiNo":13},
	{"No":46,"paiName":"三筒","paiCode":"3p","paiNo":13},
	{"No":47,"paiName":"三筒","paiCode":"3p","paiNo":13},
	{"No":48,"paiName":"四筒","paiCode":"4p","paiNo":14},
	{"No":49,"paiName":"四筒","paiCode":"4p","paiNo":14},
	{"No":50,"paiName":"四筒","paiCode":"4p","paiNo":14},
	{"No":51,"paiName":"四筒","paiCode":"4p","paiNo":14},
	{"No":52,"paiName":"赤五筒","paiCode":"0p","paiNo":10},
	{"No":53,"paiName":"五筒","paiCode":"5p","paiNo":15},
	{"No":54,"paiName":"五筒","paiCode":"5p","paiNo":15},
	{"No":55,"paiName":"五筒","paiCode":"5p","paiNo":15},
	{"No":56,"paiName":"六筒","paiCode":"6p","paiNo":16},
	{"No":57,"paiName":"六筒","paiCode":"6p","paiNo":16},
	{"No":58,"paiName":"六筒","paiCode":"6p","paiNo":16},
	{"No":59,"paiName":"六筒","paiCode":"6p","paiNo":16},
	{"No":60,"paiName":"七筒","paiCode":"7p","paiNo":17},
	{"No":61,"paiName":"七筒","paiCode":"7p","paiNo":17},
	{"No":62,"paiName":"七筒","paiCode":"7p","paiNo":17},
	{"No":63,"paiName":"七筒","paiCode":"7p","paiNo":17},
	{"No":64,"paiName":"八筒","paiCode":"8p","paiNo":18},
	{"No":65,"paiName":"八筒","paiCode":"8p","paiNo":18},
	{"No":66,"paiName":"八筒","paiCode":"8p","paiNo":18},
	{"No":67,"paiName":"八筒","paiCode":"8p","paiNo":18},
	{"No":68,"paiName":"九筒","paiCode":"9p","paiNo":19},
	{"No":69,"paiName":"九筒","paiCode":"9p","paiNo":19},
	{"No":70,"paiName":"九筒","paiCode":"9p","paiNo":19},
	{"No":71,"paiName":"九筒","paiCode":"9p","paiNo":19},

	{"No":72,"paiName":"一索","paiCode":"1s","paiNo":21},
	{"No":73,"paiName":"一索","paiCode":"1s","paiNo":21},
	{"No":74,"paiName":"一索","paiCode":"1s","paiNo":21},
	{"No":75,"paiName":"一索","paiCode":"1s","paiNo":21},
	{"No":76,"paiName":"二索","paiCode":"2s","paiNo":22},
	{"No":77,"paiName":"二索","paiCode":"2s","paiNo":22},
	{"No":78,"paiName":"二索","paiCode":"2s","paiNo":22},
	{"No":79,"paiName":"二索","paiCode":"2s","paiNo":22},
	{"No":80,"paiName":"三索","paiCode":"3s","paiNo":23},
	{"No":81,"paiName":"三索","paiCode":"3s","paiNo":23},
	{"No":82,"paiName":"三索","paiCode":"3s","paiNo":23},
	{"No":83,"paiName":"三索","paiCode":"3s","paiNo":23},
	{"No":84,"paiName":"四索","paiCode":"4s","paiNo":24},
	{"No":85,"paiName":"四索","paiCode":"4s","paiNo":24},
	{"No":86,"paiName":"四索","paiCode":"4s","paiNo":24},
	{"No":87,"paiName":"四索","paiCode":"4s","paiNo":24},
	{"No":88,"paiName":"赤五索","paiCode":"0s","paiNo":20},
	{"No":89,"paiName":"五索","paiCode":"5s","paiNo":25},
	{"No":90,"paiName":"五索","paiCode":"5s","paiNo":25},
	{"No":91,"paiName":"五索","paiCode":"5s","paiNo":25},
	{"No":92,"paiName":"六索","paiCode":"6s","paiNo":26},
	{"No":93,"paiName":"六索","paiCode":"6s","paiNo":26},
	{"No":94,"paiName":"六索","paiCode":"6s","paiNo":26},
	{"No":95,"paiName":"六索","paiCode":"6s","paiNo":26},
	{"No":96,"paiName":"七索","paiCode":"7s","paiNo":27},
	{"No":97,"paiName":"七索","paiCode":"7s","paiNo":27},
	{"No":98,"paiName":"七索","paiCode":"7s","paiNo":27},
	{"No":99,"paiName":"七索","paiCode":"7s","paiNo":27},
	{"No":100,"paiName":"八索","paiCode":"8s","paiNo":28},
	{"No":101,"paiName":"八索","paiCode":"8s","paiNo":28},
	{"No":102,"paiName":"八索","paiCode":"8s","paiNo":28},
	{"No":103,"paiName":"八索","paiCode":"8s","paiNo":28},
	{"No":104,"paiName":"九索","paiCode":"9s","paiNo":29},
	{"No":105,"paiName":"九索","paiCode":"9s","paiNo":29},
	{"No":106,"paiName":"九索","paiCode":"9s","paiNo":29},
	{"No":107,"paiName":"九索","paiCode":"9s","paiNo":29},

	{"No":108,"paiName":"東","paiCode":"1z","paiNo":31},
	{"No":109,"paiName":"東","paiCode":"1z","paiNo":31},
	{"No":110,"paiName":"東","paiCode":"1z","paiNo":31},
	{"No":111,"paiName":"東","paiCode":"1z","paiNo":31},
	{"No":112,"paiName":"南","paiCode":"2z","paiNo":32},
	{"No":113,"paiName":"南","paiCode":"2z","paiNo":32},
	{"No":114,"paiName":"南","paiCode":"2z","paiNo":32},
	{"No":115,"paiName":"南","paiCode":"2z","paiNo":32},
	{"No":116,"paiName":"西","paiCode":"3z","paiNo":33},
	{"No":117,"paiName":"西","paiCode":"3z","paiNo":33},
	{"No":118,"paiName":"西","paiCode":"3z","paiNo":33},
	{"No":119,"paiName":"西","paiCode":"3z","paiNo":33},
	{"No":120,"paiName":"北","paiCode":"4z","paiNo":34},
	{"No":121,"paiName":"北","paiCode":"4z","paiNo":34},
	{"No":122,"paiName":"北","paiCode":"4z","paiNo":34},
	{"No":123,"paiName":"北","paiCode":"4z","paiNo":34},
	{"No":124,"paiName":"白","paiCode":"5z","paiNo":35},
	{"No":125,"paiName":"白","paiCode":"5z","paiNo":35},
	{"No":126,"paiName":"白","paiCode":"5z","paiNo":35},
	{"No":127,"paiName":"白","paiCode":"5z","paiNo":35},
	{"No":128,"paiName":"發","paiCode":"6z","paiNo":36},
	{"No":129,"paiName":"發","paiCode":"6z","paiNo":36},
	{"No":130,"paiName":"發","paiCode":"6z","paiNo":36},
	{"No":131,"paiName":"發","paiCode":"6z","paiNo":36},
	{"No":132,"paiName":"中","paiCode":"7z","paiNo":37},
	{"No":133,"paiName":"中","paiCode":"7z","paiNo":37},
	{"No":134,"paiName":"中","paiCode":"7z","paiNo":37},
	{"No":135,"paiName":"中","paiCode":"7z","paiNo":37}
];

var paiType = [
	{"No":0,"paiName":"赤五萬","cssSprite":"man0"},
	{"No":1,"paiName":"一萬","cssSprite":"man1"},
	{"No":2,"paiName":"二萬","cssSprite":"man2"},
	{"No":3,"paiName":"三萬","cssSprite":"man3"},
	{"No":4,"paiName":"四萬","cssSprite":"man4"},
	{"No":5,"paiName":"五萬","cssSprite":"man5"},
	{"No":6,"paiName":"六萬","cssSprite":"man6"},
	{"No":7,"paiName":"七萬","cssSprite":"man7"},
	{"No":8,"paiName":"八萬","cssSprite":"man8"},
	{"No":9,"paiName":"九萬","cssSprite":"man9"},

	{"No":10,"paiName":"赤五筒","cssSprite":"pin0"},
	{"No":11,"paiName":"一筒","cssSprite":"pin1"},
	{"No":12,"paiName":"二筒","cssSprite":"pin2"},
	{"No":13,"paiName":"三筒","cssSprite":"pin3"},
	{"No":14,"paiName":"四筒","cssSprite":"pin4"},
	{"No":15,"paiName":"五筒","cssSprite":"pin5"},
	{"No":16,"paiName":"六筒","cssSprite":"pin6"},
	{"No":17,"paiName":"七筒","cssSprite":"pin7"},
	{"No":18,"paiName":"八筒","cssSprite":"pin8"},
	{"No":19,"paiName":"九筒","cssSprite":"pin9"},

	{"No":20,"paiName":"赤五索","cssSprite":"sou0"},
	{"No":21,"paiName":"一索","cssSprite":"sou1"},
	{"No":22,"paiName":"二索","cssSprite":"sou2"},
	{"No":23,"paiName":"三索","cssSprite":"sou3"},
	{"No":24,"paiName":"四索","cssSprite":"sou4"},
	{"No":25,"paiName":"五索","cssSprite":"sou5"},
	{"No":26,"paiName":"六索","cssSprite":"sou6"},
	{"No":27,"paiName":"七索","cssSprite":"sou7"},
	{"No":28,"paiName":"八索","cssSprite":"sou8"},
	{"No":29,"paiName":"九索","cssSprite":"sou9"},

	{"No":30,"paiName":"裏","cssSprite":"ji0"},
	{"No":31,"paiName":"東","cssSprite":"ji1"},
	{"No":32,"paiName":"南","cssSprite":"ji2"},
	{"No":33,"paiName":"西","cssSprite":"ji3"},
	{"No":34,"paiName":"北","cssSprite":"ji4"},
	{"No":35,"paiName":"白","cssSprite":"ji5"},
	{"No":36,"paiName":"發","cssSprite":"ji6"},
	{"No":37,"paiName":"中","cssSprite":"ji7"}
];
//グローバル変数==============================================================
var yama = new Array(135);//牌山の配列：136牌
var tehai = new Array(37);//手牌の配列：37種
var dice = 5;
//tehai = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0];
var red5manCount = 0;//赤5マンの数
var red5pinCount = 0;//赤5ピンの数
var red5souCount = 0;//赤5ソウの数
//============================================================================
//元になる牌山を生成する関数
function makePaiYama(){
	var i;
	for(i=0;i<136;i++){
		yama[i] = paiYama[i].paiNo;
	}
}
//============================================================================
//牌山をシャッフルする関数【Mersenne Twister in JavaScriptを利用】
function shufflePaiYama(){
    var mt = new MersenneTwister();//Mersenne­Twister オブジェクトの初期化
	var i,j,k;
	for(i=135;i>0;i--){
    	j = mt.nextInt(0, 135);  // 0 以上 135 未満の乱数（整数）を発生させる
        k = yama[i];//変数kに退避
		yama[i] = yama[j];//乱数で発生した番地の牌を代入する
		yama[j] = k;//変数Kから戻す
	}
}
//============================================================================
//牌山から手牌配列に格納する関数
function inputTehaiStore(){
	tehai = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0];//初期化
	var i;
	for(i=0;i<13;i++){
		tehai[yama[i]] ++;
	}
}
//============================================================================
//赤ドラの有無をチェックしてカウントする処理【赤ドラのカウントを事前にしなかった場合に使う】
//各赤ドラはtehai配列の0，10，20番地にあるものとする
function checkReddora(){
	//グローバル変数の初期化
	red5manCount = 0;//赤5マンの数
	red5pinCount = 0;//赤5ピンの数
	red5souCount = 0;//赤5ソウの数

	//赤五萬の有無をチェックしてカウントする
	if(tehai[0]){
		red5manCount += tehai[0];//赤五萬の牌数を追加
	}
	//赤五筒の有無をチェックしてカウントする
	if(tehai[10]){
		red5pinCount += tehai[10];//赤五筒の牌数を追加
	}
	//赤五索の有無をチェックしてカウントする
	if(tehai[20]){
		red5souCount += tehai[20];//赤五索の牌数を追加
	}
}
//============================================================================
//赤ドラの有無をチェックして配列操作する処理【シャンテン数やテンパイチェックを実行する前に使う】
//tehai配列内を0→5、10→15、20→25
function moveReddora(){
	//赤五萬の有無をチェックして番地を移動させる処理
	if(tehai[0]&&red5manCount){
		tehai[5]+=tehai[0];//赤五萬の牌数を五萬の番地5に追加
		tehai[0]=0;//番地0を初期化
	}
	//赤五筒の有無をチェックして番地を移動させる処理
	if(tehai[10]&&red5pinCount){
		tehai[15]+=tehai[10];//赤五筒の牌数を五筒の番地15に追加
		tehai[10]=0;//番地10を初期化
	}
	//赤五索の有無をチェックして番地を移動させる処理
	if(tehai[20]&&red5souCount){
		tehai[25]+=tehai[20];//赤五索の牌数を五索の番地25に追加
		tehai[20]= 0;//番地20を初期化
	}
}
//============================================================================
//赤ドラの有無をチェックして配列内の元の番地に戻す処理
//tehai配列内を5→0、15→10、25→20
function removeReddora(){
	//赤五萬の有無をチェックして番地を移動：5→0
	if(!tehai[0]&&tehai[5]&&red5manCount){
		tehai[5]--;
		tehai[0]++;
	}
	//赤五筒の有無をチェックして番地を移動：15→10
	if(!tehai[10]&&tehai[15]&&red5pinCount){
		tehai[15]--;
		tehai[10]++;
	}
	//赤五索の有無をチェックして番地を移動：25→20
	if(!tehai[20]&&tehai[25]&&red5souCount){
		tehai[25]--;
		tehai[20]++;
	}
}//============================================================================
$("#PaiMakeBtn").click(function() {
	makePaiYama();//牌山を生成する関数を呼び出す
	shufflePaiYama();//牌山をシャッフルする関数を呼び出す
	inputTehaiStore();//手牌を配列(tehai)に格納する関数を呼び出す

	//サイコロの目に合わせて取り出した牌を表示する
	(function (){
		var i,j,k;
		var paiga="";
		$("#paiTehai").empty();
		//1ブロック～3ブロックまで取り出す処理
		for(i=0;i<3;i++){
			for(j=0;j<4;j++){
				k = dice*2 + j + 16*i;//親が取り出す牌の番地
				//k = (dice*2 + 4) + j + 16*i;//南家が取り出す牌の番地
				//k = (dice*2 + 8) + j + 16*i;//西家が取り出す牌の番地
				//k = (dice*2 + 12) + j + 16*i;//北家が取り出す牌の番地
				paiga = "<span class=\"" + paiType[yama[k]].cssSprite + "\"></span>";//cssスプライトの牌画を配置
				$("#paiTehai").append(paiga);
			}
		}
		//13牌目を取り出す処理
		k = dice*2 + 16*3;//親が取り出す13牌目の番地
		//k = dice*2 + 16*3 + 1;//南家がが取り出す13牌目の番地
		//k = dice*2 + 16*3 + 2;//西家がが取り出す13牌目の番地
		//k = dice*2 + 16*3 + 3;//北家がが取り出す13牌目の番地
		paiga = "<span class=\"" + paiType[yama[k]].cssSprite + "\"></span>";//cssスプライトの牌画を配置
		$("#paiTehai").append(paiga);

	})();

	checkReddora();//赤ドラチェックする関数を呼び出す

	//手牌表示処理1
	(function (){
		var i,k,kazu;
		var paiga="";
		$("#paiTehaiSort1").empty();
		for(i=0;i<38;i++){
			if(tehai[i]){
				kazu = tehai[i];
				for(k=0;k<kazu;k++){
					paiga = "<span class=\"" + paiType[i].cssSprite + "\"></span>";//cssスプライトの牌画を配置
					$("#paiTehaiSort1").append(paiga);
				}
			}
		}
	})();

	//手牌表示処理2
	OutputSortTehai("#paiTehaiSort2");//牌画を師弟の場所に出力する関数の呼び出し

	//シャッフルした牌山を表示する
	(function (){
		var i;
		var paiga="";
		$("#paiYama").empty();
		for(i=0;i<136;i++){
			//親が取り出す牌のバックにシャドウをかける
			if(i==dice*2||i==dice*2+1||i==dice*2+2||i==dice*2+3||i==dice*2 +16||i==dice*2+16+1||i==dice*2+16+2||i==dice*2+16+3||i==dice*2 +32||i==dice*2+32+1||i==dice*2+32+2||i==dice*2+32+3||i==dice*2+48){
				paiga = "<span class=\"" + paiType[yama[i]].cssSprite + " paishadow\"></span>";//cssスプライトの牌画を配置
			}else{
				paiga = "<span class=\"" + paiType[yama[i]].cssSprite + "\"></span>";//cssスプラ
			}
			if(i%17==16){//17牌毎に改行させる
			//if(i==16||i==33||i==50||i==67||i==84||i==101||i==118||i==135){
				paiga += "<br>";
			}
				$("#paiYama").append(paiga);
		}

	})();
});
//=======================================================================================
//赤ドラの位置を修正して手牌を並べ替えて表示させる関数2015/10/244追加
//グローバル変数tehia配列を操作する。牌画はcssスプライトで出力する
//引数id_nameは牌画を出力する場所。cssのid名を指定する
//=======================================================================================
function OutputSortTehai(id_name){
	var i,k,kazu;
	var paiga="";
	var OutputPlace = $(id_name);//jQueryオブジェクトを変数にキャッシュ

	OutputPlace.empty();
	removeReddora();//赤ドラを元の場所に戻す関数を呼び出す【0，10，20へ移動】
	for(i=1;i<38;i++){
		//赤五萬の牌画を出力する
		if(i==5&&red5manCount&&tehai[0]){
			paiga = "<span class=\"" + paiType[0].cssSprite + "\"></span>";//cssスプライトの牌画を配置
			OutputPlace.append(paiga);
		}

		//赤五筒の牌画を出力する
		if(i==15&&red5pinCount&&tehai[10]){
			paiga = "<span class=\"" + paiType[10].cssSprite + "\"></span>";//cssスプライトの牌画を配置
			OutputPlace.append(paiga);
		}

		//赤五索の牌画を出力する
		if(i==25&&red5souCount&&tehai[20]){
			paiga = "<span class=\"" + paiType[20].cssSprite + "\"></span>";//cssスプライトの牌画を配置
			OutputPlace.append(paiga);
		}

		//赤ドラ以外の牌画を出力する
		if(tehai[i]){
			if(i%10===0){continue;}
			kazu = tehai[i];
			for(k=0;k<kazu;k++){
				paiga = "<span class=\"" + paiType[i].cssSprite + "\"></span>";//cssスプライトの牌画を配置
				OutputPlace.append(paiga);
			}
		}
	}
}

//=======================================================================================
//サイコロの目を出す関数
//spotsmin以上spotsmax以下の乱数が生成される。【(最大値 - 最小値 + 1) + 最小値】
function makeSpotsDice(){
	var spotsmax = 6;//最大値
	var spotsmin = 1;//最小値
	var spotsdice = Math.random()*(spotsmax - spotsmin + 1) + spotsmin;//
	spotsdice = Math.floor(spotsdice); //少数以下を丸める
	return spotsdice;
}
//=======================================================================================
$("#DiceBtn1").click(function() {
	var spotsdice;//賽の目
	var i;
	$("#resultPanel").empty();
	for(i=0;i<100;i++){
		spotsdice = makeSpotsDice();//サイコロを振る関数を呼び出す
		if (i==19||i==39||i==59||i==79||i==99){
			spotsdice += "<br>";
		}else{
			spotsdice += ",";
		}
		$("#resultPanel").append(spotsdice);
	}
});
//=======================================================================================
$("#DiceBtn2").click(function() {
	var n1,n2,n3;//賽の目

	n1 = makeSpotsDice();//賽の目1
	n2 = makeSpotsDice();//賽の目2
	n3 = n1 + n2;//賽の目合計

	$("#n1").empty().append(n1);
	$("#n2").empty().append(n2);
	$("#n3").empty().append(n3);
    dice = n3;
});
