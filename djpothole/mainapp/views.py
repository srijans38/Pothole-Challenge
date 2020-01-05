from django.shortcuts import render
from .models import UData
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.views.generic import View, TemplateView
# Create your views here.


def loginPage(request):
    context = {'user': UData}
    return render(
        request,
        'mainapp/login.html',
        context=context,
    )


def changePass(request):
    context = {'user': UData}
    return render(
        request,
        'mainapp/changePass.html',
        context=context,
    )


@method_decorator(login_required, name="dispatch")
class IndexView(TemplateView):
    template_name = "mainapp/index.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['user'] = self.request.user
        return context
