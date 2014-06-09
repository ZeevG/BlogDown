$ = require('jquery')
_ = require('underscore')
Handlebars = require('handlebars')

BASE_URL = "https://api.github.com/users/"
USER = "ZeevG"



$(document).ready ->
    response = null
    $.ajax(BASE_URL+USER+"/gists", 
      success: render
    )


checkIfPost = (gist) ->
    if gist.file.filename.indexOf("blogentry-") > -1
        return true
    else
        return false


transformResponse = (response) ->
    # For now lets just render the first file
    # There should really only be 1 file anyway

    for gist in response
        firstFile = Object.keys(gist.files)[0]
        gist.file = gist.files[firstFile]

        # Set the gist title to be the filename
        # Remove "blogentry-" prefix and file extenstion
        gist.title = firstFile.slice(10, -3)

        delete gist.files #Don't need this anymore stops confusion

    return response


render = (response) ->
    gists = transformResponse(response)
    posts = _.filter(gists, checkIfPost)

    container = $(".post-container")

    rawTemplate = $('#post-item-template').html()
    template = Handlebars.compile(rawTemplate)

    console.log "Rendering the following posts"
    console.log posts
    for post in posts
        html = template(post)
        container.append(html)
