from django import forms
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from inApp.models import Producto, Orden, DetallesOrden
from django.forms import CheckboxSelectMultiple
from django.contrib.auth.admin import UserAdmin as DjangoUserAdmin
from django.contrib.auth.forms import UserChangeForm
from inApp.forms import OrdenForm, DetalleOrdenForm, CustomUserChangeForm
from .models import User
from django.utils.translation import gettext_lazy as _
from django.utils.html import format_html
from django.urls import path
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect
from django.urls import path, reverse




class CustomUserAdmin(UserAdmin):
    form = CustomUserChangeForm
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        ('Información personal', {'fields': ('first_name', 'last_name', 'email')}),  
        ('Permisos', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Fechas importantes', {'fields': ('last_login', 'date_joined')}),
    )

    list_display = ('username', 'email', 'custom_first_name', 'custom_last_name', 'is_staff')

    def custom_first_name(self, obj):
        return obj.first_name if obj.first_name else ''

    def custom_last_name(self, obj):
        return obj.last_name if obj.last_name else ''

    custom_first_name.short_description = 'RUT'
    custom_last_name.short_description = 'Dirección'

    def save_model(self, request, obj, form, change):
        # Llama al método save_model del padre para guardar el usuario
        super().save_model(request, obj, form, change)
        
        # Asigna el usuario como staff
        obj.is_staff = True
        obj.save()


    
class DetalleOrdenInline(admin.TabularInline):
    model = DetallesOrden  
    form = DetalleOrdenForm
    extra = 1

class OrdenAdmin(admin.ModelAdmin):
    list_display = ['fecha', 'usuario', 'hora', 'observacion', 'ver_detalle_button']

    def ver_detalle_button(self, obj):
        return format_html('<button class="btn btn-success" onclick="window.open(\'{}\', \'_blank\')">Ver/Confirmar pedido</button>',
                           reverse('admin:ver_detalle', args=[obj.id]))
    ver_detalle_button.short_description = 'Acciones'


    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('ver_detalle/<int:orden_id>/', self.ver_detalle_view, name='ver_detalle'),
        ]
        return custom_urls + urls

    def get_queryset(self, request):
        # Filtra las órdenes basándote en la identificación del usuario actual
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs  # Los superusuarios pueden ver todas las órdenes
        else:
            return qs.filter(usuario=request.user)

    def ver_detalle_view(self, request, orden_id):
        # Obtener la orden o devolver un error 404 si no existe
        orden = get_object_or_404(Orden, id=orden_id)

        # Lógica para mostrar los detalles de la orden
        # Puedes personalizar esto según tus necesidades
        detalles = orden.detallesorden_set.all()

        # Renderizar una plantilla con los detalles de la orden
        return render(request, 'admin/ver_detalle.html', {'orden': orden, 'detalles': detalles})
    exclude = ('usuario',)
    form = OrdenForm
    inlines = [DetalleOrdenInline]
    change_form_template = 'admin/orden_change_form_custom.html'

    date_hierarchy = 'fecha'

    def get_list_display_links(self, request, list_display):
        """
        Retorna un diccionario de enlaces de campo de visualización que serán mostrados en la lista de objetos.
        Si no quieres que ningún campo sea un enlace, debes devolver None.
        """
        return None

    def save_model(self, request, obj, form, change):
        # Asigna el usuario autenticado al objeto antes de guardarlo
        if not obj.usuario and request.user.is_authenticated:
            obj.usuario = request.user
        super().save_model(request, obj, form, change)


    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        form.request = request  # Pasa el atributo 'request' al formulario
        return form
    
    change_list_template = 'admin/orden_changelist_custom.html'

class NombreProductoFilter(admin.SimpleListFilter):
    title = _('Nombre del Producto')
    parameter_name = 'nombre'

    def lookups(self, request, model_admin):
        # Obtén los valores únicos para el campo de nombre del producto
        nombres = Producto.objects.values_list('nombre', flat=True).distinct()
        return [(nombre, nombre) for nombre in nombres]

    def queryset(self, request, queryset):
        # Filtra los productos por el nombre seleccionado
        if self.value():
            return queryset.filter(nombre=self.value())

class ProductoAdmin(admin.ModelAdmin):
    list_filter = [NombreProductoFilter]
    list_display = ['nombre', 'get_sku_uppercase']  # Use a custom method for sku
    ordering = ['sku']

    def get_sku_uppercase(self, obj):
        return obj.sku.upper()  # Convert sku to uppercase

    get_sku_uppercase.short_description = 'SKU' 

admin.site.register(Producto, ProductoAdmin)
admin.site.register(Orden, OrdenAdmin)
admin.site.unregister(User)
admin.site.register(User, CustomUserAdmin)
