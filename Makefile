OBJS     = src/Context.o src/Demangler.o src/libswift.o src/ManglingUtils.o src/NodeDumper.o src/NodePrinter.o src/OldDemangler.o src/OldRemangler.o src/Punycode.o src/Remangler.o
BINS     = swift-demangle

CXXDBG   = -Wall -W -Werror
CXXFLAGS = -g -std=c++11 -O3 $(CXXDBG) -I$(CURDIR) -I$(CURDIR)/src
LDFLAGS  = #-lasan

all: $(BINS)
	@echo "built."

$(BINS): %: %.o $(OBJS)
	@echo "[LD]" $@
	@$(CXX) $(CXXFLAGS) -o $@ $< $(OBJS) $(LDFLAGS)

$(OBJS): %.o: %.cpp Makefile $(HEADERS)
	@echo "[CXX]" $@
	@$(CXX) $(CXXFLAGS) -c -o $@ $< $(LDFLAGS)

clean:
	@rm -fv *.o $(BINS) *.exe *~ src/*.o
