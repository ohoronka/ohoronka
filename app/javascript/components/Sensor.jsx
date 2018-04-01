import React from "react"
import PropTypes from "prop-types"
import StatusBadge from "./StatusBadge";

class Sensor extends React.Component {
  render () {
    return (
      <tr>
        <td>{this.props.sensor.name}</td>
        <td className="text-right">
          <StatusBadge status={this.props.sensor.status}></StatusBadge>
        </td>
      </tr>
    );
  }
}

export default Sensor
