import fs from 'fs';
const all_data = JSON.parse(
  fs.readFileSync(
    new URL('../data/tenpai/all.json', import.meta.url)
    )
);

let all_machi_pattern = {
	"1": [],
	"2": [],
	"3": [],
	"4": [],
	"5": [],
	"6": [],
	"7": [],
	"8": [],
	"9": [],
	"1-2": [],
	"1-3": [],
	"1-4": [],
	"1-5": [],
	"1-6": [],
	"1-7": [],
	"1-8": [],
	"1-9": [],
	"2-3": [],
	"2-4": [],
	"2-5": [],
	"2-6": [],
	"2-7": [],
	"2-8": [],
	"2-9": [],
	"3-4": [],
	"3-5": [],
	"3-6": [],
	"3-7": [],
	"3-8": [],
	"3-9": [],
	"4-5": [],
	"4-6": [],
	"4-7": [],
	"4-8": [],
	"4-9": [],
	"5-6": [],
	"5-7": [],
	"5-8": [],
	"5-9": [],
	"6-7": [],
	"6-8": [],
	"6-9": [],
	"7-8": [],
	"7-9": [],
	"8-9": [],
	"1-2-3": [],
	"1-2-4": [],
	"1-2-5": [],
	"1-2-6": [],
	"1-2-7": [],
	"1-2-8": [],
	"1-2-9": [],
	"1-3-4": [],
	"1-3-5": [],
	"1-3-6": [],
	"1-3-7": [],
	"1-3-8": [],
	"1-3-9": [],
	"1-4-5": [],
	"1-4-6": [],
	"1-4-7": [],
	"1-4-8": [],
	"1-4-9": [],
	"1-5-6": [],
	"1-5-7": [],
	"1-5-8": [],
	"1-5-9": [],
	"1-6-7": [],
	"1-6-8": [],
	"1-6-9": [],
	"1-7-8": [],
	"1-7-9": [],
	"1-8-9": [],
	"2-3-4": [],
	"2-3-5": [],
	"2-3-6": [],
	"2-3-7": [],
	"2-3-8": [],
	"2-3-9": [],
	"2-4-5": [],
	"2-4-6": [],
	"2-4-7": [],
	"2-4-8": [],
	"2-4-9": [],
	"2-5-6": [],
	"2-5-7": [],
	"2-5-8": [],
	"2-5-9": [],
	"2-6-7": [],
	"2-6-8": [],
	"2-6-9": [],
	"2-7-8": [],
	"2-7-9": [],
	"2-8-9": [],
	"3-4-5": [],
	"3-4-6": [],
	"3-4-7": [],
	"3-4-8": [],
	"3-4-9": [],
	"3-5-6": [],
	"3-5-7": [],
	"3-5-8": [],
	"3-5-9": [],
	"3-6-7": [],
	"3-6-8": [],
	"3-6-9": [],
	"3-7-8": [],
	"3-7-9": [],
	"3-8-9": [],
	"4-5-6": [],
	"4-5-7": [],
	"4-5-8": [],
	"4-5-9": [],
	"4-6-7": [],
	"4-6-8": [],
	"4-6-9": [],
	"4-7-8": [],
	"4-7-9": [],
	"4-8-9": [],
	"5-6-7": [],
	"5-6-8": [],
	"5-6-9": [],
	"5-7-8": [],
	"5-7-9": [],
	"5-8-9": [],
	"6-7-8": [],
	"6-7-9": [],
	"6-8-9": [],
	"7-8-9": [],
	"1-2-3-4": [],
	"1-2-3-5": [],
	"1-2-3-6": [],
	"1-2-3-7": [],
	"1-2-3-8": [],
	"1-2-3-9": [],
	"1-2-4-5": [],
	"1-2-4-6": [],
	"1-2-4-7": [],
	"1-2-4-8": [],
	"1-2-4-9": [],
	"1-2-5-6": [],
	"1-2-5-7": [],
	"1-2-5-8": [],
	"1-2-5-9": [],
	"1-2-6-7": [],
	"1-2-6-8": [],
	"1-2-6-9": [],
	"1-2-7-8": [],
	"1-2-7-9": [],
	"1-2-8-9": [],
	"1-3-4-5": [],
	"1-3-4-6": [],
	"1-3-4-7": [],
	"1-3-4-8": [],
	"1-3-4-9": [],
	"1-3-5-6": [],
	"1-3-5-7": [],
	"1-3-5-8": [],
	"1-3-5-9": [],
	"1-3-6-7": [],
	"1-3-6-8": [],
	"1-3-6-9": [],
	"1-3-7-8": [],
	"1-3-7-9": [],
	"1-3-8-9": [],
	"1-4-5-6": [],
	"1-4-5-7": [],
	"1-4-5-8": [],
	"1-4-5-9": [],
	"1-4-6-7": [],
	"1-4-6-8": [],
	"1-4-6-9": [],
	"1-4-7-8": [],
	"1-4-7-9": [],
	"1-4-8-9": [],
	"1-5-6-7": [],
	"1-5-6-8": [],
	"1-5-6-9": [],
	"1-5-7-8": [],
	"1-5-7-9": [],
	"1-5-8-9": [],
	"1-6-7-8": [],
	"1-6-7-9": [],
	"1-6-8-9": [],
	"1-7-8-9": [],
	"2-3-4-5": [],
	"2-3-4-6": [],
	"2-3-4-7": [],
	"2-3-4-8": [],
	"2-3-4-9": [],
	"2-3-5-6": [],
	"2-3-5-7": [],
	"2-3-5-8": [],
	"2-3-5-9": [],
	"2-3-6-7": [],
	"2-3-6-8": [],
	"2-3-6-9": [],
	"2-3-7-8": [],
	"2-3-7-9": [],
	"2-3-8-9": [],
	"2-4-5-6": [],
	"2-4-5-7": [],
	"2-4-5-8": [],
	"2-4-5-9": [],
	"2-4-6-7": [],
	"2-4-6-8": [],
	"2-4-6-9": [],
	"2-4-7-8": [],
	"2-4-7-9": [],
	"2-4-8-9": [],
	"2-5-6-7": [],
	"2-5-6-8": [],
	"2-5-6-9": [],
	"2-5-7-8": [],
	"2-5-7-9": [],
	"2-5-8-9": [],
	"2-6-7-8": [],
	"2-6-7-9": [],
	"2-6-8-9": [],
	"2-7-8-9": [],
	"3-4-5-6": [],
	"3-4-5-7": [],
	"3-4-5-8": [],
	"3-4-5-9": [],
	"3-4-6-7": [],
	"3-4-6-8": [],
	"3-4-6-9": [],
	"3-4-7-8": [],
	"3-4-7-9": [],
	"3-4-8-9": [],
	"3-5-6-7": [],
	"3-5-6-8": [],
	"3-5-6-9": [],
	"3-5-7-8": [],
	"3-5-7-9": [],
	"3-5-8-9": [],
	"3-6-7-8": [],
	"3-6-7-9": [],
	"3-6-8-9": [],
	"3-7-8-9": [],
	"4-5-6-7": [],
	"4-5-6-8": [],
	"4-5-6-9": [],
	"4-5-7-8": [],
	"4-5-7-9": [],
	"4-5-8-9": [],
	"4-6-7-8": [],
	"4-6-7-9": [],
	"4-6-8-9": [],
	"4-7-8-9": [],
	"5-6-7-8": [],
	"5-6-7-9": [],
	"5-6-8-9": [],
	"5-7-8-9": [],
	"6-7-8-9": [],
	"1-2-3-4-5": [],
	"1-2-3-4-6": [],
	"1-2-3-4-7": [],
	"1-2-3-4-8": [],
	"1-2-3-4-9": [],
	"1-2-3-5-6": [],
	"1-2-3-5-7": [],
	"1-2-3-5-8": [],
	"1-2-3-5-9": [],
	"1-2-3-6-7": [],
	"1-2-3-6-8": [],
	"1-2-3-6-9": [],
	"1-2-3-7-8": [],
	"1-2-3-7-9": [],
	"1-2-3-8-9": [],
	"1-2-4-5-6": [],
	"1-2-4-5-7": [],
	"1-2-4-5-8": [],
	"1-2-4-5-9": [],
	"1-2-4-6-7": [],
	"1-2-4-6-8": [],
	"1-2-4-6-9": [],
	"1-2-4-7-8": [],
	"1-2-4-7-9": [],
	"1-2-4-8-9": [],
	"1-2-5-6-7": [],
	"1-2-5-6-8": [],
	"1-2-5-6-9": [],
	"1-2-5-7-8": [],
	"1-2-5-7-9": [],
	"1-2-5-8-9": [],
	"1-2-6-7-8": [],
	"1-2-6-7-9": [],
	"1-2-6-8-9": [],
	"1-2-7-8-9": [],
	"1-3-4-5-6": [],
	"1-3-4-5-7": [],
	"1-3-4-5-8": [],
	"1-3-4-5-9": [],
	"1-3-4-6-7": [],
	"1-3-4-6-8": [],
	"1-3-4-6-9": [],
	"1-3-4-7-8": [],
	"1-3-4-7-9": [],
	"1-3-4-8-9": [],
	"1-3-5-6-7": [],
	"1-3-5-6-8": [],
	"1-3-5-6-9": [],
	"1-3-5-7-8": [],
	"1-3-5-7-9": [],
	"1-3-5-8-9": [],
	"1-3-6-7-8": [],
	"1-3-6-7-9": [],
	"1-3-6-8-9": [],
	"1-3-7-8-9": [],
	"1-4-5-6-7": [],
	"1-4-5-6-8": [],
	"1-4-5-6-9": [],
	"1-4-5-7-8": [],
	"1-4-5-7-9": [],
	"1-4-5-8-9": [],
	"1-4-6-7-8": [],
	"1-4-6-7-9": [],
	"1-4-6-8-9": [],
	"1-4-7-8-9": [],
	"1-5-6-7-8": [],
	"1-5-6-7-9": [],
	"1-5-6-8-9": [],
	"1-5-7-8-9": [],
	"1-6-7-8-9": [],
	"2-3-4-5-6": [],
	"2-3-4-5-7": [],
	"2-3-4-5-8": [],
	"2-3-4-5-9": [],
	"2-3-4-6-7": [],
	"2-3-4-6-8": [],
	"2-3-4-6-9": [],
	"2-3-4-7-8": [],
	"2-3-4-7-9": [],
	"2-3-4-8-9": [],
	"2-3-5-6-7": [],
	"2-3-5-6-8": [],
	"2-3-5-6-9": [],
	"2-3-5-7-8": [],
	"2-3-5-7-9": [],
	"2-3-5-8-9": [],
	"2-3-6-7-8": [],
	"2-3-6-7-9": [],
	"2-3-6-8-9": [],
	"2-3-7-8-9": [],
	"2-4-5-6-7": [],
	"2-4-5-6-8": [],
	"2-4-5-6-9": [],
	"2-4-5-7-8": [],
	"2-4-5-7-9": [],
	"2-4-5-8-9": [],
	"2-4-6-7-8": [],
	"2-4-6-7-9": [],
	"2-4-6-8-9": [],
	"2-4-7-8-9": [],
	"2-5-6-7-8": [],
	"2-5-6-7-9": [],
	"2-5-6-8-9": [],
	"2-5-7-8-9": [],
	"2-6-7-8-9": [],
	"3-4-5-6-7": [],
	"3-4-5-6-8": [],
	"3-4-5-6-9": [],
	"3-4-5-7-8": [],
	"3-4-5-7-9": [],
	"3-4-5-8-9": [],
	"3-4-6-7-8": [],
	"3-4-6-7-9": [],
	"3-4-6-8-9": [],
	"3-4-7-8-9": [],
	"3-5-6-7-8": [],
	"3-5-6-7-9": [],
	"3-5-6-8-9": [],
	"3-5-7-8-9": [],
	"3-6-7-8-9": [],
	"4-5-6-7-8": [],
	"4-5-6-7-9": [],
	"4-5-6-8-9": [],
	"4-5-7-8-9": [],
	"4-6-7-8-9": [],
	"5-6-7-8-9": [],
	"1-2-3-4-5-6": [],
	"1-2-3-4-5-7": [],
	"1-2-3-4-5-8": [],
	"1-2-3-4-5-9": [],
	"1-2-3-4-6-7": [],
	"1-2-3-4-6-8": [],
	"1-2-3-4-6-9": [],
	"1-2-3-4-7-8": [],
	"1-2-3-4-7-9": [],
	"1-2-3-4-8-9": [],
	"1-2-3-5-6-7": [],
	"1-2-3-5-6-8": [],
	"1-2-3-5-6-9": [],
	"1-2-3-5-7-8": [],
	"1-2-3-5-7-9": [],
	"1-2-3-5-8-9": [],
	"1-2-3-6-7-8": [],
	"1-2-3-6-7-9": [],
	"1-2-3-6-8-9": [],
	"1-2-3-7-8-9": [],
	"1-2-4-5-6-7": [],
	"1-2-4-5-6-8": [],
	"1-2-4-5-6-9": [],
	"1-2-4-5-7-8": [],
	"1-2-4-5-7-9": [],
	"1-2-4-5-8-9": [],
	"1-2-4-6-7-8": [],
	"1-2-4-6-7-9": [],
	"1-2-4-6-8-9": [],
	"1-2-4-7-8-9": [],
	"1-2-5-6-7-8": [],
	"1-2-5-6-7-9": [],
	"1-2-5-6-8-9": [],
	"1-2-5-7-8-9": [],
	"1-2-6-7-8-9": [],
	"1-3-4-5-6-7": [],
	"1-3-4-5-6-8": [],
	"1-3-4-5-6-9": [],
	"1-3-4-5-7-8": [],
	"1-3-4-5-7-9": [],
	"1-3-4-5-8-9": [],
	"1-3-4-6-7-8": [],
	"1-3-4-6-7-9": [],
	"1-3-4-6-8-9": [],
	"1-3-4-7-8-9": [],
	"1-3-5-6-7-8": [],
	"1-3-5-6-7-9": [],
	"1-3-5-6-8-9": [],
	"1-3-5-7-8-9": [],
	"1-3-6-7-8-9": [],
	"1-4-5-6-7-8": [],
	"1-4-5-6-7-9": [],
	"1-4-5-6-8-9": [],
	"1-4-5-7-8-9": [],
	"1-4-6-7-8-9": [],
	"1-5-6-7-8-9": [],
	"2-3-4-5-6-7": [],
	"2-3-4-5-6-8": [],
	"2-3-4-5-6-9": [],
	"2-3-4-5-7-8": [],
	"2-3-4-5-7-9": [],
	"2-3-4-5-8-9": [],
	"2-3-4-6-7-8": [],
	"2-3-4-6-7-9": [],
	"2-3-4-6-8-9": [],
	"2-3-4-7-8-9": [],
	"2-3-5-6-7-8": [],
	"2-3-5-6-7-9": [],
	"2-3-5-6-8-9": [],
	"2-3-5-7-8-9": [],
	"2-3-6-7-8-9": [],
	"2-4-5-6-7-8": [],
	"2-4-5-6-7-9": [],
	"2-4-5-6-8-9": [],
	"2-4-5-7-8-9": [],
	"2-4-6-7-8-9": [],
	"2-5-6-7-8-9": [],
	"3-4-5-6-7-8": [],
	"3-4-5-6-7-9": [],
	"3-4-5-6-8-9": [],
	"3-4-5-7-8-9": [],
	"3-4-6-7-8-9": [],
	"3-5-6-7-8-9": [],
	"4-5-6-7-8-9": [],
	"1-2-3-4-5-6-7": [],
	"1-2-3-4-5-6-8": [],
	"1-2-3-4-5-6-9": [],
	"1-2-3-4-5-7-8": [],
	"1-2-3-4-5-7-9": [],
	"1-2-3-4-5-8-9": [],
	"1-2-3-4-6-7-8": [],
	"1-2-3-4-6-7-9": [],
	"1-2-3-4-6-8-9": [],
	"1-2-3-4-7-8-9": [],
	"1-2-3-5-6-7-8": [],
	"1-2-3-5-6-7-9": [],
	"1-2-3-5-6-8-9": [],
	"1-2-3-5-7-8-9": [],
	"1-2-3-6-7-8-9": [],
	"1-2-4-5-6-7-8": [],
	"1-2-4-5-6-7-9": [],
	"1-2-4-5-6-8-9": [],
	"1-2-4-5-7-8-9": [],
	"1-2-4-6-7-8-9": [],
	"1-2-5-6-7-8-9": [],
	"1-3-4-5-6-7-8": [],
	"1-3-4-5-6-7-9": [],
	"1-3-4-5-6-8-9": [],
	"1-3-4-5-7-8-9": [],
	"1-3-4-6-7-8-9": [],
	"1-3-5-6-7-8-9": [],
	"1-4-5-6-7-8-9": [],
	"2-3-4-5-6-7-8": [],
	"2-3-4-5-6-7-9": [],
	"2-3-4-5-6-8-9": [],
	"2-3-4-5-7-8-9": [],
	"2-3-4-6-7-8-9": [],
	"2-3-5-6-7-8-9": [],
	"2-4-5-6-7-8-9": [],
	"3-4-5-6-7-8-9": [],
	"1-2-3-4-5-6-7-8": [],
	"1-2-3-4-5-6-7-9": [],
	"1-2-3-4-5-6-8-9": [],
	"1-2-3-4-5-7-8-9": [],
	"1-2-3-4-6-7-8-9": [],
	"1-2-3-5-6-7-8-9": [],
	"1-2-4-5-6-7-8-9": [],
	"1-3-4-5-6-7-8-9": [],
	"2-3-4-5-6-7-8-9": [],
	"1-2-3-4-5-6-7-8-9": []	
};

all_data.forEach((element) => {
	let key_format = JSON.stringify(element.machi)
	key_format = key_format.replace("[", "");
	key_format = key_format.replace("]", "");
	key_format = key_format.replace(/"/g, "");
	key_format = key_format.replace(/,/g, "-");
  all_machi_pattern[key_format].push(element);
})

let sortable = [];
for (let pattern in all_machi_pattern) {
    sortable.push([pattern, all_machi_pattern[pattern]]);
}

sortable.sort(function(a, b) {
	if(a[1].length > b[1].length){
		return -1;
	} else if (a[1].length < b[1].length) {
		return 1;
	}
	return 0;
});

try {
  fs.writeFileSync("./src/data/tenpai/machi/pattern.json", JSON.stringify(sortable, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}

let stats_total = []
sortable.forEach((element) => {
  stats_total.push({ [element[0]]: element[1].length })
})

try {
  fs.writeFileSync("./src/data/stats/total_by_machi_pattern.json", JSON.stringify(stats_total, null, "  "));
  console.log('出力成功');
}catch(e){
  console.log(e);
}