import 'normalize.css';
import "./style.scss";

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
	{"No":0,"paiName":"赤五万","cssSprite":"man-0"},
	{"No":1,"paiName":"一万","cssSprite":"man-1"},
	{"No":2,"paiName":"二万","cssSprite":"man-2"},
	{"No":3,"paiName":"三万","cssSprite":"man-3"},
	{"No":4,"paiName":"四万","cssSprite":"man-4"},
	{"No":5,"paiName":"五万","cssSprite":"man-5"},
	{"No":6,"paiName":"六万","cssSprite":"man-6"},
	{"No":7,"paiName":"七万","cssSprite":"man-7"},
	{"No":8,"paiName":"八万","cssSprite":"man-8"},
	{"No":9,"paiName":"九万","cssSprite":"man-9"},

	{"No":10,"paiName":"赤五筒","cssSprite":"pin-0"},
	{"No":11,"paiName":"一筒","cssSprite":"pin-1"},
	{"No":12,"paiName":"二筒","cssSprite":"pin-2"},
	{"No":13,"paiName":"三筒","cssSprite":"pin-3"},
	{"No":14,"paiName":"四筒","cssSprite":"pin-4"},
	{"No":15,"paiName":"五筒","cssSprite":"pin-5"},
	{"No":16,"paiName":"六筒","cssSprite":"pin-6"},
	{"No":17,"paiName":"七筒","cssSprite":"pin-7"},
	{"No":18,"paiName":"八筒","cssSprite":"pin-8"},
	{"No":19,"paiName":"九筒","cssSprite":"pin-9"},

	{"No":20,"paiName":"赤五索","cssSprite":"sou-0"},
	{"No":21,"paiName":"一索","cssSprite":"sou-1"},
	{"No":22,"paiName":"二索","cssSprite":"sou-2"},
	{"No":23,"paiName":"三索","cssSprite":"sou-3"},
	{"No":24,"paiName":"四索","cssSprite":"sou-4"},
	{"No":25,"paiName":"五索","cssSprite":"sou-5"},
	{"No":26,"paiName":"六索","cssSprite":"sou-6"},
	{"No":27,"paiName":"七索","cssSprite":"sou-7"},
	{"No":28,"paiName":"八索","cssSprite":"sou-8"},
	{"No":29,"paiName":"九索","cssSprite":"sou-9"},

	{"No":30,"paiName":"裏","cssSprite":"ji-0"},
	{"No":31,"paiName":"東","cssSprite":"ji-1"},
	{"No":32,"paiName":"南","cssSprite":"ji-2"},
	{"No":33,"paiName":"西","cssSprite":"ji-3"},
	{"No":34,"paiName":"北","cssSprite":"ji-4"},
	{"No":35,"paiName":"白","cssSprite":"ji-5"},
	{"No":36,"paiName":"發","cssSprite":"ji-6"},
	{"No":37,"paiName":"中","cssSprite":"ji-7"}
];

// import chinitsu_all_pattern from "./data/all.json" assert { type: "json" };
import tenpai_all from "./data/tenpai/all.json" assert { type: "json" };

window.addEventListener("DOMContentLoaded", function() {
	const start_btn = document.getElementById("start_btn")

	start_btn.addEventListener("click", (event) => {
		OutputTehai()
	})

	function OutputTehai(){
    const count = []
		const display_dom = document.getElementById("chinitsu_pattern")
		tenpai_all.forEach(element =>{
			if(JSON.stringify(element.machi) == JSON.stringify(["1", "2", "3", "4", "5", "6", "7", "8", "9"])){
				console.log(element.haishi)
        count.push(element.haishi)
				for (let index = 0; index < 13; index++) {
					let paiga = document.createElement("span")
					paiga.className = pai_type[Number(element.haishi[index])].cssSprite
          paiga.classList.add("paiga", "pai-size")
					display_dom.appendChild(paiga)
				}
				let span = document.createElement("span")
				span.className = 'machi'
				display_dom.appendChild(span)

				for (let index = 0; index < element.machi.length; index++) {
					let machi = document.createElement("span")
					machi.className = pai_type[Number(element.machi[index])].cssSprite
          machi.classList.add("paiga", "pai-size")
					display_dom.appendChild(machi)
				}
				let br = document.createElement("br");
				display_dom.appendChild(br);
			}
		})
    console.log(count.length)
	}
});
