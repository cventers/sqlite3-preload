
all: sqlite3-preload.so

sqlite3-preload.o: sqlite3-preload.c Makefile
	gcc -g -Wall -fno-stack-protector -fPIC -DPIC -c sqlite3-preload.c

sqlite3-preload.so: sqlite3-preload.o Makefile
	gcc -shared -o sqlite3-preload.so sqlite3-preload.o -ldl

clean:
	rm -f sqlite3-preload.o sqlite3-preload.so
