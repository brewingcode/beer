import get from './get.coffee'

export default ->
  get('elysian').then (res) ->
    res.data
