from django.shortcuts import redirect, render, get_object_or_404
from django.views import View
from .models import DetallesOrden, Orden
from .excel_utils import agregar_datos_a_excel
from django.http import HttpResponseServerError
from django.http import HttpRequest
from django.core.mail import send_mail
from django.contrib.auth.models import User
from string import Template
from django.http import HttpResponseForbidden
from datetime import datetime, time


class VerDetalleView(View):
    template_name = 'admin/ver_detalle.html'


    def get(self, request, *args, **kwargs):
        orden_id = self.kwargs['orden_id']
        orden = get_object_or_404(Orden, id=orden_id)

        # Verifica si la compra está confirmada
        if not orden.compra_confirmada:
            # Si la compra no está confirmada, puedes redirigir a alguna página o manejarlo de la manera que pre>
            return redirect('confirmar_compra')

        # Lógica para obtener detalles de la orden
        detalles = DetallesOrden.objects.filter(orden=orden)

        return render(request, self.template_name, {'orden': orden, 'detalles': detalles})


class ConfirmarCompraView(View):
    template_name = 'admin/confirmar.html'

    def post(self, request, *args, **kwargs):
        # Obtener el ID de la orden de la solicitud POST
        orden_id = request.POST.get('orden_id')
        if not orden_id:
            return HttpResponseForbidden("No se proporcionó un ID de orden para confirmar.")

        # Obtener la orden basada en el ID proporcionado
        orden = get_object_or_404(Orden, id=orden_id, usuario=request.user, compra_confirmada=False)

        # Verificar el límite de horario
        if not self.validar_horario_confirmacion():
            return HttpResponseForbidden("No puedes confirmar la compra fuera del horario permitido.")

        # Marcar la compra como confirmada
        orden.compra_confirmada = True
        orden.save()

        enviar_correo_confirmacion(orden)

        return render(request, self.template_name, {'orden': orden})
    
    def validar_horario_confirmacion(self):
        # Obtener la hora actual
        hora_actual = datetime.now().time()

        # Definir el rango horario permitido para confirmar la compra (de 9:00 a 23:59)
        hora_inicio_permitida = time(9, 0)
        hora_fin_permitida = time(23, 59)

        # Verificar si la hora actual está dentro del rango permitido
        return hora_inicio_permitida <= hora_actual <= hora_fin_permitida    

    
def enviar_correo_confirmacion(orden):
    subject = '¡Pedido confirmado en AGROSHOP!'
    message = 'Su pedido ha sido confirmado'
    from_email = 'AgroShop'

    # Obtén el usuario asociado a la orden
    usuario_actual = User.objects.get(username=orden.usuario.username)

    # Accede al correo electrónico del usuario
    correo_electronico = usuario_actual.email

    template = Template('''
        <h1>¡Su pedido ha sido confirmado en AgroShop! Pronto nos pondremos en contacto con usted.</h1>
        <div style="background-color: green; border-radius: 10px; width: 50%; color: white; text-align: center;">
            <h3>Datos del pedido</h3>
            <h4 style="margin: 20px;">Fecha: $fecha</h4>
            <h4 style="margin: 20px;">Cliente: $cliente</h4>
            <h4 style="margin: 20px;">Observación: $observacion</h4>
            <hr>
            <table class="table" style="margin: 0px auto;">
                <thead class="table-dark">
                    <tr>
                        <th scope="col" style="text-align: center;">Producto</th>
                        <th scope="col" style="text-align: center;">Cantidad</th>
                        <th scope="col" style="text-align: center;">Unidad</th>
                    </tr>
                </thead>
                <tbody>
                    $detalles
                </tbody>
            </table>
        </div>
    ''')

    # Reemplaza las variables en la plantilla
    html_content = template.substitute(
        fecha=orden.fecha,
        cliente=orden.usuario,
        observacion=orden.observacion,  # Agrega la observación a la plantilla
        detalles=''.join([
            f'<tr><td style="text-align: center;">{detalle.producto}</td>'
            f'<td style="text-align: center;">{detalle.cantidad}</td>'
            f'<td style="text-align: center;">{detalle.unidad if detalle.unidad else ""}</td></tr>'
            for detalle in orden.detallesorden_set.all()
        ])
    )


    from_email = 'pedidos@agroshop.cl'  # Reemplaza con tu correo electrónico de Gmail
    recipient_list = [correo_electronico, 'pedidos@agroshop.cl']





    send_mail(subject, message, from_email, recipient_list, html_message=html_content, fail_silently=False)
    
    



