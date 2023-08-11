import { ChinitsuDataFilter } from './chinitsu-data-filter.js';
import { paigaStyleList, paigaStyleIndex } from './paiga-style-list.js';
import { removeAllChildNodes, correctCheckedElements } from './common.js';

window.addEventListener('DOMContentLoaded', () => {
  const chinitsuDataFilter = new ChinitsuDataFilter();
  const displayDom = document.getElementById('js-chinitsu-quiz');
  const startBtn = document.getElementById('js-start-btn');
  const answerDom = document.getElementById('js-quiz-answer');
  const resultDom = document.getElementById('js-quiz-result');
  const answerForm = document.answer_checkbox_form
  const answerBtn = document.getElementById('js-answer-btn');

  const paigaStyleSelectForm = document.paiga_style_select_form;
  const paigaStyle = paigaStyleSelectForm.paiga_style;
  let styleValue = paigaStyle.value;

  let currentQuiz = null;

  function createPaigaParentNode() {
    const parent = document.createElement('div');
    parent.classList.add('l-flex', 'l-flex--wrap', 'l-flex--gap', 'l-flex-content', 'border-btm');
    return parent;
  }

  function createPaigaNodes(element) {
    const parent = createPaigaParentNode();
    const childHaishi = createPaigaElements(element.haishi.split('', 13));
    parent.appendChild(childHaishi);

    return parent;
  }

  function createPaigaElements(paiStringArr) {
    const childPaiga = document.createElement('div');
    childPaiga.className = 'l-flex__item';

    for (const paiString of paiStringArr) {
      const paiga = document.createElement('span');
      paiga.classList.add(paigaStyleList[Number(paiString) + paigaStyleIndex(styleValue)].cssSprite, 'p-paiga', 'p-pai-size');
      childPaiga.appendChild(paiga);
    }
    return childPaiga;
  }

  function createAnswerNodes() {
    const fragment = new DocumentFragment();

    for (let index = 1; index <= 9; index++) {
      const parent = document.createElement('label');
      const input = document.createElement('input');
      input.setAttribute('type', 'checkbox');
      input.setAttribute('name', 'answer_checkbox');
      input.setAttribute('value', index);
      parent.append(input);
      const paiga = document.createElement('span');
      paiga.classList.add(paigaStyleList[index + paigaStyleIndex(styleValue)].cssSprite, 'p-paiga', 'p-pai-size');
      parent.append(paiga);
      fragment.append(parent)
    }
    answerDom.append(fragment);
  }

  function displayPaiga(data) {
    const fragment = new DocumentFragment();

    // 同じ問題は出題したくないので、出題済みの配列は削除したい
    const randomIndex = Math.floor(Math.random() * data.length);
    currentQuiz = data[randomIndex];
    fragment.append(createPaigaNodes(data[randomIndex]));
    displayDom.append(fragment);
  }

  paigaStyle.addEventListener('change', (event) => {
    styleValue = event.target.value;
  });

  startBtn.addEventListener('click', () => {
    removeAllChildNodes(displayDom);
    removeAllChildNodes(answerDom);
    removeAllChildNodes(resultDom);

    // 設定のパラメーターから出題するデータをフィルターする

    // 出題する
    displayPaiga(chinitsuDataFilter.filterByShantenCount(0));
    createAnswerNodes();
  });

  answerBtn.addEventListener('click', () => {
    const checkedMachi = correctCheckedElements(answerForm.answer_checkbox);
    const checkedMachiValues = checkedMachi.map((element) => element.value);
    if(JSON.stringify(currentQuiz.machi) === JSON.stringify(checkedMachiValues)) {
      resultDom.textContent = '正解';
    } else {
      if(currentQuiz.machi.length !== 0) {
        const machi_kotae = createPaigaElements(currentQuiz.machi)
        resultDom.textContent = '間違い。正解は';
        resultDom.append(machi_kotae);
      } else {
        resultDom.textContent = '間違い。待ちはありません。（ノーテン形）';
      }
    };
  });
});
