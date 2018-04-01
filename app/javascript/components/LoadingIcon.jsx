import React from "react"
import PropTypes from "prop-types"

class LoadingIcon extends React.Component {
  render () {
    return (
      <span>
        <i className='fa fa-spinner fa-spin fa-fw'></i> <span className='sr-only'>{I18n.t('actions.loading')}</span>
      </span>
    );
  }
}

export default LoadingIcon
