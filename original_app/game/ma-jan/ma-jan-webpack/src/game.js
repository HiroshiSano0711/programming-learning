import { ChinitsuDataFilter } from './chinitsu-data-filter.js';
import { removeAllChildNodes, filterCheckedElements } from './common.js';
import { paigaStyleList, paigaStyleIndex, createPaigaParentNode, createPaigaElements } from './paiga.js';

window.addEventListener('DOMContentLoaded', () => {
  const chinitsuDataFilter = new ChinitsuDataFilter();
  const displayDom = document.getElementById('js-chinitsu-quiz');
  const startBtn = document.getElementById('js-quiz-start-btn');
  const answerDom = document.getElementById('js-quiz-answer');
  const resultDom = document.getElementById('js-quiz-result');
  const answerForm = document.answer_checkbox_form
  const answerBtn = document.getElementById('js-answer-btn');

  const paigaStyleSelectForm = document.paiga_style_select_form;
  const paigaStyle = paigaStyleSelectForm.paiga_style;
  let styleValue = paigaStyle.value;

  let currentQuiz = null;

  function displayPaiga() {
    const fragment = new DocumentFragment();
    const parent = createPaigaParentNode();
    const child = createPaigaElements(currentQuiz.haishi.split('', 13), styleValue);
    parent.appendChild(child);
    fragment.append(parent);
    displayDom.append(fragment);
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
      parent.append(createPaigaElements([index]));
      fragment.append(parent)
    }
    answerDom.append(fragment);
  }

  function setCurrentQuiz(data) {
    const randomIndex = Math.floor(Math.random() * data.length);
    currentQuiz = data[randomIndex];
  }

  function formValuesToParams() {
     const checkedShantenCount = filterCheckedElements(document.shanten_form.shanten);
     const shantenCountValues = checkedShantenCount.map((element) => element.value);

     const checkedMachiCount = filterCheckedElements(document.machi_count_form.machi_count);
     const machiCountValues = checkedMachiCount.map((element) => element.value);

     const checkedKankoCount = filterCheckedElements(document.kanko_count_form.kanko_count);
     const kankoCountValues = checkedKankoCount.map((element) => element.value);
     const params = {
       shantenCount: shantenCountValues,
       machiCount: machiCountValues,
       kankoCount: kankoCountValues
     }
     return params;
  }

  paigaStyle.addEventListener('change', (event) => {
    styleValue = event.target.value;
  });

  startBtn.addEventListener('click', () => {
    removeAllChildNodes(displayDom);
    removeAllChildNodes(answerDom);
    removeAllChildNodes(resultDom);
    resultDom.classList.remove('p-result-mistake');
    resultDom.classList.remove('p-result-correct');

    const data = chinitsuDataFilter.filterByQuizSettings(formValuesToParams())
    setCurrentQuiz(data)
    displayPaiga();
    createAnswerNodes();
  });

  function displayQuizResult(answerValues) {
    if(JSON.stringify(currentQuiz.machi) === JSON.stringify(answerValues)) {
      resultDom.classList.add('p-result-correct');
      const text = document.createElement('span');
      text.classList.add('p-result__correct-text');
      text.textContent = '正解';
      const circle = document.createElement('span');
      circle.classList.add('p-result__circle');
      resultDom.append(text);
      resultDom.append(circle);
    } else {
      resultDom.classList.add('p-result-mistake');
      const text = document.createElement('div');
      text.classList.add('p-result__batsu');
      text.textContent = 'x';
      resultDom.append(text);
      if(currentQuiz.machi.length !== 0) {
        const machi_kotae = createPaigaElements(currentQuiz.machi, styleValue)
        resultDom.append(machi_kotae);
      } else {
        const text = document.createElement('span');
        text.classList.add('p-result__correct-text');
        text.textContent = 'ノーテン';
        resultDom.append(text);
      }
    }
  }

  // 回答結果を表示
  answerBtn.addEventListener('click', () => {
    if(!currentQuiz) return;

    removeAllChildNodes(resultDom);
    resultDom.classList.remove('p-result-mistake');
    resultDom.classList.remove('p-result-correct');

    const checkedMachi = filterCheckedElements(answerForm.answer_checkbox);
    const checkedMachiValues = checkedMachi.map((element) => element.value);
    displayQuizResult(checkedMachiValues);
  });
});
