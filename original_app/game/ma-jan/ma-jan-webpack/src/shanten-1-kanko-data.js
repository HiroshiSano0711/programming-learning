// イーシャンテン カンコ０
// イーシャンテン カンコ１
// イーシャンテン カンコ２
// イーシャンテン カンコ３

import { createRequire } from 'module';
const require = createRequire(import.meta.url);

let fs = require("fs");

import shanten_1_all_data from "./data/shanten_1/all.json" assert { type: "json" };

let shanten_1_kanko_0 = []
let shanten_1_kanko_1 = []
let shanten_1_kanko_2 = []
let shanten_1_kanko_3 = []

shanten_1_all_data.forEach(element => {
  if(element.kanko_count == 0){
    shanten_1_kanko_0.push(element)
  } else if(element.kanko_count == 1){
    shanten_1_kanko_1.push(element)
  } else if(element.kanko_count == 2){
    shanten_1_kanko_2.push(element)
  } else if(element.kanko_count == 3){
    shanten_1_kanko_3.push(element)
  }
})

try {
  fs.writeFileSync("./src/data/shanten_1/kanko-0.json", JSON.stringify(shanten_1_kanko_0, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/shanten_1/kanko-1.json", JSON.stringify(shanten_1_kanko_1, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/shanten_1/kanko-2.json", JSON.stringify(shanten_1_kanko_2, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/shanten_1/kanko-3.json", JSON.stringify(shanten_1_kanko_3, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}
