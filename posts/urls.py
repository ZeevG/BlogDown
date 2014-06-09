from django.conf.urls import patterns, url

urlpatterns = patterns(
    '',

    url(r'^$', 'posts.views.list', name='list'),
    url(r'^(?P<obj_id>\w+)$', 'posts.views.detail', name='detail'),

)
