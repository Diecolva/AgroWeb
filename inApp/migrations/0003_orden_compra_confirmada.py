# Generated by Django 4.2.4 on 2024-01-06 02:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('inApp', '0002_detallesorden_unidad'),
    ]

    operations = [
        migrations.AddField(
            model_name='orden',
            name='compra_confirmada',
            field=models.BooleanField(default=False),
        ),
    ]
