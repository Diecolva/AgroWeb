class CustomLogoutMessageMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)

        # Check if the user has logged out and the request path is not in the admin
        if not request.user.is_authenticated and '/admin/' not in request.path:
            # Modify the logout message
            response.content = response.content.replace(
                b'Thanks for spending some quality time with the Web site today.',
                b"Gracias por pasar un rato agradable en la plataforma web"
            )

        return response

