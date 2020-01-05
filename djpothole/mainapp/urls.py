from django.urls import path, include
from . import views

app_name = 'mainapp'

urlpatterns = [
    path('login/', views.loginPage, name='loginPage'),
    path('changepass/', views.changePass, name='changePass'),
    path('index/', views.IndexView.as_view(), name='index'),
    path('firstlogin/', views.update_ever_logged_in, name='firstLogin')
]
