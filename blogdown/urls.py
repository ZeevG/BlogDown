from posts import urls

from django.conf.urls import patterns, include, url
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns(
    '',

    # Examples:
    url(r'^$', 'blogdown.views.home', name='home'),
    url(r'^posts/', include(urls)),
    # url(r'^admin/', include(admin.site.urls)),

)
