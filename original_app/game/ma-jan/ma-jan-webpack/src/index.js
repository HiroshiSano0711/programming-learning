// import { createRequire } from 'module';
// const require = createRequire(import.meta.url);
// const Majiang = require('@kobalab/majiang-core');

// all_chinitsu_json = []
// chinitsu_string.forEach((element, index) => {
//   s = Majiang.Shoupai.fromString('m' + element)
//   shanten_count = Majiang.Util.xiangting(s)
//   machi = Majiang.Util.tingpai(s)
//   if (shanten_count == 0 && machi.length == 0) {
//     shanten_count += 1
//   }
//   let kanko_1_count = (element.match(/1111/g) || []).length;
//   let kanko_2_count = (element.match(/2222/g) || []).length;
//   let kanko_3_count = (element.match(/3333/g) || []).length;
//   let kanko_4_count = (element.match(/4444/g) || []).length;
//   let kanko_5_count = (element.match(/5555/g) || []).length;
//   let kanko_6_count = (element.match(/6666/g) || []).length;
//   let kanko_7_count = (element.match(/7777/g) || []).length;
//   let kanko_8_count = (element.match(/8888/g) || []).length;
//   let kanko_9_count = (element.match(/9999/g) || []).length;
//   let kanko_total = kanko_1_count + kanko_2_count + kanko_3_count + kanko_4_count + kanko_5_count + kanko_6_count + kanko_7_count + kanko_8_count + kanko_9_count
//   let hash = {
//     index: index + 1,
//     haishi: element,
//     shanten: shanten_count,
//     machi: machi,
//     kanko_count: kanko_total
//   }
//   all_chinitsu_json.push(hash)
// })
// console.log(all_chinitsu_json)

// const new_data = chinitsu_all_pattern.map(element => {
// 	let new_machi = element.machi.map(e => {
// 		e = e.replace("m", "")
// 		return e;
// 	})
// 	element.machi = new_machi.filter(machi => machi == '1' || machi == '2' || machi == '3' || machi == '4' || machi == '5' || machi == '6' || machi == '7' || machi == '8' || machi == '9');
// 	return element;
// })
// console.log(new_data)

// const group = chinitsu_all_pattern.reduce((accumulator, current) => {
//   const element = accumulator.find((p) => p.shanten_count === current["shanten"]);
//   if (element) {
//     element.count ++;
//   } else {
//     accumulator.push({
//       count: 1,
//       shanten_count: current["shanten"]
//     });
//   }
//   return accumulator;
// }, []);

// console.log(group)

const paiYama = [
	{"No":0,"paiName":"一万","paiCode":"1m","paiNo":1},
	{"No":1,"paiName":"一万","paiCode":"1m","paiNo":1},
	{"No":2,"paiName":"一万","paiCode":"1m","paiNo":1},
	{"No":3,"paiName":"一万","paiCode":"1m","paiNo":1},
	{"No":4,"paiName":"二万","paiCode":"2m","paiNo":2},
	{"No":5,"paiName":"二万","paiCode":"2m","paiNo":2},
	{"No":6,"paiName":"二万","paiCode":"2m","paiNo":2},
	{"No":7,"paiName":"二万","paiCode":"2m","paiNo":2},
	{"No":8,"paiName":"三万","paiCode":"3m","paiNo":3},
	{"No":9,"paiName":"三万","paiCode":"3m","paiNo":3},
	{"No":10,"paiName":"三万","paiCode":"3m","paiNo":3},
	{"No":11,"paiName":"三万","paiCode":"3m","paiNo":3},
	{"No":12,"paiName":"四万","paiCode":"4m","paiNo":4},
	{"No":13,"paiName":"四万","paiCode":"4m","paiNo":4},
	{"No":14,"paiName":"四万","paiCode":"4m","paiNo":4},
	{"No":15,"paiName":"四万","paiCode":"4m","paiNo":4},
	{"No":16,"paiName":"五万","paiCode":"0m","paiNo":5},
	{"No":17,"paiName":"五万","paiCode":"5m","paiNo":5},
	{"No":18,"paiName":"五万","paiCode":"5m","paiNo":5},
	{"No":19,"paiName":"五万","paiCode":"5m","paiNo":5},
	{"No":20,"paiName":"六万","paiCode":"6m","paiNo":6},
	{"No":21,"paiName":"六万","paiCode":"6m","paiNo":6},
	{"No":22,"paiName":"六万","paiCode":"6m","paiNo":6},
	{"No":23,"paiName":"六万","paiCode":"6m","paiNo":6},
	{"No":24,"paiName":"七万","paiCode":"7m","paiNo":7},
	{"No":25,"paiName":"七万","paiCode":"7m","paiNo":7},
	{"No":26,"paiName":"七万","paiCode":"7m","paiNo":7},
	{"No":27,"paiName":"七万","paiCode":"7m","paiNo":7},
	{"No":28,"paiName":"八万","paiCode":"8m","paiNo":8},
	{"No":29,"paiName":"八万","paiCode":"8m","paiNo":8},
	{"No":30,"paiName":"八万","paiCode":"8m","paiNo":8},
	{"No":31,"paiName":"八万","paiCode":"8m","paiNo":8},
	{"No":32,"paiName":"九万","paiCode":"9m","paiNo":9},
	{"No":33,"paiName":"九万","paiCode":"9m","paiNo":9},
	{"No":34,"paiName":"九万","paiCode":"9m","paiNo":9},
	{"No":35,"paiName":"九万","paiCode":"9m","paiNo":9},

	// {"No":36,"paiName":"一筒","paiCode":"1p","paiNo":11},
	// {"No":37,"paiName":"一筒","paiCode":"1p","paiNo":11},
	// {"No":38,"paiName":"一筒","paiCode":"1p","paiNo":11},
	// {"No":39,"paiName":"一筒","paiCode":"1p","paiNo":11},
	// {"No":40,"paiName":"二筒","paiCode":"2p","paiNo":12},
	// {"No":41,"paiName":"二筒","paiCode":"2p","paiNo":12},
	// {"No":42,"paiName":"二筒","paiCode":"2p","paiNo":12},
	// {"No":43,"paiName":"二筒","paiCode":"2p","paiNo":12},
	// {"No":44,"paiName":"三筒","paiCode":"3p","paiNo":13},
	// {"No":45,"paiName":"三筒","paiCode":"3p","paiNo":13},
	// {"No":46,"paiName":"三筒","paiCode":"3p","paiNo":13},
	// {"No":47,"paiName":"三筒","paiCode":"3p","paiNo":13},
	// {"No":48,"paiName":"四筒","paiCode":"4p","paiNo":14},
	// {"No":49,"paiName":"四筒","paiCode":"4p","paiNo":14},
	// {"No":50,"paiName":"四筒","paiCode":"4p","paiNo":14},
	// {"No":51,"paiName":"四筒","paiCode":"4p","paiNo":14},
	// {"No":52,"paiName":"赤五筒","paiCode":"0p","paiNo":10},
	// {"No":53,"paiName":"五筒","paiCode":"5p","paiNo":15},
	// {"No":54,"paiName":"五筒","paiCode":"5p","paiNo":15},
	// {"No":55,"paiName":"五筒","paiCode":"5p","paiNo":15},
	// {"No":56,"paiName":"六筒","paiCode":"6p","paiNo":16},
	// {"No":57,"paiName":"六筒","paiCode":"6p","paiNo":16},
	// {"No":58,"paiName":"六筒","paiCode":"6p","paiNo":16},
	// {"No":59,"paiName":"六筒","paiCode":"6p","paiNo":16},
	// {"No":60,"paiName":"七筒","paiCode":"7p","paiNo":17},
	// {"No":61,"paiName":"七筒","paiCode":"7p","paiNo":17},
	// {"No":62,"paiName":"七筒","paiCode":"7p","paiNo":17},
	// {"No":63,"paiName":"七筒","paiCode":"7p","paiNo":17},
	// {"No":64,"paiName":"八筒","paiCode":"8p","paiNo":18},
	// {"No":65,"paiName":"八筒","paiCode":"8p","paiNo":18},
	// {"No":66,"paiName":"八筒","paiCode":"8p","paiNo":18},
	// {"No":67,"paiName":"八筒","paiCode":"8p","paiNo":18},
	// {"No":68,"paiName":"九筒","paiCode":"9p","paiNo":19},
	// {"No":69,"paiName":"九筒","paiCode":"9p","paiNo":19},
	// {"No":70,"paiName":"九筒","paiCode":"9p","paiNo":19},
	// {"No":71,"paiName":"九筒","paiCode":"9p","paiNo":19},

	// {"No":72,"paiName":"一索","paiCode":"1s","paiNo":21},
	// {"No":73,"paiName":"一索","paiCode":"1s","paiNo":21},
	// {"No":74,"paiName":"一索","paiCode":"1s","paiNo":21},
	// {"No":75,"paiName":"一索","paiCode":"1s","paiNo":21},
	// {"No":76,"paiName":"二索","paiCode":"2s","paiNo":22},
	// {"No":77,"paiName":"二索","paiCode":"2s","paiNo":22},
	// {"No":78,"paiName":"二索","paiCode":"2s","paiNo":22},
	// {"No":79,"paiName":"二索","paiCode":"2s","paiNo":22},
	// {"No":80,"paiName":"三索","paiCode":"3s","paiNo":23},
	// {"No":81,"paiName":"三索","paiCode":"3s","paiNo":23},
	// {"No":82,"paiName":"三索","paiCode":"3s","paiNo":23},
	// {"No":83,"paiName":"三索","paiCode":"3s","paiNo":23},
	// {"No":84,"paiName":"四索","paiCode":"4s","paiNo":24},
	// {"No":85,"paiName":"四索","paiCode":"4s","paiNo":24},
	// {"No":86,"paiName":"四索","paiCode":"4s","paiNo":24},
	// {"No":87,"paiName":"四索","paiCode":"4s","paiNo":24},
	// {"No":88,"paiName":"赤五索","paiCode":"0s","paiNo":20},
	// {"No":89,"paiName":"五索","paiCode":"5s","paiNo":25},
	// {"No":90,"paiName":"五索","paiCode":"5s","paiNo":25},
	// {"No":91,"paiName":"五索","paiCode":"5s","paiNo":25},
	// {"No":92,"paiName":"六索","paiCode":"6s","paiNo":26},
	// {"No":93,"paiName":"六索","paiCode":"6s","paiNo":26},
	// {"No":94,"paiName":"六索","paiCode":"6s","paiNo":26},
	// {"No":95,"paiName":"六索","paiCode":"6s","paiNo":26},
	// {"No":96,"paiName":"七索","paiCode":"7s","paiNo":27},
	// {"No":97,"paiName":"七索","paiCode":"7s","paiNo":27},
	// {"No":98,"paiName":"七索","paiCode":"7s","paiNo":27},
	// {"No":99,"paiName":"七索","paiCode":"7s","paiNo":27},
	// {"No":100,"paiName":"八索","paiCode":"8s","paiNo":28},
	// {"No":101,"paiName":"八索","paiCode":"8s","paiNo":28},
	// {"No":102,"paiName":"八索","paiCode":"8s","paiNo":28},
	// {"No":103,"paiName":"八索","paiCode":"8s","paiNo":28},
	// {"No":104,"paiName":"九索","paiCode":"9s","paiNo":29},
	// {"No":105,"paiName":"九索","paiCode":"9s","paiNo":29},
	// {"No":106,"paiName":"九索","paiCode":"9s","paiNo":29},
	// {"No":107,"paiName":"九索","paiCode":"9s","paiNo":29},

	// {"No":108,"paiName":"東","paiCode":"1z","paiNo":31},
	// {"No":109,"paiName":"東","paiCode":"1z","paiNo":31},
	// {"No":110,"paiName":"東","paiCode":"1z","paiNo":31},
	// {"No":111,"paiName":"東","paiCode":"1z","paiNo":31},
	// {"No":112,"paiName":"南","paiCode":"2z","paiNo":32},
	// {"No":113,"paiName":"南","paiCode":"2z","paiNo":32},
	// {"No":114,"paiName":"南","paiCode":"2z","paiNo":32},
	// {"No":115,"paiName":"南","paiCode":"2z","paiNo":32},
	// {"No":116,"paiName":"西","paiCode":"3z","paiNo":33},
	// {"No":117,"paiName":"西","paiCode":"3z","paiNo":33},
	// {"No":118,"paiName":"西","paiCode":"3z","paiNo":33},
	// {"No":119,"paiName":"西","paiCode":"3z","paiNo":33},
	// {"No":120,"paiName":"北","paiCode":"4z","paiNo":34},
	// {"No":121,"paiName":"北","paiCode":"4z","paiNo":34},
	// {"No":122,"paiName":"北","paiCode":"4z","paiNo":34},
	// {"No":123,"paiName":"北","paiCode":"4z","paiNo":34},
	// {"No":124,"paiName":"白","paiCode":"5z","paiNo":35},
	// {"No":125,"paiName":"白","paiCode":"5z","paiNo":35},
	// {"No":126,"paiName":"白","paiCode":"5z","paiNo":35},
	// {"No":127,"paiName":"白","paiCode":"5z","paiNo":35},
	// {"No":128,"paiName":"發","paiCode":"6z","paiNo":36},
	// {"No":129,"paiName":"發","paiCode":"6z","paiNo":36},
	// {"No":130,"paiName":"發","paiCode":"6z","paiNo":36},
	// {"No":131,"paiName":"發","paiCode":"6z","paiNo":36},
	// {"No":132,"paiName":"中","paiCode":"7z","paiNo":37},
	// {"No":133,"paiName":"中","paiCode":"7z","paiNo":37},
	// {"No":134,"paiName":"中","paiCode":"7z","paiNo":37},
	// {"No":135,"paiName":"中","paiCode":"7z","paiNo":37}
];

let pai_type = [
	// {"No":0,"paiName":"赤五万","cssSprite":"man0"},
	// {"No":1,"paiName":"一万","cssSprite":"man1"},
	// {"No":2,"paiName":"二万","cssSprite":"man2"},
	// {"No":3,"paiName":"三万","cssSprite":"man3"},
	// {"No":4,"paiName":"四万","cssSprite":"man4"},
	// {"No":5,"paiName":"五万","cssSprite":"man5"},
	// {"No":6,"paiName":"六万","cssSprite":"man6"},
	// {"No":7,"paiName":"七万","cssSprite":"man7"},
	// {"No":8,"paiName":"八万","cssSprite":"man8"},
	// {"No":9,"paiName":"九万","cssSprite":"man9"},

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

	// {"No":20,"paiName":"赤五索","cssSprite":"sou0"},
	// {"No":21,"paiName":"一索","cssSprite":"sou1"},
	// {"No":22,"paiName":"二索","cssSprite":"sou2"},
	// {"No":23,"paiName":"三索","cssSprite":"sou3"},
	// {"No":24,"paiName":"四索","cssSprite":"sou4"},
	// {"No":25,"paiName":"五索","cssSprite":"sou5"},
	// {"No":26,"paiName":"六索","cssSprite":"sou6"},
	// {"No":27,"paiName":"七索","cssSprite":"sou7"},
	// {"No":28,"paiName":"八索","cssSprite":"sou8"},
	// {"No":29,"paiName":"九索","cssSprite":"sou9"},

	// {"No":30,"paiName":"裏","cssSprite":"ji0"},
	// {"No":31,"paiName":"東","cssSprite":"ji1"},
	// {"No":32,"paiName":"南","cssSprite":"ji2"},
	// {"No":33,"paiName":"西","cssSprite":"ji3"},
	// {"No":34,"paiName":"北","cssSprite":"ji4"},
	// {"No":35,"paiName":"白","cssSprite":"ji5"},
	// {"No":36,"paiName":"發","cssSprite":"ji6"},
	// {"No":37,"paiName":"中","cssSprite":"ji7"}
];

// import chinitsu_all_pattern from "./data/all.json" assert { type: "json" };
import tenpai_all from "./data/tenpai/all.json" assert { type: "json" };
// import tenpai_kanko_0 from "./data/tenpai/kanko-0.json" assert { type: "json" };
// import tenpai_kanko_1 from "./data/tenpai/kanko-1.json" assert { type: "json" };
// import tenpai_kanko_2 from "./data/tenpai/kanko-2.json" assert { type: "json" };
// import tenpai_kanko_3 from "./data/tenpai/kanko-3.json" assert { type: "json" };
// import shanten_1_all from "./data/shanten_1/all.json" assert { type: "json" };
// import shanten_1_kanko_0 from "./data/shanten_1/kanko-0.json" assert { type: "json" };
// import shanten_1_kanko_1 from "./data/shanten_1/kanko-1.json" assert { type: "json" };
// import shanten_1_kanko_2 from "./data/shanten_1/kanko-2.json" assert { type: "json" };
// import shanten_1_kanko_3 from "./data/shanten_1/kanko-3.json" assert { type: "json" };
// import shanten_2_all from "./data/shanten_2/all.json" assert { type: "json" };
// import shanten_2_kanko_0 from "./data/shanten_2/kanko-0.json" assert { type: "json" };
// import shanten_2_kanko_1 from "./data/shanten_2/kanko-1.json" assert { type: "json" };
// import shanten_2_kanko_2 from "./data/shanten_2/kanko-2.json" assert { type: "json" };
// import shanten_2_kanko_3 from "./data/shanten_2/kanko-3.json" assert { type: "json" };

// console.log(tenpai_all.length)
// console.log(shanten_1_all.length)
// console.log(shanten_2_all.length)

// console.log(tenpai_kanko_0.length)
// console.log(tenpai_kanko_1.length)
// console.log(tenpai_kanko_2.length)
// console.log(tenpai_kanko_3.length)
// console.log(shanten_1_kanko_0.length)
// console.log(shanten_1_kanko_1.length)
// console.log(shanten_1_kanko_2.length)
// console.log(shanten_1_kanko_3.length)
// console.log(shanten_2_kanko_0.length)
// console.log(shanten_2_kanko_1.length)
// console.log(shanten_2_kanko_2.length)
// console.log(shanten_2_kanko_3.length)

window.addEventListener("DOMContentLoaded", function() {
	const start_btn = document.getElementById("start_btn")

	start_btn.addEventListener("click", (event) => {
		OutputTehai()
	})

	function OutputTehai(){
		const display_dom = document.getElementById("chinitsu_pattern")

		tenpai_all.forEach(element =>{
			if(JSON.stringify(element.machi) == JSON.stringify(["1", "2", "3", "5", "6", "7", "8"])){
				console.log(element.haishi)
				for (let index = 0; index < 13; index++) {
					let paiga = document.createElement("span")
					paiga.className = pai_type[Number(element.haishi[index])].cssSprite
					display_dom.appendChild(paiga)
				}
				let span = document.createElement("span")
				span.className = 'machi'
				display_dom.appendChild(span)

				for (let index = 0; index < element.machi.length; index++) {
					let machi = document.createElement("span")
					machi.className = pai_type[Number(element.machi[index])].cssSprite
					display_dom.appendChild(machi)
				}
				let br = document.createElement("br");
				display_dom.appendChild(br);
			}
		})
	}
});

// 反転データ
// let hanten = []
// shanten_2_all.forEach(element =>{
// 	let haishi = element.haishi
// 	let hanten_arr = []
// 	Array.prototype.forEach.call(haishi, (h) =>{
// 		if(h == '1'){
// 			hanten_arr.unshift('9')
// 		}
// 		if(h == '2'){
// 			hanten_arr.unshift('8')
// 		}
// 		if(h == '3'){
// 			hanten_arr.unshift('7')
// 		}
// 		if(h == '4'){
// 			hanten_arr.unshift('6')
// 		}
// 		if(h == '5'){
// 			hanten_arr.unshift('5')
// 		}
// 		if(h == '6'){
// 			hanten_arr.unshift('4')
// 		}
// 		if(h == '7'){
// 			hanten_arr.unshift('3')
// 		}
// 		if(h == '8'){
// 			hanten_arr.unshift('2')
// 		}
// 		if(h == '9'){
// 			hanten_arr.unshift('1')
// 		}
// 	})
// 	let hanten_haishi = hanten_arr.join('')

// 	hanten.push(hanten_haishi)
// 	console.log(hanten)
// });
// let moto_haishi = shanten_2_all.map((element) => {
// 	 return element.haishi
// })

// hanten.forEach(element =>{
// 	let indexSat = moto_haishi.indexOf(element);
// 	if(indexSat == -1){
// 		console.log(element);
// 	}
// })

// const all_chinitsu_pattern = []

// let all_data_with_pai_count = []

// shanten_1_kanko_2.forEach(element =>{
// 	let count_1 = (element.haishi.match(/1/g) || []).length;
// 	let count_2 = (element.haishi.match(/2/g) || []).length;
// 	let count_3 = (element.haishi.match(/3/g) || []).length;
// 	let count_4 = (element.haishi.match(/4/g) || []).length;
// 	let count_5 = (element.haishi.match(/5/g) || []).length;
// 	let count_6 = (element.haishi.match(/6/g) || []).length;
// 	let count_7 = (element.haishi.match(/7/g) || []).length;
// 	let count_8 = (element.haishi.match(/8/g) || []).length;
// 	let count_9 = (element.haishi.match(/9/g) || []).length;

// 	let for_cpp_data = `
// 	{
//     ${count_1},${count_2},${count_3},${count_4},${count_5},${count_6},${count_7},${count_8},${count_9},
//     0,0,0,0,0,0,0,0,0,
//     0,0,0,0,0,0,0,0,0,
//     0,0,0,0,0,0,0
//   }
// 	`;
// 	all_data_with_pai_count.push(for_cpp_data)
// })
// console.log(`${all_data_with_pai_count}`)

// const group = tenpai_all.reduce((accumulator, current) => {
// 	let agarihai_count = 0
// 	current.machi.forEach(element => {
// 		agarihai_count += 4
// 		let used_count = (current.haishi.match(new RegExp(element, "g")) || []).length;
// 		agarihai_count -= used_count
// 	});
//   const element = accumulator.find((p) => p.agarihai_count === agarihai_count);
//   if (element) {
//     element.count ++;
//   } else {
//     accumulator.push({
//       count: 1,
//       agarihai_count: agarihai_count
//     });
//   }
//   return accumulator;
// }, []);

// console.log(group)

// const new_all_data = chinitsu_all_pattern.map(element => {
// 	let count_1 = (element.haishi.match(/1/g) || []).length;
// 	let count_2 = (element.haishi.match(/2/g) || []).length;
// 	let count_3 = (element.haishi.match(/3/g) || []).length;
// 	let count_4 = (element.haishi.match(/4/g) || []).length;
// 	let count_5 = (element.haishi.match(/5/g) || []).length;
// 	let count_6 = (element.haishi.match(/6/g) || []).length;
// 	let count_7 = (element.haishi.match(/7/g) || []).length;
// 	let count_8 = (element.haishi.match(/8/g) || []).length;
// 	let count_9 = (element.haishi.match(/9/g) || []).length;
// 	element.pai_kind = [count_1, count_2, count_3, count_4, count_5, count_6, count_7, count_8, count_9]	
// 	if(element.shanten == 0){
// 		let agarihai_count = 0
// 		element.machi.forEach(e => {
// 			agarihai_count += 4
// 			let used_count = (element.haishi.match(new RegExp(e, "g")) || []).length;
// 			agarihai_count -= used_count
// 		});
// 		element.agarihai_count = agarihai_count
// 	} else {
// 		element.agarihai_count = 0
// 	}
// 	return element;
// })
// console.log(new_all_data)

// const group = tenpai_all.reduce((accumulator, current) => {
// 	let agarihai_count = 0
// 	current.machi.forEach(element => {
// 		agarihai_count += 4
// 		let used_count = (current.haishi.match(new RegExp(element, "g")) || []).length;
// 		agarihai_count -= used_count
// 	});
//   const element = accumulator.find((p) => p.agarihai_count === agarihai_count);
//   if (element) {
//     element.count ++;
//   } else {
//     accumulator.push({
//       count: 1,
//       agarihai_count: agarihai_count
//     });
//   }
//   return accumulator;
// }, []);

// console.log(group)
// let machi_1_to_8_pattern = []
// let machi_2_to_9_pattern = []
// let machi_1_to_7_pattern = []
// let machi_2_to_8_pattern = []
// let machi_3_to_9_pattern = []
// let machi_1_to_6_pattern = []
// let machi_2_to_7_pattern = []
// let machi_3_to_8_pattern = []
// let machi_4_to_9_pattern = []
// let machi_1_to_5_pattern = []
// let machi_2_to_6_pattern = []
// let machi_3_to_7_pattern = []
// let machi_4_to_8_pattern = []
// let machi_5_to_9_pattern = []

// let machi_1_to_8 = ["1", "2", "3", "4", "5", "6", "7", "8"]
// let machi_2_to_9 = ["2", "3", "4", "5", "6", "7", "8", "9"]

// let machi_1_to_7 = ["1", "2", "3", "4", "5", "6", "7"]
// let machi_2_to_8 = ["2", "3", "4", "5", "6", "7", "8"]
// let machi_3_to_9 = ["3", "4", "5", "6", "7", "8", "9"]
// let machi_1_to_6 = ["1", "2", "3", "4", "5", "6"]
// let machi_2_to_7 = ["2", "3", "4", "5", "6", "7"]
// let machi_3_to_8 = ["3", "4", "5", "6", "7", "8"]
// let machi_4_to_9 = ["4", "5", "6", "7", "8", "9"]
// let machi_1_to_5 = ["1", "2", "3", "4", "5"]
// let machi_2_to_6 = ["2", "3", "4", "5", "6"]
// let machi_3_to_7 = ["3", "4", "5", "6", "7"]
// let machi_4_to_8 = ["4", "5", "6", "7", "8"]
// let machi_5_to_9 = ["5", "6", "7", "8", "9"]

// tenpai_all.forEach(element => {	
// 	if(element.shanten == 0){
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_1_to_8)){
// 			machi_1_to_8_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_2_to_9)){
// 			machi_2_to_9_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_1_to_7)){
// 			machi_1_to_7_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_2_to_8)){
// 			machi_2_to_8_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_3_to_9)){
// 			machi_3_to_9_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_1_to_6)){
// 			machi_1_to_6_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_2_to_7)){
// 			machi_2_to_7_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_3_to_8)){
// 			machi_3_to_8_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_4_to_9)){
// 			machi_4_to_9_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_1_to_5)){
// 			machi_1_to_5_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_2_to_6)){
// 			machi_2_to_6_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_3_to_7)){
// 			machi_3_to_7_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_4_to_8)){
// 			machi_4_to_8_pattern.push(element.haishi)
// 		}
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_5_to_9)){
// 			machi_5_to_9_pattern.push(element.haishi)
// 		}
// 	}
// })

// console.log('machi_1_to_8_pattern')
// console.log(machi_1_to_8_pattern.length)
// console.log('machi_2_to_9_pattern')
// console.log(machi_2_to_9_pattern.length)

// console.log('machi_1_to_7_pattern')
// console.log(machi_1_to_7_pattern.length)
// console.log('machi_2_to_8_pattern')
// console.log(machi_2_to_8_pattern.length)
// console.log('machi_3_to_9_pattern')
// console.log(machi_3_to_9_pattern.length)
// console.log('machi_1_to_6_pattern')
// console.log(machi_1_to_6_pattern.length)
// console.log('machi_2_to_7_pattern')
// console.log(machi_2_to_7_pattern.length)
// console.log('machi_3_to_8_pattern')
// console.log(machi_3_to_8_pattern.length)
// console.log('machi_4_to_9_pattern')
// console.log(machi_4_to_9_pattern.length)
// console.log('machi_1_to_5_pattern')
// console.log(machi_1_to_5_pattern.length)
// console.log('machi_2_to_6_pattern')
// console.log(machi_2_to_6_pattern.length)
// console.log('machi_3_to_7_pattern')
// console.log(machi_3_to_7_pattern.length)
// console.log('machi_4_to_8_pattern')
// console.log(machi_4_to_8_pattern.length)
// console.log('machi_5_to_9_pattern')
// console.log(machi_5_to_9_pattern.length)

// tenpai_all.forEach(element => {	
// 	if(element.shanten == 0){
// 		if(JSON.stringify(element.machi) == JSON.stringify(machi_1_5_9)){
// 			machi_1_5_9_pattern.push(element.haishi)
// 		}
// 	}
// })

// console.log('machi_1_2_5_9_pattern')
// console.log(machi_1_5_9_pattern)



// let machi_1_count = 0
// let machi_2_count = 0
// let machi_3_count = 0
// let machi_4_count = 0
// let machi_5_count = 0
// let machi_6_count = 0
// let machi_7_count = 0
// let machi_8_count = 0
// let machi_9_count = 0


// tenpai_all.forEach(element => {	
// 	if(element.shanten == 0){
// 		console.log(element.machi)
// 		console.log(element.machi.indexOf("8") !== -1)
// 		if(element.machi.indexOf("1") !== -1){
// 			machi_1_count +=1
// 		}
// 		if(element.machi.indexOf("2") !== -1){
// 			machi_2_count +=1
// 		}
// 		if(element.machi.indexOf("3") !== -1){
// 			machi_3_count +=1
// 		}
// 		if(element.machi.indexOf("4") !== -1){
// 			machi_4_count +=1
// 		}
// 		if(element.machi.indexOf("5") !== -1){
// 			machi_5_count +=1
// 		}
// 		if(element.machi.indexOf("6") !== -1){
// 			machi_6_count +=1
// 		}
// 		if(element.machi.indexOf("7") !== -1){
// 			machi_7_count +=1
// 		}
// 		if(element.machi.indexOf("8") !== -1){
// 			machi_8_count +=1
// 		}
// 		if(element.machi.indexOf("9") !== -1){
// 			machi_9_count +=1
// 		}
// 	}
// })

// console.log('machi_1_count')
// console.log(machi_1_count)
// console.log('machi_2_count')
// console.log(machi_2_count)
// console.log('machi_3_count')
// console.log(machi_3_count)
// console.log('machi_4_count')
// console.log(machi_4_count)
// console.log('machi_5_count')
// console.log(machi_5_count)
// console.log('machi_6_count')
// console.log(machi_6_count)
// console.log('machi_7_count')
// console.log(machi_7_count)
// console.log('machi_8_count')
// console.log(machi_8_count)
// console.log('machi_9_count')
// console.log(machi_9_count)
