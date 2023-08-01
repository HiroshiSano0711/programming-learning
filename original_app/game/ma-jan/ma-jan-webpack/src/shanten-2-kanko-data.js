// リャンシャンテン カンコ０
// リャンシャンテン カンコ１
// リャンシャンテン カンコ２
// リャンシャンテン カンコ３

import { createRequire } from 'module';
const require = createRequire(import.meta.url);

let fs = require("fs");

import shanten_2_all_data from "./data/shanten_2/all.json" assert { type: "json" };

let shanten_2_kanko_0 = []
let shanten_2_kanko_1 = []
let shanten_2_kanko_2 = []
let shanten_2_kanko_3 = []

shanten_2_all_data.forEach(element => {
  if(element.kanko_count == 0){
    shanten_2_kanko_0.push(element)
  } else if(element.kanko_count == 1){
    shanten_2_kanko_1.push(element)
  } else if(element.kanko_count == 2){
    shanten_2_kanko_2.push(element)
  } else if(element.kanko_count == 3){
    shanten_2_kanko_3.push(element)
  }
})

try {
  fs.writeFileSync("./src/data/shanten_2/kanko-0.json", JSON.stringify(shanten_2_kanko_0, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/shanten_2/kanko-1.json", JSON.stringify(shanten_2_kanko_1, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/shanten_2/kanko-2.json", JSON.stringify(shanten_2_kanko_2, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/shanten_2/kanko-3.json", JSON.stringify(shanten_2_kanko_3, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}
