import React from "react"
import PropTypes from "prop-types"
import StatusBadge from "./StatusBadge";
import Sensor from "./Sensor";
import LoadingIcon from "./LoadingIcon";

class FacilityStatusCard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      facility: props.facility,
      sensors: props.sensors,
      loadingNextStatus: false
    };

    this.initActionCable();

    this.clickNextStatus = this.clickNextStatus.bind(this);
    this.canClickNextStatus = this.canClickNextStatus.bind(this);
  }

  initActionCable(){
    App.cable.subscriptions.create({channel: "FacilityChannel", facility_id: this.state.facility.id}, {
      connected: () => ( console.log('FacilityChannel: connected') ),
      disconnected: () => ( console.log('FacilityChannel: disconnected') ),
      received: (data) => {
        switch(data.e){
          case 'sensor_updated':
            let sensorIndex = this.state.sensors.findIndex((sensor) => {return sensor.id == data.sensor.id});
            let newState = {sensors: this.state.sensors};
            newState.sensors[sensorIndex] = data.sensor;
            this.setState(newState);
            break;
          case 'facility_updated':
            this.setState({facility: data.facility});
            break
        }
      }
    });
  }

  clickNextStatus(e){
    e.preventDefault();
    if (this.state.loadingNextStatus || !this.canClickNextStatus()) return;
    this.setState({loadingNextStatus: true});

    $.ajax('/facilities/' + this.props.facility.id + '/set_next_status', {
      method: 'patch',
      dataType: 'json',
      success: (data) => {
        this.setState({
          facility: data.facility,
          loadingNextStatus: false
        });
      }
    })
  }

  canClickNextStatus(){
    return (this.state.facility.status === 'idle') ? this.state.sensors.every(sensor => sensor.status === 'ok') : true
  }

  render () {
    let nextStatus = CONST.Facility.STATUS_FLOW[this.state.facility.status][0];
    let sensors = this.state.sensors.map((sensor) =>
      <Sensor sensor={sensor} key={sensor.id}></Sensor>
    );

    let nextBtnText = this.state.loadingNextStatus ? (<LoadingIcon></LoadingIcon>) : I18n.t('enum.next_status.' + nextStatus);
    let nextBtn = this.canClickNextStatus() ? (<a href="#" onClick={this.clickNextStatus} className={"btn btn-outline-" + CONST.enum.styles[nextStatus]} data-turbolinks="false">{nextBtnText}</a>) : (<span className="badge badge-warning">{I18n.t('sensors_must_be_ok')}</span>);

    return (
      <div className="card-block">
        <div className="card-header bordered">
          <div className="header-block">
            <h3 className="title">
              {this.state.facility.name}
              <StatusBadge status={this.state.facility.status} style={{marginLeft: '10px'}}></StatusBadge>
            </h3>
          </div>
          <div className="header-block pull-right">
            { nextBtn }
          </div>
        </div>

        <div className="card-block">
          <table className="list">
            <tbody>
            { sensors }
            </tbody>
          </table>
        </div>

      </div>
    );
  }
}

export default FacilityStatusCard
