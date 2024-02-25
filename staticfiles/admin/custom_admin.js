function actualizarCamposCantidad() {
    // Limpiar campos de cantidad existentes
    $('.cantidad-input').remove();

    // Agregar campos de cantidad para productos seleccionados
    $('.productos-checkbox:checked').each(function () {
        var productoId = $(this).val();
        var cantidadInput = $('<input type="number" class="cantidad-input" name="cantidad_producto_' + productoId + '" min="1" />');
        cantidadInput.val(1); // Establecer el valor predeterminado
        cantidadInput.appendTo($(this).closest('label'));

        // Manejar eventos de cambio en los campos de cantidad
        cantidadInput.on('input', function () {
            // Puedes realizar acciones adicionales aquí si es necesario
            console.log('Nuevo valor de cantidad:', $(this).val());
        });
    });
}