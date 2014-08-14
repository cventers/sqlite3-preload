## Synopsis

sqlite3-preload - Execute SQLite statements when an SQLite database is opened

## Motivation

This is a small hack to enable the execution of certain SQLite PRAGMA(s) when
an application opens an SQLite database but does not support user-defined
SQL commands.

My use case is to make Asterisk's CEL SQLite logging run in something other
than fully synchronous mode. Until upstream exposes an option to control
this behavior, I will LD\_PRELOAD this .so file to provide that behavior
myself.

## Compiling

Use make. I am not going to use autotools on a project this small.

## Usage

\# Optional: Specify an exact version of libsqlite3
export SQLITE3\_LIBRARY=[/path/to/]libsqlite3.so.0

export LD\_PRELOAD=/path/to/sqlite3-preload.so
export SQLITE3\_INIT\_SQL=/path/to/sqlite3.sql
exec /path/to/program-using-sqlite3

When your program calls *sqlite3\_open()*, *sqlite3\_open16()*,
or *sqlite3\_open\_v2()*, this module will hook those function calls and
check the *SQLITE3\_INIT\_SQL* environment variable. If it is unset, the
function call opening the database will be passed thru to SQLite3 with no
modification.

However, if *SQLITE3\_INIT\_SQL* is set, the contents of the file will
be read and passed to *sqlite3\_exec()*. If any errors occur reading the
file or executing its contents, the error will be printed to stderr, any
newly opened database handles will be closed, and an *SQLITE_CANTOPEN* error
will be returned to the application.

## Author

Chase Venters (chase.venters@gmail.com)

## License

Public domain

