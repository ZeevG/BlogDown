$ = require('jquery')
window._ = _ = require('underscore')
window.Handlebars = Handlebars = require('handlebars')

Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Marionette.$ = $
Marionette.Backbone = Backbone
Marionette.Backbone.$ = $

App = new Marionette.Application()
module.exports = window.App = App

# CONFIG #
App.BASE_URL = "https://api.github.com/"
App.USER = "ZeevG"
App.TITLE = "TITLE"
# CONFIG #

App.addRegions(
  mainRegion: "#content"
)

App.Backbone = Backbone
App.Marionette = Marionette
App.$ = $

App.Get = require './httpget.coffee'
App.Controllers = require './controllers.coffee'
App.Views = require './views.coffee'
App.router = require './routes.coffee'



$(document).ready ->

    App.start()
    Backbone.history.start()

