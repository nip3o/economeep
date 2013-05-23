# encoding: utf-8
from django.contrib import admin

from .models import Budget, BudgetEntry

admin.site.register(Budget)
admin.site.register(BudgetEntry)
