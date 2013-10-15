<?

class parental {

	public static function PARENT() {
		return DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR;
	}
}

echo parental::PARENT();
