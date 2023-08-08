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

	filterByHaishi(pattern, shanten) {
		let targetData = this._tenpaiAllData
		if (shanten === 0) {
			targetData = this._tenpaiAllData
		} else if (shanten === 1) {
			targetData = this._shanten1AllData
		} else if (shanten === 2) {
			targetData = this._shanten2AllData
		}

		const multiRegex = this.multiRegexCondition(pattern)
		this._filteredData = targetData.filter((data) => {
			for (let regex of multiRegex) {
				if (!(data.haishi.match(regex))) {
					return false;
				}
			}
			return true;
		})
		return this._filteredData
	}

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

	filterByMachiPattern(pattern) {
		this._filteredData = this._tenpaiAllData.filter((data) => JSON.stringify(data.machi) == JSON.stringify(pattern))
		return this._filteredData
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
