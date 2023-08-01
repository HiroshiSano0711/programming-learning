// シャンテン数や待ちの数などの違いごとにデータを表示したい場合に使う
// 全データを扱うと動作がかなり重いためデータを分割して利用する。

import { createRequire } from 'module';
const require = createRequire(import.meta.url);

let fs = require("fs");

import all_data from "./data/all.json" assert { type: "json" };
// テンパイ
// イーシャンテン
// リャンシャンテン
// チンイツの場合は３シャンテン以上は存在しない

let tenpai = []
let shanten_1 = []
let shanten_2 = []

all_data.forEach(element => {
  if(element.shanten == 0){
    tenpai.push(element)
  } else if(element.shanten == 1){
    shanten_1.push(element)
  } else if(element.shanten == 2){
    shanten_2.push(element)
  }
})

try {
  fs.writeFileSync("./src/data/tenpai/all.json", JSON.stringify(tenpai, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/shanten_1/all.json", JSON.stringify(shanten_1, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/shanten_2/all.json", JSON.stringify(shanten_2, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}
