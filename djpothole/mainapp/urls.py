from django.urls import path, include
from . import views

app_name = 'mainapp'

urlpatterns = [
    path('login/', views.loginPage, name='loginPage'),
    path('changepass/', views.changePass, name='changePass'),
    path('home/', views.HomeView.as_view(), name='home'),
    path('firstlogin/', views.update_ever_logged_in, name='firstLogin')
]
