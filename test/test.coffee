#!/usr/bin/env coffee

should = require 'should'
import Yardhouse from '../lib/yardhouse.coffee'

describe 'yardhouse', ->
  it 'should return a hundred or so beers', ->
    Yardhouse().then (beers) ->
      beers.length.should.be.above 100
