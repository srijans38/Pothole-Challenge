from django.urls import path, include
from . import views
urlpatterns = [
    path('', views.loginPage, name='loginPage'),
    path('changepass/', views.changePass, name='changePass'),
    path('index/', views.index, name='index'),
]
