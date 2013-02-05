View      = require '../lib/view'
AppRouter = require '../routers/app_router'
BookmarksView = require './bookmarks_view'

module.exports = class AppView extends View
    el: 'body.application'

    template: ->
        require './templates/home'

    initialize: ->
        @router = CozyApp.Routers.AppRouter = new AppRouter()

    afterRender: ->
        @bookmarksView = new BookmarksView()
        # Add random data to check that our view-model binding works fine.

        # Show loading indicator.
        @bookmarksView.$el.html '<em>loading...</em>'


        @bookmarksView.collection.add [
            {title: "Cozy Cloud", url: "https://cozycloud.fr"}
            {title: "Cozy Blog", url: "http://blog.cozycloud.fr"}
        ]

        # Method fetch loads documents from backend and store them inside collection.
      @bookmarksView.collection.fetch
          # Hide loading indicator when fecthing is finished.
          success: => @bookmarksView.$el.find('em').remove()
