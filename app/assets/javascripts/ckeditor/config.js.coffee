CKEDITOR.editorConfig = (config) ->
  config.language = 'en'
  config.width = '725'
  config.height = '150'
  config.toolbar_Pure = [

    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'links',       items: [ 'Link','Unlink','Anchor' ] },
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    { name: 'colors',      items: [ 'TextColor','BGColor' ] }
		{ name: 'insert',      items: [ 'Smiley' ]}
  ]
  config.toolbar = 'Pure'
