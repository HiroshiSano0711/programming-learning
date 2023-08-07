const pai_type = [
	{"No":0,"paiName":"赤五万","cssSprite":"man-0"},
	{"No":1,"paiName":"一万","cssSprite":"man-1"},
	{"No":2,"paiName":"二万","cssSprite":"man-2"},
	{"No":3,"paiName":"三万","cssSprite":"man-3"},
	{"No":4,"paiName":"四万","cssSprite":"man-4"},
	{"No":5,"paiName":"五万","cssSprite":"man-5"},
	{"No":6,"paiName":"六万","cssSprite":"man-6"},
	{"No":7,"paiName":"七万","cssSprite":"man-7"},
	{"No":8,"paiName":"八万","cssSprite":"man-8"},
	{"No":9,"paiName":"九万","cssSprite":"man-9"},

	{"No":10,"paiName":"赤五筒","cssSprite":"pin-0"},
	{"No":11,"paiName":"一筒","cssSprite":"pin-1"},
	{"No":12,"paiName":"二筒","cssSprite":"pin-2"},
	{"No":13,"paiName":"三筒","cssSprite":"pin-3"},
	{"No":14,"paiName":"四筒","cssSprite":"pin-4"},
	{"No":15,"paiName":"五筒","cssSprite":"pin-5"},
	{"No":16,"paiName":"六筒","cssSprite":"pin-6"},
	{"No":17,"paiName":"七筒","cssSprite":"pin-7"},
	{"No":18,"paiName":"八筒","cssSprite":"pin-8"},
	{"No":19,"paiName":"九筒","cssSprite":"pin-9"},

	{"No":20,"paiName":"赤五索","cssSprite":"sou-0"},
	{"No":21,"paiName":"一索","cssSprite":"sou-1"},
	{"No":22,"paiName":"二索","cssSprite":"sou-2"},
	{"No":23,"paiName":"三索","cssSprite":"sou-3"},
	{"No":24,"paiName":"四索","cssSprite":"sou-4"},
	{"No":25,"paiName":"五索","cssSprite":"sou-5"},
	{"No":26,"paiName":"六索","cssSprite":"sou-6"},
	{"No":27,"paiName":"七索","cssSprite":"sou-7"},
	{"No":28,"paiName":"八索","cssSprite":"sou-8"},
	{"No":29,"paiName":"九索","cssSprite":"sou-9"},

	{"No":30,"paiName":"裏","cssSprite":"ji-0"},
	{"No":31,"paiName":"東","cssSprite":"ji-1"},
	{"No":32,"paiName":"南","cssSprite":"ji-2"},
	{"No":33,"paiName":"西","cssSprite":"ji-3"},
	{"No":34,"paiName":"北","cssSprite":"ji-4"},
	{"No":35,"paiName":"白","cssSprite":"ji-5"},
	{"No":36,"paiName":"發","cssSprite":"ji-6"},
	{"No":37,"paiName":"中","cssSprite":"ji-7"}
];

import tenpai_all from "./data/tenpai/all.json" assert { type: "json" };

window.addEventListener("DOMContentLoaded", function() {
	const display_dom = document.getElementById("chinitsu_pattern")
	const machi_search_btn = document.getElementById("machi_search_btn")
	const machi_count_select_btn = document.getElementById("machi_count_select_btn")
	const search_form = document.search_form
	const machi_count_select_form = document.machi_count_select_form
	const paiga_style_select_form = document.paiga_style_select_form
	const paiga_style = paiga_style_select_form.paiga_style
	let style_value = paiga_style.value

	paiga_style.addEventListener("change", (event) => {
		style_value = event.target.value
	})
	machi_search_btn.addEventListener("click", (event) => {
		const checked_values = []
		search_form.machi.forEach(element =>{
			if(element.checked){
				checked_values.push(element.value)
			}
		})
		display_pattern_by_machi(checked_values)
	})

	machi_count_select_btn.addEventListener("click", (event) => {
		display_pattern_by_machi_count(Number(machi_count_select_form.machi_count.value))
	})

	function paiga_style_index() {
		if (style_value === 'pin') {
			return 10;
		} else if (style_value === 'sou') {
			return 20;
		}
		return 0;
	}

	function display_pattern_by_machi_count(machi_count){
		let count = 0

		remove_all_child_nodes(display_dom)

		tenpai_all.forEach(element =>{
			if(element.machi.length === machi_count){
				count += 1
				display_paiga(display_dom, element)
			}
		})
		let search_result = document.getElementById("search_result");
		if (count !== 0) {
			search_result.textContent = `${count}件ヒットしました`;
		} else {
			search_result.textContent = "検索結果はありません。違う待ちをお試しください。";
		}
	}

	function display_pattern_by_machi(machi){
    let count = 0

		remove_all_child_nodes(display_dom)

		tenpai_all.forEach(element =>{
			if(JSON.stringify(element.machi) == JSON.stringify(machi)){
        count += 1
				display_paiga(display_dom, element)
			}
		})
		let search_result = document.getElementById("search_result");
		if (count !== 0) {
			search_result.textContent = `${count}件ヒットしました`;
		} else {
			search_result.textContent = "検索結果はありません。違う待ちをお試しください。";
		}
	}

	function display_paiga(target_dom, element){
		for (let index = 0; index < 13; index++) {
			let paiga = document.createElement("span")
			paiga.classList.add(pai_type[Number(element.haishi[index]) + paiga_style_index()].cssSprite, "paiga", "pai-size")
			target_dom.appendChild(paiga)
		}
		let span = document.createElement("span")
		span.className = 'machi'
		target_dom.appendChild(span)

		for (let index = 0; index < element.machi.length; index++) {
			let machi = document.createElement("span")
			machi.classList.add(pai_type[Number(element.machi[index]) + paiga_style_index()].cssSprite, "paiga", "pai-size")
			target_dom.appendChild(machi)
		}
		let br = document.createElement("br");
		target_dom.appendChild(br);
	}

	function remove_all_child_nodes(parent) {
    while (parent.firstChild) {
      parent.removeChild(parent.firstChild);
    }
	}
});
