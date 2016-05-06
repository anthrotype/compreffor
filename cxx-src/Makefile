O ?= 2

CXXFLAGS = -std=c++0x -fopenmp -W -Wall -Wno-unused -Wno-unused-parameter
CXXFLAGS += -DDEBUG -g
CXXSOFLAGS = $(CXXFLAGS) -shared
CXX ?= g++
DEPS = cffCompressor.h
BIN = ../compreffor

ifeq ($(OS),Windows_NT)
    uname_S := Windows
else
    uname_S := $(shell uname -s)
endif
ifeq ($(uname_S), Windows)
    executable = cffCompressor.exe
    sharedlib = compreff.dll
    # statically link libgcc, libstdc++ and libwinpthread on mingw-w64
    LDFLAGS ?= -static
else
    executable = cffCompressor
    sharedlib = libcompreff.so
endif

all: $(executable) lib
$(executable): cffCompressor.o
	$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $(LDFLAGS) $^
%.o: %.cc $(DEPS)
	$(CXX) $(CXXFLAGS) -o $@ -c -O$(O) $<
lib: $(sharedlib)
$(sharedlib): cffCompressor.cc $(DEPS)
	$(CXX) $(CXXSOFLAGS) -o $(BIN)/$@ -O$(O) -fPIC $(LDFLAGS) $<
clean:
	rm -rf cffCompressor.o $(BIN)/$(executable) $(BIN)/$(sharedlib) $(BIN)/$(sharedlib).dSYM
ALL: clean all
