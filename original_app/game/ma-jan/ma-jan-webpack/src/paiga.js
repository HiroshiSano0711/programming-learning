export const paigaStyleList = [
  { No: 0, paiName: '赤五万', cssSprite: 'man-0' },
  { No: 1, paiName: '一万', cssSprite: 'man-1' },
  { No: 2, paiName: '二万', cssSprite: 'man-2' },
  { No: 3, paiName: '三万', cssSprite: 'man-3' },
  { No: 4, paiName: '四万', cssSprite: 'man-4' },
  { No: 5, paiName: '五万', cssSprite: 'man-5' },
  { No: 6, paiName: '六万', cssSprite: 'man-6' },
  { No: 7, paiName: '七万', cssSprite: 'man-7' },
  { No: 8, paiName: '八万', cssSprite: 'man-8' },
  { No: 9, paiName: '九万', cssSprite: 'man-9' },

  { No: 10, paiName: '赤五筒', cssSprite: 'pin-0' },
  { No: 11, paiName: '一筒', cssSprite: 'pin-1' },
  { No: 12, paiName: '二筒', cssSprite: 'pin-2' },
  { No: 13, paiName: '三筒', cssSprite: 'pin-3' },
  { No: 14, paiName: '四筒', cssSprite: 'pin-4' },
  { No: 15, paiName: '五筒', cssSprite: 'pin-5' },
  { No: 16, paiName: '六筒', cssSprite: 'pin-6' },
  { No: 17, paiName: '七筒', cssSprite: 'pin-7' },
  { No: 18, paiName: '八筒', cssSprite: 'pin-8' },
  { No: 19, paiName: '九筒', cssSprite: 'pin-9' },

  { No: 20, paiName: '赤五索', cssSprite: 'sou-0' },
  { No: 21, paiName: '一索', cssSprite: 'sou-1' },
  { No: 22, paiName: '二索', cssSprite: 'sou-2' },
  { No: 23, paiName: '三索', cssSprite: 'sou-3' },
  { No: 24, paiName: '四索', cssSprite: 'sou-4' },
  { No: 25, paiName: '五索', cssSprite: 'sou-5' },
  { No: 26, paiName: '六索', cssSprite: 'sou-6' },
  { No: 27, paiName: '七索', cssSprite: 'sou-7' },
  { No: 28, paiName: '八索', cssSprite: 'sou-8' },
  { No: 29, paiName: '九索', cssSprite: 'sou-9' },

  { No: 30, paiName: '裏', cssSprite: 'ji-0' },
  { No: 31, paiName: '東', cssSprite: 'ji-1' },
  { No: 32, paiName: '南', cssSprite: 'ji-2' },
  { No: 33, paiName: '西', cssSprite: 'ji-3' },
  { No: 34, paiName: '北', cssSprite: 'ji-4' },
  { No: 35, paiName: '白', cssSprite: 'ji-5' },
  { No: 36, paiName: '發', cssSprite: 'ji-6' },
  { No: 37, paiName: '中', cssSprite: 'ji-7' },
];

export function paigaStyleIndex(value) {
  if (value === 'pin') {
    return 10;
  } if (value === 'sou') {
    return 20;
  }
  return 0;
}

export function createPaigaParentNode() {
  const parent = document.createElement('div');
  parent.classList.add('l-flex', 'l-flex--wrap', 'l-flex--gap', 'l-flex-content', 'u-border-btm');
  return parent;
}

// 数字文字列の配列を引数で渡す。例：['1', '2', '3']
export function createPaigaElements(paiStringArr, styleValue) {
  const childPaiga = document.createElement('div');
  childPaiga.classList.add('l-flex');

  for (const paiString of paiStringArr) {
    const paiga = document.createElement('span');
    paiga.classList.add(paigaStyleList[Number(paiString) + paigaStyleIndex(styleValue)].cssSprite, 'p-paiga', 'p-pai-size');
    childPaiga.appendChild(paiga);
  }
  return childPaiga;
}
