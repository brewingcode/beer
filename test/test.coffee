#!/usr/bin/env coffee

should = require 'should'
import Yardhouse from '../lib/yardhouse.coffee'
import Pinebox from '../lib/pinebox.coffee'
import Brouwers from '../lib/brouwers.coffee'
import ChucksGreen from '../lib/chucks-greenwood.coffee'

describe 'yardhouse', ->
  it 'should return over a hundred beers', ->
    Yardhouse().then (beers) ->
      beers.length.should.be.above 100

describe 'pinebox', ->
  it 'should return at least 25 beers', ->
    Pinebox().then (beers) ->
      beers.length.should.be.above 25

describe 'brouwers', ->
  it 'should return at least 70 beers', ->
    Brouwers().then (beers) ->
      beers.length.should.be.above 70

describe 'chucks-green', ->
  it 'should return at least 40 beers', ->
    ChucksGreen().then (beers) ->
      beers.length.should.be.above 40
