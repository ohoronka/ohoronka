import React from "react"
import PropTypes from "prop-types"
import StatusBadge from "./StatusBadge";
import TimeAgo from "../../../node_modules/react-timeago/lib/index";

import ukrStrings from 'react-timeago/lib/language-strings/uk'
import buildFormatter from 'react-timeago/lib/formatters/buildFormatter'

const formatter = buildFormatter(ukrStrings)

class Event extends React.Component {
  render () {
    return (
      <tr>
        <td>{this.props.event.target.name}</td>
        <td><TimeAgo date={this.props.event.created_at} formatter={formatter}></TimeAgo></td>
        <td className="text-right">
          <StatusBadge status={this.props.event.target_status}></StatusBadge>
        </td>
      </tr>
    );
  }
}

export default Event
