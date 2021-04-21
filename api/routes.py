from django.urls import include, path
from rest_framework.routers import DefaultRouter

from api import views

routers = DefaultRouter()
routers.register("orgs", views.OrganizationViewSet)
routers.register("orgsdelete", views.OrganizationDelete)
routers.register("orgsquery", views.OrganizationQuery)

urlpatterns = [path("", include(routers.urls))]
