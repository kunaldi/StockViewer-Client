`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo 'stock'

`export default IndexRoute`
