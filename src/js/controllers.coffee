

class BlogIndexController extends App.Marionette.Controller

    show: () ->
        App.Get.userGists(@showView)

    showView: (posts) ->

        view = new App.Views.ListView(collection: new App.Backbone.Collection(posts))
        App.mainRegion.show(view)


class PostDetailController extends App.Marionette.Controller

    show: (id) ->
        App.Get.gist(@showView, id)

    showView: (post) ->

        view = new App.Views.DetailView(model: post)
        App.mainRegion.show(view)

        

module.exports = {
    BlogIndexController: new BlogIndexController(),
    PostDetailController: new PostDetailController()
}