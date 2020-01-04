from django.db import models
from django.contrib.auth.models import User
# Create your models here.


class UData(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    resign_date = models.DateTimeField(null=True, blank=True)

    region = models.CharField(max_length=128)

    def __str__(self):
        return str(self.user)