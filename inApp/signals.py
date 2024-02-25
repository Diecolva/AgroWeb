from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Orden
from .excel_utils import agregar_datos_a_excel  # Asegúrate de importar la función adecuada

@receiver(post_save, sender=Orden)
def generar_excel_nueva_orden(sender, instance, **kwargs):
    # Este código se ejecutará cada vez que se guarde una nueva orden
    if instance.compra_confirmada:
        usuario = instance.usuario  # Obtener el usuario de la orden
        agregar_datos_a_excel(usuario, instance)
