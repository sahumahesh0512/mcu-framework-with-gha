# Makefile

# Compiler and flags
CC = gcc
CFLAGS = -Iinclude

# Directories
SRC_DIR = src
TEST_DIR = tests
BUILD_DIR = build

# Source and object files
SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(SRC_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
TEST_FILES = $(wildcard $(TEST_DIR)/*.c)
TEST_OBJ_FILES = $(TEST_FILES:$(TEST_DIR)/%.c=$(BUILD_DIR)/test_%.o)

# Executable
EXEC = $(BUILD_DIR)/main
TEST_EXEC = $(BUILD_DIR)/test_main

# Targets
all: build

build: $(EXEC)

$(EXEC): $(OBJ_FILES)
    $(CC) $(OBJ_FILES) -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
    @mkdir -p $(BUILD_DIR)
    $(CC) $(CFLAGS) -c $< -o $@

test: $(TEST_EXEC)
    $(TEST_EXEC)

$(TEST_EXEC): $(TEST_OBJ_FILES)
    $(CC) $(TEST_OBJ_FILES) -o $@

$(BUILD_DIR)/test_%.o: $(TEST_DIR)/%.c
    @mkdir -p $(BUILD_DIR)
    $(CC) $(CFLAGS) -c $< -o $@

lint:
    @echo "Running lint..."
    # Add linting command here, for example, cppcheck or another linter
    cppcheck $(SRC_DIR) $(TEST_DIR)

clean:
    @echo "Cleaning up..."
    rm -rf $(BUILD_DIR)

.PHONY: all build test lint clean
