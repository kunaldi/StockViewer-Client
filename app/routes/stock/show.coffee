`import Ember from 'ember'`

StockShowRoute = Ember.Route.extend
  model: (params) ->
    @store.findRecord('stock', params.symb)

  normalizeHistoryData: ->
    data = @store._metadataFor('stock').history.reverse().map ((stock) ->
      s = stock.table

      [
        s.trade_date
        parseFloat(s.low)
        parseFloat(s.open)
        parseFloat(s.close)
        parseFloat(s.high)
      ]
    )

    @controller.set 'history', data
    return

  setupController: (controller, model) ->
    @_super controller, model
    @normalizeHistoryData()
    return


`export default StockShowRoute`
