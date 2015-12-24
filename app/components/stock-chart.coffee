`import Ember from 'ember'`

StockChartComponent = Ember.Component.extend
  chartDataChanged: Em.observer('history_data', ->
    @drawChart()
  )

  didInsertElement: ->
    if google
      @loadChartPackages().then =>
        @drawChart()
        $(window).on 'resize', (e) =>
          Em.run.debounce @, @drawChart, 200
        return
    return

  loadChartPackages: ->
    new Em.RSVP.Promise((resolve) =>
      google.load 'visualization', '1.1',
        callback: resolve
        packages: [ 'corechart' ]
      return
    )

  drawChart: ->
    data = google.visualization.arrayToDataTable(@get('history_data'), true)
    options = legend: 'none'
    chart = new (google.visualization.CandlestickChart)(document.getElementById('chart-area'))
    chart.draw data, options
    return


`export default StockChartComponent`
