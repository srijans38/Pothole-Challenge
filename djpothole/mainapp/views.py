from django.shortcuts import render
from .models import UData

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


def index(request):
    context = {'user': UData}

    return render(
        request,
        'index.html',
        context=context,
    )
