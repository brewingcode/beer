#!/usr/bin/env coffee

should = require 'should'
import Yardhouse from '../lib/yardhouse.coffee'

describe 'yardhouse', ->
  it 'should return a hundred or so beers', ->
    o = {}
    Yardhouse(o).then ->
      o.beers.length.should.be.above 100
