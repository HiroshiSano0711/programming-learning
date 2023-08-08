import { ChinitsuDataFilter } from "./chinitsu-data-filter.js";
import { paigaStyleList } from "./paiga-style-list.js";

window.addEventListener("DOMContentLoaded", function() {
	const chinitsuDataFilter = new ChinitsuDataFilter

	const displayDom = document.getElementById("chinitsu_pattern")
	const searchResult = document.getElementById("search_result")
	const machiPatternSearchBtn = document.getElementById("machi_pattern_search_btn")
	const machiCountSelectBtn = document.getElementById("machi_count_select_btn")
	const tehaiSearchBtn = document.getElementById("tehai_search_btn")

	const machiPatternSearchForm = document.machi_pattern_search_form
	const tehaiSearchInputForm = document.tehai_search_input_form
	const machiCountSelectForm = document.machi_count_select_form
	const paigaStyleSelectForm = document.paiga_style_select_form
	const paigaStyle = paigaStyleSelectForm.paiga_style
	let styleValue = paigaStyle.value

	paigaStyle.addEventListener("change", (event) => {
		styleValue = event.target.value
	})

	machiPatternSearchBtn.addEventListener("click", (event) => {
		removeAllChildNodes(displayDom)

		const checkedElements = Array.prototype.filter.call(machiPatternSearchForm.machi, (element) => element.checked)
		const checkedValues = checkedElements.map((element) => element.value)
		const data = chinitsuDataFilter.filterByMachiPattern(checkedValues)
		displayPaiga(data)
		displaySearchResultText(data.length)
	})

	machiCountSelectBtn.addEventListener("click", (event) => {
		removeAllChildNodes(displayDom)
		const count = Number(machiCountSelectForm.machi_count.value)
		const data = chinitsuDataFilter.filterByMachiCount(count)
		displayPaiga(data)
		displaySearchResultText(data.length)
	})

	tehaiSearchBtn.addEventListener("click", (event) => {
		removeAllChildNodes(displayDom)
		const pattern = tehaiSearchInputForm.tehai_search_input.value

		if(pattern && pattern.match(/[1-9]{1,13}/)) {
			const data = chinitsuDataFilter.filterByHaishi(stringToRegexp(pattern))
			displayPaiga(data);
			displaySearchResultText(data.length)
		}
	})

	function paigaStyleIndex() {
		if (styleValue === 'pin') {
			return 10
		} else if (styleValue === 'sou') {
			return 20
		}
		return 0
	}

	function stringToRegexp(string) {
		return new RegExp(string,"g")
	}

	function displayPaiga(data){
		const fragment = new DocumentFragment()
		data.forEach((d) => fragment.append(createPaigaNodes(d)))

		displayDom.append(fragment)
	}

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
			paiga.classList.add(paigaStyleList[Number(pai_string) + paigaStyleIndex()].cssSprite , "paiga", "pai-size")
			childPaiga.appendChild(paiga)
		}
		return childPaiga
	}

	function createPaigaNodes(element){
		const parent = document.createElement("div")
		parent.classList.add("content-flex", "border-btm")

		const childHaishi = createPaigaElements(element.haishi.split("",13))
		const childMachi = createPaigaElements(element.machi)

		parent.appendChild(childHaishi);
		parent.appendChild(childMachi);

		return parent;
	}

	function removeAllChildNodes(parent) {
    while (parent.firstChild) {
      parent.removeChild(parent.firstChild);
    }
	}
});
