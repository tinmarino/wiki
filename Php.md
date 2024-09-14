Yo puedo cualquier tarde, preferiria no el miercoles noche y que trabajo presencial el dia despues


```php

// List GET parameters
foreach ($_GET as $key => $value) {
  echo $key . ' = ' . $value . '<br>';
}
```

# Injection

From: https://stackoverflow.com/questions/3115559/exploitable-php-functions

### Command Execution

```php
exec           - Returns last line of commands output
passthru       - Passes commands output directly to the browser
system         - Passes commands output directly to the browser and returns last line
shell_exec     - Returns commands output
`` (backticks) - Same as shell_exec()
popen          - Opens read or write pipe to process of a command
proc_open      - Similar to popen() but greater degree of control
pcntl_exec     - Executes a program
```

### PHP Code execution


```php
eval()
assert()  - identical to eval()
preg_replace('/.*/e',...) - /e does an eval() on the match
create_function()
include()
include_once()
require()
require_once()
$_GET['func_name']($_GET['argument']);
$func = new ReflectionFunction($_GET['func_name']); $func->invoke(); or $func->invokeArgs(array());
```


### Function with Callback 


```php
Function                     => Position of callback arguments
'ob_start'                   =>  0,
'array_diff_uassoc'          => -1,
'array_diff_ukey'            => -1,
'array_filter'               =>  1,
'array_intersect_uassoc'     => -1,
'array_intersect_ukey'       => -1,
'array_map'                  =>  0,
'array_reduce'               =>  1,
'array_udiff_assoc'          => -1,
'array_udiff_uassoc'         => array(-1, -2),
'array_udiff'                => -1,
'array_uintersect_assoc'     => -1,
'array_uintersect_uassoc'    => array(-1, -2),
'array_uintersect'           => -1,
'array_walk_recursive'       =>  1,
'array_walk'                 =>  1,
'assert_options'             =>  1,
'uasort'                     =>  1,
'uksort'                     =>  1,
'usort'                      =>  1,
'preg_replace_callback'      =>  1,
'spl_autoload_register'      =>  0,
'iterator_apply'             =>  1,
'call_user_func'             =>  0,
'call_user_func_array'       =>  0,
'register_shutdown_function' =>  0,
'register_tick_function'     =>  0,
'set_error_handler'          =>  0,
'set_exception_handler'      =>  0,
'session_set_save_handler'   => array(0, 1, 2, 3, 4, 5),
'sqlite_create_aggregate'    => array(2, 3),
'sqlite_create_function'     =>  2,
```


### Info Disclosure

```php
phpinfo
posix_mkfifo
posix_getlogin
posix_ttyname
getenv
get_current_user
proc_get_status
get_cfg_var
disk_free_space
disk_total_space
diskfreespace
getcwd
getlastmo
getmygid
getmyinode
getmypid
getmyuid
```


### File system

```php
// open filesystem handler
fopen
tmpfile
bzopen
gzopen
SplFileObject->__construct
// write to filesystem (partially in combination with reading)
chgrp
chmod
chown
copy
file_put_contents
lchgrp
lchown
link
mkdir
move_uploaded_file
rename
rmdir
symlink
tempnam
touch
unlink
imagepng   - 2nd parameter is a path.
imagewbmp  - 2nd parameter is a path. 
image2wbmp - 2nd parameter is a path. 
imagejpeg  - 2nd parameter is a path.
imagexbm   - 2nd parameter is a path.
imagegif   - 2nd parameter is a path.
imagegd    - 2nd parameter is a path.
imagegd2   - 2nd parameter is a path.
iptcembed
ftp_get
ftp_nb_get
// read from filesystem
file_exists
file_get_contents
file
fileatime
filectime
filegroup
fileinode
filemtime
fileowner
fileperms
filesize
filetype
glob
is_dir
is_executable
is_file
is_link
is_readable
is_uploaded_file
is_writable
is_writeable
linkinfo
lstat
parse_ini_file
pathinfo
readfile
readlink
realpath
stat
gzfile
readgzfile
getimagesize
imagecreatefromgif
imagecreatefromjpeg
imagecreatefrompng
imagecreatefromwbmp
imagecreatefromxbm
imagecreatefromxpm
ftp_put
ftp_nb_put
exif_read_data
read_exif_data
exif_thumbnail
exif_imagetype
hash_file
hash_hmac_file
hash_update_file
md5_file
sha1_file
highlight_file
show_source
php_strip_whitespace
get_meta_tags
```
