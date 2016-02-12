# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$('.best_in_place').best_in_place()

$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  html = """
         <div id="dialog-confirm" title="Are you sure u wan to delete it?">
           <p>#{message}</p>
         </div>
         """
  $(html).dialog
    resizable: false
    modal: true
    buttons: 
      Yes: ->
        $.rails.confirmed link
        $(this).dialog "close"
      No: -> 
        $(this).dialog "close"
