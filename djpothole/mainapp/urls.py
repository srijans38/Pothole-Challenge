from django.urls import path, include
from . import views

app_name = 'mainapp'

urlpatterns = [
    path('home/', views.HomeView.as_view(), name='home'),
    path('firstlogin/', views.update_ever_logged_in, name='firstLogin'),
    path('home/<str:id>', views.detail_page, name='detail'),
    path('home/error/pagenotfound/', views.page_not_found,
         name="pageNotFound"),
    path('map/',views.mapview,name='mapview'),     
]
