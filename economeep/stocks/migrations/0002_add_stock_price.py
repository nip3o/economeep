# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'StockPrice'
        db.create_table(u'stocks_stockprice', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('stock', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['stocks.Stock'])),
            ('price', self.gf('django.db.models.fields.DecimalField')(max_digits=12, decimal_places=2)),
            ('datetime', self.gf('django.db.models.fields.DateTimeField')()),
        ))
        db.send_create_signal(u'stocks', ['StockPrice'])


    def backwards(self, orm):
        # Deleting model 'StockPrice'
        db.delete_table(u'stocks_stockprice')


    models = {
        u'stocks.stock': {
            'Meta': {'object_name': 'Stock'},
            'currency': ('django.db.models.fields.CharField', [], {'max_length': '10'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '40'}),
            'short_name': ('django.db.models.fields.CharField', [], {'max_length': '10'})
        },
        u'stocks.stockprice': {
            'Meta': {'object_name': 'StockPrice'},
            'datetime': ('django.db.models.fields.DateTimeField', [], {}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'price': ('django.db.models.fields.DecimalField', [], {'max_digits': '12', 'decimal_places': '2'}),
            'stock': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['stocks.Stock']"})
        }
    }

    complete_apps = ['stocks']