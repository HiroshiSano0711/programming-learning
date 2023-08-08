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

	filterByHaishi(regex) {
		this._filteredData = this._tenpaiAllData.filter((data) => data.haishi.match(regex))
		return this._filteredData
	}

	filterByMachiCount(count) {
		this._filteredData = this._tenpaiAllData.filter((data) => data.machi.length === count)
		return this._filteredData
	}

	filterByMachiPattern(pattern) {
		this._filteredData = this._tenpaiAllData.filter((data) => JSON.stringify(data.machi) == JSON.stringify(pattern))
		return this._filteredData
	}
}
