class ListItemView extends App.Marionette.ItemView

    render: ->

        container = $(".content")

        rawTemplate = $('#post-list-item').html()
        template = Handlebars.compile(rawTemplate)

        console.log "Rendering the following posts"
        console.log @model

        html = template(@serializeData())
        container.append(html)


class ListView extends App.Marionette.CollectionView
    itemView: ListItemView
    className: 'PostList'

    onClose: ->
        $(".content").html("")


class DetailView extends App.Marionette.ItemView

    renderMarkdown: ->
        marked = require('marked')

        marked.setOptions(
            renderer: new marked.Renderer(),
            gfm: true,
            tables: true,
            breaks: false,
            pedantic: false,
            sanitize: false,
            smartLists: true,
            smartypants: false
        )

        @model.file.renderedContent = marked(@model.file.content)

    render: ->
        @renderMarkdown()
        container = $(".content")

        rawTemplate = $('#post-detail').html()
        template = Handlebars.compile(rawTemplate)

        console.log "Rendering the following posts"
        console.log @model

        html = template(@model)
        container.append(html)

    onClose: ->
        $(".content").html("")


module.exports = {'ListView': ListView, 'DetailView': DetailView}