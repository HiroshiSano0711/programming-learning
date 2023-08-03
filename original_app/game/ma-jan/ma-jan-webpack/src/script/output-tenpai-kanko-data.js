// テンパイ カンコ０
// テンパイ カンコ１
// テンパイ カンコ２
// テンパイ カンコ３

import fs from 'fs';

const all_data = JSON.parse(
  fs.readFileSync(
    new URL('../data/tenpai/all.json', import.meta.url)
    )
);

let tenpai_kanko_0 = []
let tenpai_kanko_1 = []
let tenpai_kanko_2 = []
let tenpai_kanko_3 = []

all_data.forEach(element => {
  if(element.kanko_count == 0){
    tenpai_kanko_0.push(element)
  } else if(element.kanko_count == 1){
    tenpai_kanko_1.push(element)
  } else if(element.kanko_count == 2){
    tenpai_kanko_2.push(element)
  } else if(element.kanko_count == 3){
    tenpai_kanko_3.push(element)
  }
})

try {
  fs.writeFileSync("./src/data/tenpai/kanko-0.json", JSON.stringify(tenpai_kanko_0, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/kanko-1.json", JSON.stringify(tenpai_kanko_1, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/kanko-2.json", JSON.stringify(tenpai_kanko_2, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/kanko-3.json", JSON.stringify(tenpai_kanko_3, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}
