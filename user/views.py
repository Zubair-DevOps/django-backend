

from django.shortcuts import render
from rest_framework import viewsets         
from .serializers import UserSerializer      
from .models import User
from django.http import HttpResponse
from django.http import JsonResponse

        
class UserView(viewsets.ModelViewSet):      
  serializer_class = UserSerializer        
  queryset = User.objects.all()



def home(request):
    return JsonResponse({"status": "UP", "database": "connected"}, status=200)
