export class Pagination {
	constructor(){
		this._currentPage = 0;
		this._perPage = 100;
	}

	get currentPage() {
		return this._currentPage
	}

	set currentPage(value) {
		this._currentPage = Number(value)
	}

	initCurrentPage() {
		this._currentPage = 0
	}

	plusCurrentPage() {
		this._currentPage += 1
	}

	minusCurrentPage() {
		this._currentPage -= 1
	}

	startIndex() {
		return this._currentPage * this._perPage
  }

	endIndex() {
		return (this._currentPage + 1) * this._perPage
  }

}
