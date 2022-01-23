import React from "react"
import PropTypes from "prop-types"
class Helloworld extends React.Component {
  render () {
    return (
      <React.Fragment>
        Greeting: {this.props.greeting}
      </React.Fragment>
    );
  }
}

Helloworld.propTypes = {
  greeting: PropTypes.string
};
export default Helloworld
