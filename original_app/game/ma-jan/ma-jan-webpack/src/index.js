import { ChinitsuDataFilter } from "./chinitsu-data-filter.js";
import { Pagination } from "./pagination.js";
import { paigaStyleList, paigaStyleIndex } from "./paiga-style-list.js";

window.addEventListener("DOMContentLoaded", function() {
	const chinitsuDataFilter = new ChinitsuDataFilter
	const pagination = new Pagination

	const displayDom = document.getElementById("js-chinitsu-list")

	/** 一覧表示 */
	const shantenListSelectForm = document.shanten_list_select_form

	shantenListSelectForm.addEventListener("click", () => {
		pagination.initCurrentPage()
		removeAllChildNodes(displayDom)

		const count = Number(shantenListSelectForm.shanten_count.value)
		const data = chinitsuDataFilter.filterByShantenCount(count)
		displayPaiga(data)
		displaySearchResultText(data.length)
	})

	const machiCountSelectForm = document.machi_count_select_form
	const machiCountSelectBtn = document.getElementById("js-machi-count-select-btn")

	machiCountSelectBtn.addEventListener("click", () => {
		pagination.initCurrentPage()
		removeAllChildNodes(displayDom)

		const count = Number(machiCountSelectForm.machi_count.value)
		const data = chinitsuDataFilter.filterByMachiCount(count)
		displayPaiga(data)
		displaySearchResultText(data.length)
	})

	/** 検索処理。AND検索 */
	const searchBtn = document.getElementById("js-search-btn")
	const machiPatternSearchForm = document.machi_pattern_search_form
	const tehaiTextForm = document.getElementById("js-tehai-search-input")
	const shantenSelectForm = document.shanten_search_form

	searchBtn.addEventListener("click", () => {
		removeAllChildNodes(displayDom)
		pagination.initCurrentPage()
		chinitsuDataFilter.initFilterData()

		const searchParams = searchFormValueToParams()
		const pattern = tehaiTextForm.value
		if(pattern && pattern.match(/[1-9]{1,13}/)) {
			searchParams.haishiPattern = pattern
		}
		const data = chinitsuDataFilter.filterBySearchParams(searchParams)
		displayPaiga(data);
		displaySearchResultText(data.length)
	})

	function searchFormValueToParams() {
		const checkedElements = correctCheckedElements(shantenSelectForm.shanten_search_radio)
		const shantenValue = Number(checkedElements[0].value)
		const checkedMachi = correctCheckedElements(machiPatternSearchForm.machi)
		const checkedMachiValues = checkedMachi.map((element) => element.value)
		const params = {
			shantenCount: shantenValue,
			machiPattern: checkedMachiValues
		}
		return params
	}

	function correctCheckedElements(radioBtnOrCheckBox) {
		return Array.prototype.filter.call(radioBtnOrCheckBox, (element) => element.checked)
	}

	/** ページネーション */
	const prevBtn = document.getElementById("js-pagination-btn-prev")
	const nextBtn = document.getElementById("js-pagination-btn-next")

	prevBtn.addEventListener("click", () => {
		if(pagination.currentPage === 0) return
		pagination.decrementCurrentPage()
		removeAllChildNodes(displayDom)
		displayPaiga(chinitsuDataFilter.filteredData)
	})

	nextBtn.addEventListener("click", () => {
		if(pagination.endIndex() >= chinitsuDataFilter.filteredData.length) return
		pagination.incrementCurrentPage()
		removeAllChildNodes(displayDom)
		displayPaiga(chinitsuDataFilter.filteredData)
	})

	function pageTextEndNumber() {
		if(pagination.endIndex() <= chinitsuDataFilter.filteredData.length) {
			return pagination.endIndex()
		} else {
			return chinitsuDataFilter.filteredData.length
		}
	}

	// 牌画表示
	const paigaStyleSelectForm = document.paiga_style_select_form
	const paigaStyle = paigaStyleSelectForm.paiga_style
	let styleValue = paigaStyle.value

	paigaStyle.addEventListener("change", (event) => {
		styleValue = event.target.value
	})

	function displayPaiga(data){
		const fragment = new DocumentFragment()

		data.slice(pagination.startIndex(), pagination.endIndex()).forEach((d) => fragment.append(createPaigaNodes(d)))
		const paginationRange = document.getElementById("js-pagination-range")
		paginationRange.textContent = `${pagination.startIndex()+ 1}~${pageTextEndNumber()}件目を表示中`;

		displayDom.append(fragment)
	}

	const searchResult = document.getElementById("js-search-result")
	function displaySearchResultText(count) {
		if (count !== 0) {
			searchResult.textContent = `${count}件ヒットしました`;
		} else {
			searchResult.textContent = "検索結果はありません。違う待ちをお試しください。";
		}
	}

	function createPaigaElements(pai_string_arr) {
		let childPaiga = document.createElement("div")
		childPaiga.className = "content-item"

		for (const pai_string of pai_string_arr) {
			let paiga = document.createElement("span")
			paiga.classList.add(paigaStyleList[Number(pai_string) + paigaStyleIndex(styleValue)].cssSprite , "paiga", "pai-size")
			childPaiga.appendChild(paiga)
		}
		return childPaiga
	}

	function createPaigaNodes(element){
		const parent = document.createElement("div")
		parent.classList.add("content-flex", "border-btm")

		const childHaishi = createPaigaElements(element.haishi.split("",13))
		parent.appendChild(childHaishi);

		if(element.shanten === 0) {
			const childMachi = createPaigaElements(element.machi)
			parent.appendChild(childMachi);
		}
		return parent;
	}

	function removeAllChildNodes(parent) {
    while (parent.firstChild) {
      parent.removeChild(parent.firstChild);
    }
	}
});
