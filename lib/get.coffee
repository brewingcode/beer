import axios from 'axios'

export default (name) ->
  headers = {}

  if auth = process.env.auth
    headers['x-token'] = auth

  axios.request
    method: 'get'
    url: process.env.beerproxy + name
    headers: headers
  .catch (err) ->
    message = "error loading beers for #{name}: "
    if err.response
      message += err.response.data
    else
      message += err.message
    throw new Error message
