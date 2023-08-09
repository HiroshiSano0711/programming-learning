// シャンテン数や待ちの数などの違いごとにデータを表示したい場合に使う
// 全データを扱うと動作がかなり重いためデータを分割して利用する。
// テンパイ
// イーシャンテン
// リャンシャンテン
// チンイツの場合は３シャンテン以上は存在しない

import fs from 'fs';

const allData = JSON.parse(
  fs.readFileSync(
    new URL('../data/all.json', import.meta.url),
  ),
);

const tenpai = [];
const shanten1 = [];
const shanten2 = [];

allData.forEach((element) => {
  if (element.shanten === 0) {
    tenpai.push(element);
  } else if (element.shanten === 1) {
    shanten1.push(element);
  } else if (element.shanten === 2) {
    shanten2.push(element);
  }
});

try {
  fs.writeFileSync('./src/data/tenpai/all.json', JSON.stringify(tenpai, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/shanten1/all.json', JSON.stringify(shanten1, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/shanten2/all.json', JSON.stringify(shanten2, null, '  '));
} catch (e) {
  alert(e.message);
}
