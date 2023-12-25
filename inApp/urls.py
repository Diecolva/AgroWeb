from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('inApp/', include('inApp.urls')),
    # Otras rutas del proyecto
]