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


    
class DetalleOrdenInline(admin.TabularInline):
    model = DetallesOrden  
    form = DetalleOrdenForm
    extra = 1

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == 'producto' and request.user.username == 'CristianAG':
            allowed_product_name = 'Producto1'
            kwargs['queryset'] = Producto.objects.filter(nombre=allowed_product_name)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

class OrdenAdmin(admin.ModelAdmin):
    list_display = ['fecha', 'usuario', 'hora', 'observacion', 'ver_detalle_button']

    def ver_detalle_button(self, obj):
        return format_html('<a href="{}" target="_blank">Confirmar Pedido</a>', reverse('admin:ver_detalle', args=[obj.id]))

    ver_detalle_button.short_description = 'Confirmar'


    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('ver_detalle/<int:orden_id>/', self.ver_detalle_view, name='ver_detalle'),
        ]
        return custom_urls + urls

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

admin.site.register(Producto, ProductoAdmin)
admin.site.register(Orden, OrdenAdmin)
admin.site.unregister(User)
admin.site.register(User, CustomUserAdmin)