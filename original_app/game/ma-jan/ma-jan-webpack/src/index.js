import { ChinitsuDataFilter } from './chinitsu-data-filter.js';
import { Pagination } from './pagination.js';
import { paigaStyleList, paigaStyleIndex } from './paiga-style-list.js';

window.addEventListener('DOMContentLoaded', () => {
  const chinitsuDataFilter = new ChinitsuDataFilter();
  const pagination = new Pagination();

  const displayDom = document.getElementById('js-chinitsu-list');
  const searchResult = document.getElementById('js-search-result');

  const paigaStyleSelectForm = document.paiga_style_select_form;
  const paigaStyle = paigaStyleSelectForm.paiga_style;
  let styleValue = paigaStyle.value;

	const machiCountSelectBtn = document.getElementById('js-machi-count-select-btn');
  const machiCountSelectForm = document.machi_count_select_form;
  const shantenListSelectForm = document.shanten_list_select_form;

	const searchBtn = document.getElementById('js-search-btn');
  const tehaiTextForm = document.getElementById('js-tehai-search-input');
  const shantenSelectForm = document.shanten_search_form;
	const machiPatternSearchForm = document.machi_pattern_search_form;

  function removeAllChildNodes(parent) {
    while (parent.firstChild) {
      parent.removeChild(parent.firstChild);
    }
  }

  function correctCheckedElements(radioBtnOrCheckBox) {
    return Array.prototype.filter.call(radioBtnOrCheckBox, (element) => element.checked);
  }

  function pageTextEndNumber() {
    if (pagination.endIndex() <= chinitsuDataFilter.filteredData.length) {
      return pagination.endIndex();
    }
    return chinitsuDataFilter.filteredData.length;
  }

  function createPaigaElements(paiStringArr) {
    const childPaiga = document.createElement('div');
    childPaiga.className = 'l-flex__item';

    for (const paiString of paiStringArr) {
      const paiga = document.createElement('span');
      paiga.classList.add(paigaStyleList[Number(paiString) + paigaStyleIndex(styleValue)].cssSprite, 'paiga', 'pai-size');
      childPaiga.appendChild(paiga);
    }
    return childPaiga;
  }

  function createPaigaNodes(element) {
    const parent = document.createElement('div');
    parent.classList.add('l-flex', 'l-flex--wrap', 'l-flex--gap', 'l-flex-content', 'border-btm');

    const childHaishi = createPaigaElements(element.haishi.split('', 13));
    parent.appendChild(childHaishi);

    if (element.shanten === 0) {
      const childMachi = createPaigaElements(element.machi);
      parent.appendChild(childMachi);
    }
    return parent;
  }

  function displayPaiga(data) {
    const fragment = new DocumentFragment();

    data.slice(pagination.startIndex(), pagination.endIndex()).forEach((d) => fragment.append(createPaigaNodes(d)));
    const paginationRange = document.getElementById('js-pagination-range');
    paginationRange.textContent = `${pagination.startIndex() + 1}~${pageTextEndNumber()}件目を表示中`;

    displayDom.append(fragment);
  }

  function displaySearchResultText(count) {
    if (count !== 0) {
      searchResult.textContent = `${count}件ヒットしました`;
    } else {
      searchResult.textContent = '検索結果はありません。違う待ちをお試しください。';
    }
  }

  function searchFormValueToParams() {
    const checkedElements = correctCheckedElements(shantenSelectForm.shanten_search_radio);
    const shantenValue = Number(checkedElements[0].value);
    const checkedMachi = correctCheckedElements(machiPatternSearchForm.machi);
    const checkedMachiValues = checkedMachi.map((element) => element.value);
    const params = {
      shantenCount: shantenValue,
      machiPattern: checkedMachiValues,
    };
    return params;
  }

  /** ページネーション */
  const prevBtn = document.getElementById('js-pagination-btn-prev');
  const nextBtn = document.getElementById('js-pagination-btn-next');

  prevBtn.addEventListener('click', () => {
    if (pagination.currentPage === 0) return;
    pagination.decrementCurrentPage();
    removeAllChildNodes(displayDom);
    displayPaiga(chinitsuDataFilter.filteredData);
  });

  nextBtn.addEventListener('click', () => {
    if (pagination.endIndex() >= chinitsuDataFilter.filteredData.length) return;
    pagination.incrementCurrentPage();
    removeAllChildNodes(displayDom);
    displayPaiga(chinitsuDataFilter.filteredData);
  });

  paigaStyle.addEventListener('change', (event) => {
    styleValue = event.target.value;
  });

	/** 一覧表示 */
	shantenListSelectForm.addEventListener('click', () => {
    pagination.initCurrentPage();
    removeAllChildNodes(displayDom);

    const count = Number(shantenListSelectForm.shanten_count.value);
    const data = chinitsuDataFilter.filterByShantenCount(count);
    displayPaiga(data);
    displaySearchResultText(data.length);
  });

  machiCountSelectBtn.addEventListener('click', () => {
    pagination.initCurrentPage();
    removeAllChildNodes(displayDom);

    const count = Number(machiCountSelectForm.machi_count.value);
    const data = chinitsuDataFilter.filterByMachiCount(count);
    displayPaiga(data);
    displaySearchResultText(data.length);
  });

  /** 検索処理。AND検索 */
  searchBtn.addEventListener('click', () => {
    removeAllChildNodes(displayDom);
    pagination.initCurrentPage();
    chinitsuDataFilter.initFilterData();

    const searchParams = searchFormValueToParams();
    const pattern = tehaiTextForm.value;
    if (pattern && pattern.match(/[1-9]{1,13}/)) {
      searchParams.haishiPattern = pattern;
    }
    const data = chinitsuDataFilter.filterBySearchParams(searchParams);
    displayPaiga(data);
    displaySearchResultText(data.length);
  });
});
