export default (err) ->
  message = "error loading beers: "
  if err.response
    message += err.response.data
  else
    message += err.message
  throw new Error message
