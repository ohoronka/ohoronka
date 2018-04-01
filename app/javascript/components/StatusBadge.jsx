import React from "react"
import PropTypes from "prop-types"
class StatusBadge extends React.Component {
  render () {
    return (
      <span className={"badge badge-" + CONST.enum.styles[this.props.status]} style={this.props.style}>{I18n.t('enum.status.' + this.props.status)}</span>
    );
  }
}

export default StatusBadge
