function confirmarPedido(ordenId) {
    fetch(`/admin/inApp/confirmar_pedido/${ordenId}/`)
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const nuevaPestana = window.open('', '_blank');
                nuevaPestana.document.write('<h1>Gracias</h1>');
                nuevaPestana.document.close();
            } else {
                console.error('Error al confirmar el pedido');
            }
        })
        .catch(error => console.error('Error de red:', error));
}