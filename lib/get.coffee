import axios from 'axios'

export default (name) ->
  axios.get process.env.beerproxy + name
  .catch (err) ->
    message = "error loading beers for #{name}: "
    if err.response
      message += err.response.data
    else
      message += err.message
    throw new Error message
