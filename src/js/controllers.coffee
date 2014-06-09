class BlogIndexController extends App.Marionette.Controller

    show: () ->
        $.ajax(App.BASE_URL+App.USER+"/gists", 
            success: (data) =>
                @transformResponse(data)
        )

    showView: (posts) ->
        container = $(".post-container")

        rawTemplate = $('#post-list-item').html()
        template = Handlebars.compile(rawTemplate)

        console.log "Rendering the following posts"
        console.log posts
        for post in posts
            html = template(post)
            container.append(html)


    checkIfPost: (gist) ->
        if gist.file.filename.indexOf("blogentry-") > -1
            return true
        else
            return false


    transformResponse: (response) ->
        # For now lets just render the first file
        # There should really only be 1 file anyway

        for gist in response
            firstFile = Object.keys(gist.files)[0]
            gist.file = gist.files[firstFile]

            # Set the gist title to be the filename
            # Remove "blogentry-" prefix and file extenstion
            gist.title = firstFile.slice(10, -3)

            delete gist.files #Don't need this anymore stops confusion

        console.log "filter"
        posts = _.filter(response, @checkIfPost)
        console.log "post-filter"
        @showView(posts)

module.exports = {BlogIndexController: new BlogIndexController()}