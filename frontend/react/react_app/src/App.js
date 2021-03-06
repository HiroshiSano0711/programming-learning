import React, { Component } from 'react'
import './App.css';

class App extends Component {
  constructor(props){
    super(props)
    this.state = {
      msg: 'count start',
      counter: 0,
      flg: true,
    }
    this.doAction = this.doAction.bind(this)
  }

  doAction(e) {
    this.setState({
      msg: this.state.counter,
      counter: this.state.counter + 1,
      flg: !this.state.flg,
    })
  }

  render() {
    return <div className="App">
      <header className="App-header">
        <p>{this.state.msg}</p>
        <p>{this.state.count}</p>
        <button onClick={this.doAction}>click</button>
      </header>
    </div>
  }
}

export default App;
