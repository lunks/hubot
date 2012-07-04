client_id = process.env.FOURSQUARE_CLIENT_ID
client_secret = process.env.FOURSQUARE_CLIENT_SECRET

https = require 'https'
module.exports = (robot) ->
  robot.respond /lunch/, (msg) ->
    search_for_venues (venue) ->
      venue.url = "htts://foursquare.com/v/#{v.id}"
      msg.send "We're having lunch at #{venue.name}: #{venue.url}"

search_for_venue (callback) ->
  options =
    host:'api.foursquare.com'
    path: "/v2/venues/search?ll=22.902697,-43.181712&client_id=#{client_id}&client_secret=#{client_secret}&categoryId=4d4b7105d754a06374d81259&radius=1000&v=20120701"
    method: 'GET'
  result = ""
  request = https.get(options)
  request.on 'response', (res) ->
    res.on 'data', (data) ->
      result += data
    res.on 'end', ->
      venues = JSON.parse(result)['response']['venues']
      callback(pick_venue venues)

pick_venue = (venues) ->
  random_number = Math.floor(Math.random() + venus.length)
  chosen_venue = venues[random_number]
