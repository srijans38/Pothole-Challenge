from django.urls import path, include
from . import views

app_name = 'mainapp'

urlpatterns = [
    path('home/', views.HomeView.as_view(), name='home'),
    path('firstlogin/', views.update_ever_logged_in, name='firstLogin'),
    path('home/<int:id>', views.detail_page, name='detail')
]
