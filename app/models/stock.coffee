`import DS from 'ember-data'`

Stock = DS.Model.extend
  'symb': DS.attr 'string'
  'name': DS.attr 'string'
  'sector': DS.attr 'string'
  'industry': DS.attr 'string'

`export default Stock`
