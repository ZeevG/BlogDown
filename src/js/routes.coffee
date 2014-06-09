class SimpleRouter extends App.Backbone.Router

    routes:
        # Initial load
        "":         "home"

        "post/:id": "detail"

router = new SimpleRouter()
module.exports = router

router.on "route:home", ->
    console.log "route:home"
    App.Controllers.BlogIndexController.show()

router.on "route:detail", (id) ->
    console.log "route:detail"
    App.Controllers.PostDetailController.show(id)