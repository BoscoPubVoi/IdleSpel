extends Panel

var hostURL:String

# Called when the node enters the scene tree for the first time.
func _ready():
	if(not OS.has_feature("web")):
		return;
	
	if(OS.is_userfs_persistent()):
		return;
	
	if JavaScriptBridge.eval("window.location === window.parent.location"):
		return;
	
	# User is in web, and it's not persistent.
	var eval = JavaScriptBridge.eval("document.getElementsByTagName('script')[0].src");
	
	while(eval[eval.length() - 1] != "/"):
		eval = eval.left(eval.length() - 1);
		if(eval.length() < 1):
			break;
	eval = eval + "index.html";
	hostURL = eval;
	visible = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Click to open in new tab
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			OS.shell_open(hostURL)
