module.exports = SelectUncommented =
  config:
     selectBlankLines:
      type: 'boolean'
      default: false

  activate: (state) ->
    atom.commands.add("atom-workspace", "select-uncommented:select": @select.bind(@))

  select: (editor) ->
    editor = atom.workspace.getActiveTextEditor()

    eachUncommented = (f) ->
      for row in [0..editor.getLastBufferRow()]
        if atom.config.get('select-uncommented.selectBlankLines')
          f(row) if !editor.isBufferRowCommented(row)
        else
          f(row) if !editor.isBufferRowCommented(row) && !editor.buffer.isRowBlank(row)

    editor.moveToBottom()
    editor.moveToEndOfLine()

    eachUncommented (row) ->
      editor.addCursorAtBufferPosition([row,0])
      editor.selectToEndOfLine()
