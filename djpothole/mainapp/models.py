from django.db import models
from django.contrib.auth.models import User
# Create your models here.


class UData(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                related_name='u')
    resign_date = models.DateTimeField(null=True, blank=True)

    region = models.CharField(max_length=128)
    ever_logged_in = models.BooleanField(default=False)

    def __str__(self):
        return str(self.user)