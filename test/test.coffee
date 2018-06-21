#!/usr/bin/env coffee

should = require 'should'
import Yardhouse from '../lib/yardhouse.coffee'
import Pinebox from '../lib/pinebox.coffee'

describe 'yardhouse', ->
  it 'should return over a hundred beers', ->
    Yardhouse().then (beers) ->
      beers.length.should.be.above 100

describe 'pinebox', ->
  it 'should return a hundred or so beers', ->
    Pinebox().then (beers) ->
      beers.length.should.be.above 15
