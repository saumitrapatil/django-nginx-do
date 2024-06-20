from django.urls import path
from web import views

urlpatterns = [
    path('', views.index ),
    path('about', views.about),
]
