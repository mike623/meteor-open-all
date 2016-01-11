
MyPackageView = require './my-package-view'
{CompositeDisposable} = require 'atom'
{Path} = require 'path';
{glob} = require("glob");

module.exports = MyPackage =
  myPackageView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @myPackageView = new MyPackageView(state.myPackageViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @myPackageView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'my-package:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @myPackageView.destroy()

  serialize: ->
    myPackageViewState: @myPackageView.serialize()

  toggle: ->
    console.log 'MyPackage was toggled!'


    editor = atom.workspace.getActiveTextEditor();
    console.log(editor.getPath());
    console.log path.dirname(editor.getPath())
    finalpath = path.join(path.dirname(editor.getPath()),"*.*");
    console.log finalpath;
    glob(finalpath, {}, (er, files)=>
        console.log files
        files.forEach((item)=> atom.workspace.open(item,{split:"right",searchAllPanes:true}))

    );



    # atom.workspace.open("/Users/mike/github/my-package/lib/my-package-view.coffee");

    # if(path.isFile()) {
    # atom.workspace.open(path.absolute);
    # if @modalPanel.isVisible()
    #   @modalPanel.hide()
    # else
    #   @modalPanel.show()
