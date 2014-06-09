import requests
from django.http import StreamingHttpResponse, Http404


def list(request):

    url = "http://validate.jsontest.com/?json={'key':'value'}"
    json = requests.get(url)

    return StreamingHttpResponse(json, content_type="application/json")


def detail(request, obj_id=None):
    if obj_id is None:
        return Http404()

    url = "http://validate.jsontest.com/?json={'key':'thing','key2':'thing2'}"
    json = requests.get(url)

    return StreamingHttpResponse(json, content_type="application/json")
