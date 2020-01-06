from django.shortcuts import render
from .models import UData
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.views.generic import View, TemplateView, DetailView
from django.http import HttpResponse
# Create your views here.


def detail_page(req, id):
    return render(req, 'mainapp/detail_page.html')


@method_decorator(login_required, name="dispatch")
class HomeView(TemplateView):
    template_name = "mainapp/home.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['user'] = self.request.user
        return context


def update_ever_logged_in(req):
    current_user = UData.objects.get(user=req.user)
    current_user.ever_logged_in = True
    current_user.save(update_fields=['ever_logged_in'])
    return render(
        req,
        'registration/password_change_done.html',
    )
