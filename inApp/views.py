from django.shortcuts import render
from django.views import View
from .models import DetallesOrden, Orden

class VerDetalleView(View):
    template_name = 'ver_detalle.html'

    def get(self, request, *args, **kwargs):
        orden_id = self.kwargs['orden_id']
        orden = Orden.objects.get(id=orden_id)
        # Lógica para obtener detalles de la orden

        return render(request, self.template_name, {'orden': orden, 'detalles': DetallesOrden})