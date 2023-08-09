import fs from 'fs';

const tenpaiAllData = JSON.parse(
  fs.readFileSync(
    new URL('../data/tenpai/all.json', import.meta.url),
  ),
);

const machi1 = [];
const machi2 = [];
const machi3 = [];
const machi4 = [];
const machi5 = [];
const machi6 = [];
const machi7 = [];
const machi8 = [];
const machi9 = [];

tenpaiAllData.forEach((element) => {
  if (element.machi.length === 1) {
    machi1.push(element);
  } else if (element.machi.length === 2) {
    machi2.push(element);
  } else if (element.machi.length === 3) {
    machi3.push(element);
  } else if (element.machi.length === 4) {
    machi4.push(element);
  } else if (element.machi.length === 5) {
    machi5.push(element);
  } else if (element.machi.length === 6) {
    machi6.push(element);
  } else if (element.machi.length === 7) {
    machi7.push(element);
  } else if (element.machi.length === 8) {
    machi8.push(element);
  } else if (element.machi.length === 9) {
    machi9.push(element);
  }
});

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-1.json', JSON.stringify(machi1, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-2.json', JSON.stringify(machi2, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-3.json', JSON.stringify(machi3, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-4.json', JSON.stringify(machi4, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-5.json', JSON.stringify(machi5, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-6.json', JSON.stringify(machi6, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-7.json', JSON.stringify(machi7, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-8.json', JSON.stringify(machi8, null, '  '));
} catch (e) {
  alert(e.message);
}

try {
  fs.writeFileSync('./src/data/tenpai/machi/count-9.json', JSON.stringify(machi9, null, '  '));
} catch (e) {
  alert(e.message);
}
