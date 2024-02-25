from django.apps import AppConfig

class InappConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'inApp'

    def ready(self):
        import inApp.signals  # Asegúrate de reemplazar 'inApp' con el nombre real de tu aplicación
