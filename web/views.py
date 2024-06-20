from django.http import HttpResponse

def index(request):
    return HttpResponse("Test Index Page")

def about(request):
    return HttpResponse("Test About Page")
