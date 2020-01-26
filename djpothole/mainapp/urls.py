from django.urls import path, include
from . import views
from django.views.generic import RedirectView

app_name = 'mainapp'

urlpatterns = [
    path('home/', views.HomeView.as_view(), name='home'),
    path('firstlogin/', views.update_ever_logged_in, name='firstLogin'),
    # path('home/<str:id>', views.detail_page, name='detail'),
    path('home/error/pagenotfound/', views.page_not_found,
         name="pageNotFound"),
    path('map/', views.mapview, name='mapview'),
    path('feedback/', views.feedbackview, name='feedbackview'),
    path('list/', views.listview, name='listview'),
    path('list/<str:id>', views.detail_page, name='detail'),
]
