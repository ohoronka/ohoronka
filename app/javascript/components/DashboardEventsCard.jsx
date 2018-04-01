import React from "react"
import PropTypes from "prop-types"
import Event from "./Event";

class DashboardEventsCard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      events: props.events,
    };

    this.initActionCable();
  }

  initActionCable(){
    App.cable.subscriptions.create({channel: "DashboardEventsChannel", facility_id: this.props.facility.id}, {
      connected: () => ( console.log('DashboardEventsChannel: connected') ),
      disconnected: () => ( console.log('DashboardEventsChannel: disconnected') ),
      received: (data) => {
        switch(data.e){
          case 'event_created':
            this.state.events.unshift(data.event);
            if(this.state.events.count > 100) this.state.events.pop();
            this.setState({events: this.state.events})
        }
      }
    });
  }

  render () {
    let events = this.props.events.map((event) =>
      <Event event={event} key={event.id}></Event>
    );

    return (
      <section className="section">
        <div className="row sameheight-container">
          <div className="col col-12 col-sm-12 col-md-12 col-xl-12">
            <div className="card sameheight-item" data-exclude="xs">
              <div className="card-block">
                <div className="card-header bordered">
                  <div className="header-block">
                    <h3 className="title">
                      {I18n.t('last_events')}
                    </h3>
                  </div>
                </div>

                <div className="card-block">
                  <table className="list">
                    <tbody>
                      {events}
                    </tbody>
                  </table>
                </div>

              </div>
            </div>
          </div>
        </div>
      </section>
    );
  }
}

export default DashboardEventsCard
