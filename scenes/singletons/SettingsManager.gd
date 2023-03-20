extends Node2D


var config:ConfigFile = null
const config_file_location = "user://settings.cfg"


func _ready():
	config = ConfigFile.new()
	var err = load_config()
	if err != OK:
		printerr("Failed to load config file with error code ", err)


func load_config() -> int:
	var err = config.load(config_file_location)
	if err == ERR_FILE_NOT_FOUND:
		load_default_config()
		return OK
	return err


func load_default_config():
	config = ConfigFile.new()
	set_config("master_volume", 1.0)
	set_config("music_volume", 1.0)
	set_config("fx_volume", 1.0)


func save_config() -> int:
	return config.save(config_file_location)


func get_config(setting):
	return config.get_value("settings", setting, "fx_volume")


func set_config(setting, value):
	config.set_value("settings", setting, value)
