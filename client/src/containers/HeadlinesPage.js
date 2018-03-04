import React, {Component} from 'react';
import {connect} from 'react-redux';
import PropTypes from 'prop-types';
import Decimal from '../classes/Decimal';
import Fmt from '../utils/formatter';
import {Headlines} from '../components/Headlines';
import * as Request from '../utils/request';

class HeadlinesPage extends Component {

  static HEADLINES_REFRESH_INTERVAL = 120 * 1000;

  constructor(props) {
    super(props);
    this.state = {
      articles: [],
      djiaValue:  new Decimal(0.0, 'index'),
      djiaChange: new Decimal(0.0, 'index', 'delta'),
      intervalId: -1,
      refreshTime: new Date(),
    }
  }

  componentDidMount() {
    this.refreshHeadlines();
    this.setState({intervalID: window.setInterval(this.refreshHeadlines, HeadlinesPage.HEADLINES_REFRESH_INTERVAL)});
  }

  componentWillUnmount(){
    window.clearInterval(this.state.intervalId);
  }

  refreshHeadlines = () => {
    Request.headlinesRefresh(headlines => {
      if (headlines.status === 'error') {
        alert(Fmt.serverError('Refresh Headlines', headlines.message));
      } else {
        headlines.articles.forEach((headlinesArticle,index) => {
          if ((index > this.state.articles.length-1) || (headlinesArticle.title !== this.state.articles[index].title)) {
            headlinesArticle.fontWeight = 'bold';
          } else {
            headlinesArticle.fontWeight = 'normal';
          }
        });
        this.setState({articles: headlines.articles});
      }
    });
    Request.indexesRefresh(indices => {
      if ('error' in indices) {
        alert(Fmt.serverError('Refresh Indexes', indices.error));
      } else {
        const djia = indices.find(indice => indice.instrument.symbol === 'DJIA');
        if (djia) {
          this.setState({djiaValue: new Decimal(djia.trade_price, 'index'), djiaChange: new Decimal(djia.price_change, 'index', 'delta'), refreshTime: new Date()});
        }
      }
    });
  }

  render() {
    const {userLocale} = this.props;
    return (<Headlines articles={this.state.articles} djiaValue={this.state.djiaValue} djiaChange={this.state.djiaChange} refreshTime={this.state.refreshTime} refreshHeadlines={this.refreshHeadlines} userLocale={userLocale}/>);
  }
}

HeadlinesPage.propTypes = {
  userLocale: PropTypes.string.isRequired,
}

function mapStateToProps(state) {
  return {userLocale: state.users.user.locale};
}

export default connect(mapStateToProps)(HeadlinesPage);
