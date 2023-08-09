// テンパイ カンコ０
// テンパイ カンコ１
// テンパイ カンコ２
// テンパイ カンコ３

import fs from 'fs';

const tenpaiAllData = JSON.parse(
  fs.readFileSync(
    new URL('../data/tenpai/all.json', import.meta.url),
  ),
);

const tenpaiKanko0 = [];
const tenpaiKanko1 = [];
const tenpaiKanko2 = [];
const tenpaiKanko3 = [];

tenpaiAllData.forEach((element) => {
  if (element.kanko_count === 0) {
    tenpaiKanko0.push(element);
  } else if (element.kanko_count === 1) {
    tenpaiKanko1.push(element);
  } else if (element.kanko_count === 2) {
    tenpaiKanko2.push(element);
  } else if (element.kanko_count === 3) {
    tenpaiKanko3.push(element);
  }
});

try {
  fs.writeFileSync('./src/data/tenpai/kanko-0.json', JSON.stringify(tenpaiKanko0, null, '  '));
} catch (e) {
  console.log(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/kanko-1.json', JSON.stringify(tenpaiKanko1, null, '  '));
} catch (e) {
  console.log(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/kanko-2.json', JSON.stringify(tenpaiKanko2, null, '  '));
} catch (e) {
  console.log(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/kanko-3.json', JSON.stringify(tenpaiKanko3, null, '  '));
} catch (e) {
  console.log(e.message);
}
