
filterBlogPosts = (gist) ->
    firstFile = Object.keys(gist.files)[0]

    if gist.files[firstFile].filename.indexOf("blogentry-") > -1
        return true
    else
        return false



# For now lets just work with the first file
# There should really only be one file anyway
replaceFilesArray = (gist) ->   

    firstFile = Object.keys(gist.files)[0]
    gist.file = gist.files[firstFile]

    # Set the gist title to be the filename
    # Remove "blogentry-" prefix and file extenstion
    gist.title = firstFile.slice(10, -3)

    delete gist.files #Don't need this anymore stops confusion

transformResponse = (response) ->

    if response instanceof Array
        response = _.filter(response, filterBlogPosts)
        for gist in response
            replaceFilesArray(gist)
    else
        replaceFilesArray(response)

    return response

userGists = (success) ->

    $.ajax("#{App.BASE_URL}users/#{App.USER}/gists", 
        success: (data) ->
            response = transformResponse(data)
            success(response)
    )

gist = (success, gistID) ->

    $.ajax("#{App.BASE_URL}gists/#{gistID}", 
    success: (data) ->
            response = transformResponse(data)
            success(response)
    )


module.exports = {gist: gist, userGists: userGists}
