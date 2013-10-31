<?php
class GarbageGallery {
	public $workpath;
	public $temppath;
	public $thumbpath;
	public $image_globs;
	public $symlink_name;
	public $thumb_size;
	public $debug = FALSE;

	public function __construct(
								$temp_path = '/dev/shm', 
								$image_globs = array('*png','*jp*g','*gif'),
								$symlink_name = 'sm',
								$thumb_size = 200
								) {
		$this->thumbpath = '';
		$this->temppath = is_dir($temp_path) ? $temp_path : FALSE;
		$this->image_globs = $image_globs;
		$this->symlink_name = $symlink_name;
		$this->thumb_size = $thumb_size;

		$this->chdir();

		// automatically output debugging garbage if debug is in the URL or querystring
		if (strpos($_SERVER['QUERY_STRING'], 'debug') || strpos($_SERVER['REQUEST_URI'], 'debug'))
			$this->debug();
	}

	public function debug() {
		$this->debug = TRUE;
	}
	private function log($method, $msg) {
		if ($this->debug) {
			echo __CLASS__ . ' ' . $method . ":\n<br />";
			echo $msg . "\n<br />";
		}
	}

	private function chdir() {
		// find the path the user wants to view, this file probly isn't in that dir
		$this->workpath = realpath($_SERVER['DOCUMENT_ROOT'] . dirname($_SERVER['REQUEST_URI']));
		// change into it, things will be easier
		chdir($this->workpath);

		$this->log(__METHOD__, 'Changing directory to ' . $this->workpath);
	}

	public function getThumbPath() {
		preg_match_all('/[A-Za-z0-9]+/', $this->workpath, $matches);
		foreach ($matches as $m=>$match) 
			$this->thumbpath .= implode('_', $matches[0]);
		
		$this->log(__METHOD__, 'temppath=' . $this->temppath);
		$temp = explode(DIRECTORY_SEPARATOR, $this->temppath);
		print_r($temp);
		$temp[] = $this->thumbpath;
		$this->thumbpath=implode(DIRECTORY_SEPARATOR, $temp);
		
		$this->log(__METHOD__, 'thumbpath=' . $this->thumbpath);
		return $this->thumbpath;
	}

	/**
	 * returns true if thumbnail dir already exists or has been created,
	 * otherwise false
	 */
	public function createThumbdir($thumbpath) {
		if (!is_dir($thumbpath)) {
			$this->log(__METHOD__, 'creating thumb dir ' . $thumbpath);
			mkdir($thumbpath);
			
			if (!is_dir($thumbpath)) {
				$this->log(__METHOD__, 'Failed to create thumb dir!');
				return FALSE;
			}
		}
		$this->log(__METHOD__, 'thumbnail dir exists');
		return TRUE;
	}

	/**
	 k* returns true if symlink already exists or has been created
	 * otherwise false
	 */
	public function createSymLink($linkname) {
		if (!file_exists($linkname)) {
			$this->log(__METHOD__, 'creating symlink ' . $linkname);
			symlink($this->thumbpath, $linkname);

			if (!file_exists($linkname)) {
				$this->log(__METHOD__, 'Failed to create symlink!');
				return FALSE;
			}
		}
		$this->log(__METHOD__, 'symlink exists');
		return TRUE;
	}

	/** 
	 * Get a list of images in the current path that match our list of
	 * filename globs 
	 * Returns array of files that match
	 */
	public function listImages() {
		$this->log(__METHOD__, 'globs: ' . implode(', ', $this->image_globs));
		$images = array();
		foreach ($this->image_globs as $glob) {
			$images = array_merge($images, glob($glob));
		}
		$this->log(__METHOD__, 'Found ' . sizeof($images) . ' images');

		return $images; // array_merge(glob('*png'),glob('*jp*g'), glob('*gif'));
	}

	public function thumbExists($img) {
		return file_exists($this->symlink_name . DIRECTORY_SEPARATOR . $img);
	}

	public function createThumb($img) {
		if (!$this->thumbExists($img)) {
			$sz = "{$this->thumb_size}x{$this->thumb_size}";

			// just kinda hoping imagemagick convert is installed and on the path...
			// should use PHP imagemagick/GD libs
			$exec_str = "convert \"$img\" -resize $sz \"{$this->symlink_name}" . DIRECTORY_SEPARATOR . "$img\"";
			$this->log(__METHOD__, 'Creating thumbnail: <pre>' . $exec_str . '</pre>');
			exec($exec_str);
			if ($this->thumbExists($img))
				$this->log(__METHOD__, 'Success');
			else
				$this->log(__METHOD__, 'Failed');
		}
		return $this->thumbExists($img);
	}

	/**
	 * render the list of images in HTML, with links to their thumbnails if they were 
	 * created. 
	 * Param: $buffer boolean If TRUE, buffer and return the output from this function
	 */
	public function render($buffer = FALSE) {
		if ($buffer) ob_start();
		
		if ($this->createThumbdir($this->getThumbPath()) && $this->createSymLink($this->symlink_name)) {
			foreach ($this->listImages() as $img) {
				$this->createThumb($img);
				echo $img . '<br /><img src="' . $this->symlink_name . '/' . $img . '"><hr />' . "\n"; 
			}
		} else {
			$this->log(__METHOD__, 'Failed to create thumbdir or symlink, going solo');

			foreach ($this->listImages() as $img) {
				echo $img . '<br /><img src="' . $img . '" height="150"><hr />' . "\n"; 
			}
		}
		
		if ($buffer) 
			return ob_get_clean();
		else
			return TRUE;
	}
}

$g = new GarbageGallery();
$buf = $g->render(TRUE);
?>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"><style>
	* {
	font-family: sans-serif;
	font-size: 10pt;
	float: left;
	text-align:right;
	}
	img {

		float: left;
	}
	hr {
		clear: both;
		float: none;
	}
</style>
<script>
	window.onload = function () {
		var imgs = document.getElementsByTagName('img');
		for (var i in imgs) {
			imgs[i].onmouseover = function () {
				visible = document.getElementsByClassName('fs');
				for (var v in visible) {
					if (visible[v] && visible[v].parentNode) {
						visible[v].parentNode.removeChild(visible[v]);
					}
				}
				var img = document.createElement('img');
				img.src = this.src.replace('<?= $g->symlink_name ?>', '');
				img.setAttribute('class', 'fs');
				img.setAttribute('style', 'position: fixed; top: 10px; right: 10px; z-index: 100; border: solid 2px #000; ');
				document.body.appendChild(img);
				img.onmouseout = function () { img.style.display = 'none'; }
			};
		}
	}
</script>

</head><body><?= $buf ?></body></html>
