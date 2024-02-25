from django.db import models
from django.contrib.auth.models import User 
from django.core.exceptions import ValidationError
from django.utils import timezone
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils import timezone
from django.contrib.auth.models import AbstractUser
# Create your models here.


class Producto(models.Model):
    nombre = models.CharField(max_length=100)
    sku = models.CharField(max_length=150, default='')

    def __str__(self):
        return self.nombre
    
def validar_rango_hora(value):
    min_time = timezone.make_aware(timezone.datetime(2023, 1, 1, 7, 0, 0)).time()  
    max_time = timezone.make_aware(timezone.datetime(2023, 1, 1, 23, 59, 59)).time()  

    if not (min_time <= value <= max_time):
        raise ValidationError('Solo se reciben pedidos entre las 07:00 y las 23:59 hrs.')

class Orden(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=False, editable=True)
    productos = models.ManyToManyField(Producto, through='DetallesOrden')
    fecha = models.DateField(default=timezone.now) 
    hora = models.TimeField(auto_now_add=True, validators=[validar_rango_hora])
    observacion = models.CharField(max_length=500, blank=True)
    compra_confirmada = models.BooleanField(default=False)

    def save(self, *args, **kwargs):
        # Si no se ha establecido el usuario y el usuario está autenticado, asigna el usuario autenticado a la orden
        if not self.usuario and kwargs.get('force_insert', False) and hasattr(kwargs.get('request'), 'user') and kwargs.get('request').user.is_authenticated:
            self.usuario = kwargs.get('request').user
        
        super().save(*args, **kwargs)

    def __str__(self):
        productos_str = ", ".join(str(producto) for producto in self.productos.all())
        return f"con los productos: {productos_str}"

    class Meta:
        verbose_name = 'Pedido'
        verbose_name_plural = 'Pedidos'    
    

    

class DetallesOrden(models.Model):
    orden = models.ForeignKey(Orden, on_delete=models.CASCADE)
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE, null=False, blank=False)
    cantidad = models.DecimalField(max_digits=65, decimal_places=1, default=0)
    unidad = models.CharField(max_length=10, default='KG', blank=False, null=False)

    class Meta:
        verbose_name = 'Producto y Cantidad'
        verbose_name_plural = 'Producto y Cantidad'   

