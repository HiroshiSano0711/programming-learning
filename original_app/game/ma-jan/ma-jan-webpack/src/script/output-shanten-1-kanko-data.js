// イーシャンテン カンコ０
// イーシャンテン カンコ１
// イーシャンテン カンコ２
// イーシャンテン カンコ３

import fs from 'fs';

const shantenAllData = JSON.parse(
  fs.readFileSync(
    new URL('../data/shanten_1/all.json', import.meta.url),
  ),
);

const kanko0 = [];
const kanko1 = [];
const kanko2 = [];
const kanko3 = [];

shantenAllData.forEach((element) => {
  if (element.kanko_count === 0) {
    kanko0.push(element);
  } else if (element.kanko_count === 1) {
    kanko1.push(element);
  } else if (element.kanko_count === 2) {
    kanko2.push(element);
  } else if (element.kanko_count === 3) {
    kanko3.push(element);
  }
});

try {
  fs.writeFileSync('./src/data/shanten_1/kanko-0.json', JSON.stringify(kanko0, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/shanten_1/kanko-1.json', JSON.stringify(kanko1, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/shanten_1/kanko-2.json', JSON.stringify(kanko2, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/shanten_1/kanko-3.json', JSON.stringify(kanko3, null, '  '));
} catch (e) {
  alert(e.message);
}
