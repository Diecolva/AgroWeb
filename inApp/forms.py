from django import forms
from django.contrib.auth.forms import UserChangeForm
from django.contrib.auth.models import User
from inApp.models import Producto, Orden, DetallesOrden
from django.forms import CheckboxSelectMultiple, HiddenInput

class CustomUserChangeForm(forms.ModelForm):
    class Meta:
        model = User
        fields = '__all__' 

    first_name = forms.CharField(label='RUT', required=False)
    last_name = forms.CharField(label='Dirección', required=False)

class OrdenForm(forms.ModelForm):
    class Meta:
        model = Orden
        fields = '__all__'
        widgets = {
            'productos': CheckboxSelectMultiple,
            'observacion': forms.Textarea(attrs={'placeholder': 'En caso de tener alguna indicación adicional, por favor escriba en este campo.'}),
	    'compra_confirmada': HiddenInput(),
        }

    # def get_form(self, request, obj=None, **kwargs):
    #     form = super().get_form(request, obj, **kwargs)
        
    #     # Filtra las opciones del campo 'productos' según el usuario actual
    #     if not obj or (not obj.id and request.user.username == 'CristianAG'):
    #         allowed_product_name = 'Producto1'
    #         form.base_fields['productos'].queryset = Producto.objects.filter(nombre=allowed_product_name)    
            
    #     self.fields['hora'].help_text = 'Pedidos solo serán recibidos hasta las 23:59 hrs.'


class DetalleOrdenForm(forms.ModelForm):
    UNIDAD_CHOICES = [
        ('KG', 'KG'),
        ('Unidad(es)', 'Unidad(es)'),
    ]

    unidad = forms.ChoiceField(choices=UNIDAD_CHOICES, label='Unidad de medida')

    class Meta:
        model = DetallesOrden
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if 'orden' in self.fields:
            self.fields['orden'].widget = forms.HiddenInput()

    def save(self, commit=True):
        detalle_orden = super().save(commit=False)
        detalle_orden.orden = self.instance.orden

        if commit:
            detalle_orden.save()

        return detalle_orden
