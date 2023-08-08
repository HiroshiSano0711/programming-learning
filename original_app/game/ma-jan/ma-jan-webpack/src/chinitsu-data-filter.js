import shanten1AllData from "./data/shanten_1/all.json" assert { type: "json" };
import shanten2AllData from "./data/shanten_2/all.json" assert { type: "json" };
import tenpaiAllData from "./data/tenpai/all.json" assert { type: "json" };

export class ChinitsuDataFilter {
	constructor(){
		this._tenpaiAllData = tenpaiAllData;
		this._shanten1AllData = shanten1AllData;
		this._shanten2AllData = shanten2AllData;
		this._filteredData = null;
	}

	get filteredData() {
    return this._filteredData
  }

	initFilterData() {
		this._filteredData = null;
	}

	// 一覧表示用
	filterByMachiCount(count) {
		this._filteredData = this._tenpaiAllData.filter((data) => data.machi.length === count)
		return this._filteredData
	}

	filterByShantenCount(value) {
		if(value == 1) {
			this._filteredData = this._shanten1AllData
		} else if(value == 2) {
			this._filteredData = this._shanten2AllData
		} else {
			this._filteredData = this._tenpaiAllData
		}
		return this._filteredData
	}

	// AND検索用
	filterBySearchParams(params) {
		if (params.shantenCount) {
			this.filterByShantenCount(params.shantenCount)
		} else {
			this._filteredData = this._tenpaiAllData
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
				index: index,
				count: (pattern.match(new RegExp(String(index), "g")) || []).length
			})
		}

		const patternCounts = patterns.filter((pattern) => pattern.count !== 0)
		const multiRegexCondition = patternCounts.map((patternCount) => {
			return new RegExp(String(patternCount.index).repeat(patternCount.count), "g")
		})
		return multiRegexCondition
	}
}
