# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/ #nope idk coffeescript -Aatash

$(document).ready( ->

  # Trix Editor
  $("trix-editor").on "keydown", (e) ->
    if(e.keyCode == 13 && e.metaKey)
      $("#new-post-submit").click()

  # AUTOMATICALLY ADD LINKS when PASTING into the trix text editor
  $editor = $("trix-editor")
  $editor.on "paste", (e) ->
    pastedText = e.originalEvent.clipboardData?.getData?("Text")
    # we defer so we can get the cursor position after the pasting happens
    # otherwise trix returns the position before
    setTimeout( ->
      if pastedText and !!pastedText.match(/^(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})$/ig)
        element = $editor.get(0)
        editor = element.editor
        currentText = editor.getDocument().toString()
        currentSelection = editor.getSelectedRange()
        # text up to the cursor position
        textWeAreInterestedIn = currentText.substring 0, currentSelection[0]
        # search for the start of the url
        startOfPastedText = textWeAreInterestedIn.lastIndexOf pastedText
        # add an undo entry so people can undo the autolinking
        editor.recordUndoEntry "Auto Link Paste"
        # select the url text
        editor.setSelectedRange [startOfPastedText, currentSelection[0]]
        # add a hyperlink to it
        editor.activateAttribute 'href', pastedText
        # go back to the original selection
        editor.setSelectedRange currentSelection
    , 0)

  # AUTOMATICALLY ADD LINKS when TYPING them into the trix text editor
  $editor.on "trix-change", (e) ->
    console.log("change")
    element = $editor.get(0)
    editor = element.editor
    currentText = editor.getDocument().toString()
    currentSelection = editor.getSelectedRange()
    # text up to the cursor position
    textWeAreInterestedIn = currentText.substring 0, currentSelection[0]
    # if last character was a whitespace character
    lastCharacter = textWeAreInterestedIn.substring currentSelection[0] - 1, currentSelection[0]
    if /\s/.test(lastCharacter)
      console.log("yup!")
      # index of last whitespace
      textMinusLastCharacter = textWeAreInterestedIn.substring 0, currentSelection[0] - 1
      previousWhiteSpaceIndex = textMinusLastCharacter.search(/ [^ ]*$/)
      # get the substring!
      lastFullWord = textWeAreInterestedIn.substring previousWhiteSpaceIndex + 1, currentSelection[0] - 1
      console.log lastFullWord
      # is there a link?
      linksFound = linkify.find lastFullWord
      console.log linksFound
      if linksFound.length > 0
        # search for the start of the url
        startOfLinkText = textWeAreInterestedIn.lastIndexOf linksFound[0].value
        # add an undo entry so people can undo the autolinking
        editor.recordUndoEntry "Auto Link Create"
        # select the url text
        editor.setSelectedRange [startOfLinkText, currentSelection[0]]
        # add a hyperlink to it
        editor.activateAttribute 'href', linksFound[0].href
        # go back to the original selection
        editor.setSelectedRange currentSelection
)
