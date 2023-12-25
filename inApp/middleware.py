class CustomLogoutMessageMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)

        # Verificar si el usuario ha cerrado sesión
        if hasattr(request, 'user') and not request.user.is_authenticated:
            # Modificar el mensaje de cierre de sesión
            response.content = response.content.replace(
                b'Thanks for spending some quality time with the Web site today.',
                b"Gracias por pasar un rato agradable en la plataforma web"
            )

        return response