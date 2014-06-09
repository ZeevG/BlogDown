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
App.BASE_URL = "https://api.github.com/users/"
App.USER = "ZeevG"
App.TITLE = "TITLE"
# CONFIG #


App.Backbone = Backbone
App.Marionette = Marionette
App.$ = $

App.Controllers = require './controllers.coffee'

App.router = require './routes.coffee'



$(document).ready ->

    App.start()
    Backbone.history.start()

