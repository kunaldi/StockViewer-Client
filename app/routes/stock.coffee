`import Ember from 'ember'`

StockRoute = Ember.Route.extend
  inProgress: false

  validateEntry: ->
    _this = this

    unless @inProgress
      @inProgress = true

      Em.run.debounce (->
        c = _this.controller
        entry = c.get('stockName')?.trim()

        if entry != c.get('lastEntry')
          c.set 'lastEntry', entry

          if entry.length > 0
            Em.Logger.log "StockRoute::validateEntry [#{entry}]"

            _this.store.query('stock', {filter: {name: entry}}).then ((response) ->
              c.set 'stocks', response
              return
            ), (error) ->
              Em.Logger.log error.message
              return
          else
            c.set 'stocks', null

        _this.inProgress = false
        return
      ), 2500

    return

  setupController: (controller, model) ->
    @_super controller, model
    @addObserver 'controller.stockName', @validateEntry
    return

`export default StockRoute`
