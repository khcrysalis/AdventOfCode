CC = clang
CFLAGS = -O2 -framework Foundation

SRC = main.m

OUT_DIR = build
OUT = $(OUT_DIR)/main

all: $(OUT)

$(OUT): $(SRC)
	mkdir -p $(OUT_DIR)
	$(CC) $(CFLAGS) -o $(OUT) $(SRC)

clean:
	rm -f $(OUT)
