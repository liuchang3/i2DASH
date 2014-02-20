BIN_PATH = ./bin
LIB_PATH = ./lib
SRC_PATH = ./src
TEST_PATH = ./test
DIR_PATH = ../
INCLUDE_PATH = ./include
INSTALL_PATH = /usr/local/bin
INSTALL_LIB_PATH = /usr/local/lib
INSTALL_INCLUDE_PATH = /usr/local/include
CC =gcc
LDFLAGS = -fPIC -shared
CFLAGS = -Wall -ggdb -fPIC
PROG_ISOFF = isofftest
PROG_I2DASH = i2dashtest
VERSION = 1.0.0
LIB_SHARED_NAME = libi2dash.so
LIB_STATIC_NAME = libi2dash.a

all: testing

testing: isoff_test.o i2dash_test.o
	mkdir -p bin
	$(CC) $(CFLAGS) -o $(BIN_PATH)/$(PROG_ISOFF) $(TEST_PATH)/isoff_test.o i2libisoff.o
	$(CC) $(CFLAGS) -o $(BIN_PATH)/$(PROG_I2DASH) $(TEST_PATH)/i2dash_test.o i2libdash.o i2libisoff.o h264_stream.o

i2dash_test.o:  $(TEST_PATH)/i2dash_test.c i2libdash.o h264_stream.o i2libisoff.o
	$(CC) $(CFLAGS) -c $(TEST_PATH)/i2dash_test.c
	mv i2dash_test.o $(TEST_PATH)/

i2libdash.o: $(SRC_PATH)/i2libdash.c $(INCLUDE_PATH)/i2libdash.h h264_stream.o i2libisoff.o
	$(CC) $(CFLAGS) -c $(SRC_PATH)/i2libdash.c

h264_stream.o: $(SRC_PATH)/h264_stream.c $(INCLUDE_PATH)/h264_stream.h $(INCLUDE_PATH)/bs.h
	$(CC) $(CFLAGS) -c $(SRC_PATH)/h264_stream.c

isoff_test.o: $(TEST_PATH)/isoff_test.c i2libisoff.o
	$(CC) $(CFLAGS) -c $(TEST_PATH)/isoff_test.c
	mv isoff_test.o $(TEST_PATH)/

i2libisoff.o: $(SRC_PATH)/i2libisoff.c $(INCLUDE_PATH)/i2libisoff.h $(INCLUDE_PATH)/i2context.h
	$(CC) $(CFLAGS) -c $(SRC_PATH)/i2libisoff.c

lib: i2libdash.o i2libisoff.o h264_stream.o
	mkdir -p lib
	$(CC) $(LDFLAGS) -o $(LIB_PATH)/$(LIB_SHARED_NAME).$(VERSION) i2libdash.o i2libisoff.o h264_stream.o
	ar rcs $(LIB_PATH)/$(LIB_STATIC_NAME) i2libdash.o i2libisoff.o h264_stream.o

install:
	cp $(BIN_PATH)/* $(INSTALL_PATH)

install-lib:
	cp -f $(INCLUDE_PATH)/*.h $(INSTALL_INCLUDE_PATH)
	cp -f $(LIB_PATH)/$(LIB_SHARED_NAME).$(VERSION) $(INSTALL_LIB_PATH)
	cp -f $(LIB_PATH)/$(LIB_STATIC_NAME) $(INSTALL_LIB_PATH)
	ln -f -s $(INSTALL_LIB_PATH)/$(LIB_SHARED_NAME).$(VERSION) $(INSTALL_LIB_PATH)/$(LIB_SHARED_NAME)
	ldconfig

clean:
	rm -f $(BIN_PATH)/* $(TEST_PATH)/*.o $(LIB_PATH)/* ./*.o

unistall:
	rm -f $(BIN_PATH)/* $(TEST_PATH)/*.o $(LIB_PATH)/* ./*.o
