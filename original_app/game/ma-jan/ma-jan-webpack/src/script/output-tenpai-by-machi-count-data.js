import fs from 'fs';

const all_data = JSON.parse(
  fs.readFileSync(
    new URL('../data/tenpai/all.json', import.meta.url)
    )
);

let tenpai_machi_1 = []
let tenpai_machi_2 = []
let tenpai_machi_3 = []
let tenpai_machi_4 = []
let tenpai_machi_5 = []
let tenpai_machi_6 = []
let tenpai_machi_7 = []
let tenpai_machi_8 = []
let tenpai_machi_9 = []

all_data.forEach(element => {
  if(element.machi.length == 1){
    tenpai_machi_1.push(element)
  } else if(element.machi.length == 2){
    tenpai_machi_2.push(element)
  } else if(element.machi.length == 3){
    tenpai_machi_3.push(element)
  } else if(element.machi.length == 4){
    tenpai_machi_4.push(element)
  } else if(element.machi.length == 5){
    tenpai_machi_5.push(element)
  } else if(element.machi.length == 6){
    tenpai_machi_6.push(element)
  } else if(element.machi.length == 7){
    tenpai_machi_7.push(element)
  } else if(element.machi.length == 8){
    tenpai_machi_8.push(element)
  } else if(element.machi.length == 9){
    tenpai_machi_9.push(element)
  }
})

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-1.json", JSON.stringify(tenpai_machi_1, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-2.json", JSON.stringify(tenpai_machi_2, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-3.json", JSON.stringify(tenpai_machi_3, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-4.json", JSON.stringify(tenpai_machi_4, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-5.json", JSON.stringify(tenpai_machi_5, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-6.json", JSON.stringify(tenpai_machi_6, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-7.json", JSON.stringify(tenpai_machi_7, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-8.json", JSON.stringify(tenpai_machi_8, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

try {
  fs.writeFileSync("./src/data/tenpai/machi/count-9.json", JSON.stringify(tenpai_machi_9, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}