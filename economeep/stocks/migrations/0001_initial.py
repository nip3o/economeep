# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Stock'
        db.create_table(u'stocks_stock', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=40)),
            ('short_name', self.gf('django.db.models.fields.CharField')(max_length=10)),
            ('currency', self.gf('django.db.models.fields.CharField')(max_length=10)),
        ))
        db.send_create_signal(u'stocks', ['Stock'])


    def backwards(self, orm):
        # Deleting model 'Stock'
        db.delete_table(u'stocks_stock')


    models = {
        u'stocks.stock': {
            'Meta': {'object_name': 'Stock'},
            'currency': ('django.db.models.fields.CharField', [], {'max_length': '10'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '40'}),
            'short_name': ('django.db.models.fields.CharField', [], {'max_length': '10'})
        }
    }

    complete_apps = ['stocks']