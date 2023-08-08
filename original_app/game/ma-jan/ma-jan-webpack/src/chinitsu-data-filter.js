import shanten_1_all_data from "./data/shanten_1/all.json" assert { type: "json" };
import shanten_2_all_data from "./data/shanten_2/all.json" assert { type: "json" };
import tenpai_all_data from "./data/tenpai/all.json" assert { type: "json" };

export class ChinitsuDataFilter {
	filterByHaishi(regex) {
		return tenpai_all_data.filter((data) => data.haishi.match(regex))
	}

	filterByMachiCount(count) {
		return tenpai_all_data.filter((data) => data.machi.length === count)
	}

	filterByMachiPattern(pattern) {
		return tenpai_all_data.filter((data) => JSON.stringify(data.machi) == JSON.stringify(pattern))
	}
}
