

from django.shortcuts import render
from rest_framework import viewsets         
from .serializers import UserSerializer      
from .models import User
from django.http import HttpResponse               
        
class UserView(viewsets.ModelViewSet):      
  serializer_class = UserSerializer        
  queryset = User.objects.all()



def home(request):
    return HttpResponse("Status 200")
