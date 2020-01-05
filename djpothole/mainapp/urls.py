from django.urls import path, include
from . import views
urlpatterns = [
    path('login/', views.loginPage, name='loginPage'),
    path('changepass/', views.changePass, name='changePass'),
    path('index/', views.IndexView.as_view(), name='index'),
]