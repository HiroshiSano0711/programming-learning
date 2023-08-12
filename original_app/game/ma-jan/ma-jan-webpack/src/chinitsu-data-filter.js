import allData from "./data/all.json" assert { type: "json" };

export class ChinitsuDataFilter {
	#allData = allData;
	constructor(){
		this._filteredData = null;
	}

	get filteredData() {
    return this._filteredData;
  }

	get allData() {
    return this.#allData;
  }

	initFilterData() {
		this._filteredData = null;
	}

	// 一覧表示用
	filterByMachiCount(count) {
		this._filteredData = this.#allData.filter((data) => data.machi.length === count)
		return this._filteredData
	}

	filterByShantenCount(value) {
		this._filteredData = this.#allData.filter((data) => data.shanten === value)
		return this._filteredData
	}

	// AND検索用 まずシャンテン数でフィルターしてそこから各条件で絞っていく
	filterBySearchParams(params) {
		if (params.shantenCount !== undefined || params.shantenCount !== null) {
			this.filterByShantenCount(params.shantenCount)
		} else {
			this._filteredData = this.#allData
		}
		this.filterByHaishi(params.haishiPattern)
		this.filterByMachiPattern(params.machiPattern)
		return this._filteredData
	}

	filterByHaishi(pattern) {
		if(!pattern) return;

		const multiRegex = this.multiRegexCondition(pattern)
		this._filteredData = this._filteredData.filter((data) => {
			for (let regex of multiRegex) {
				if (!(data.haishi.match(regex))) {
					return false;
				}
			}
			return true;
		})
	}

	filterByMachiPattern(pattern) {
		if(pattern.length === 0) return;

		this._filteredData = this._filteredData.filter((data) => JSON.stringify(data.machi) == JSON.stringify(pattern))
	}

	multiRegexCondition(pattern) {
		const patterns = []
		for (let index = 1; index <= 9; index++) {
			patterns.push({
				number: index,
				count: (pattern.match(new RegExp(String(index), "g")) || []).length
			})
		}

		const patternCounts = patterns.filter((pattern) => pattern.count !== 0)
		const multiRegexCondition = patternCounts.map((patternCount) => {
			return new RegExp(String(patternCount.number).repeat(patternCount.count), "g")
		})
		return multiRegexCondition
	}

	// クイズの設定からフィルター
	filterByQuizSettings(params) {
		if(params.shantenCount.length === 0) return this.#allData;

		this._filteredData = this.#allData.filter((data) => {
			if(!params.shantenCount.includes(String(data.shanten))) return false;
			if(data.shanten === 0 && params.machiCount.length !== 0 && !params.machiCount.includes(String(data.machi.length))) return false;
			if(params.kankoCount.length !== 0 && !params.kankoCount.includes(String(data.kanko_count))) return false;
			return true;
		})
		return this._filteredData;
	}
}
