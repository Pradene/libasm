# Executable name
LIB_DIR := lib
LIB := $(LIB_DIR)/libasm.a

# Source files (just names, no paths)
SRC_FILES :=	ft_strcpy.s \
							ft_strdup.s \
							ft_strlen.s \
							ft_strcmp.s

# Directories
SRCS_DIR := srcs
OBJS_DIR := objs

# Full paths
SRCS := $(addprefix $(SRCS_DIR)/, $(SRC_FILES))
OBJS := $(addprefix $(OBJS_DIR)/, $(SRC_FILES:.s=.o))

TEST_DIR := tests
TEST_SRC := $(TEST_DIR)/test.c
TEST_OBJ := $(OBJS_DIR)/test.o
TEST_EXE := tester

NASM = nasm
NASMFLAGS = -f elf64
AR = ar
ARFLAGS = rcs
CC = gcc
CFLAGS = -Wall -Wextra -Werror -g

# Default target
all: $(LIB)

# Link object files into the final binary
$(LIB): $(OBJS) | $(LIB_DIR)
	$(AR) $(ARFLAGS) $@ $^

# Assemble .s into .o
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJS_DIR)
	$(NASM) $(NASMFLAGS) -o $@ $<

# Ensure build directories exist
$(OBJS_DIR):
	mkdir -p $@

$(LIB_DIR):
	mkdir -p $@

# Test target - compile and run the test program
test: $(TEST_EXE)
	./$(TEST_EXE)

# Compile the test program
$(TEST_EXE): $(LIB) $(TEST_OBJ)
	$(CC) $(CFLAGS) -o $@ $(TEST_OBJ) -L$(LIB_DIR) -lasm

# Compile the test source file
$(TEST_OBJ): $(TEST_SRC) | $(OBJS_DIR)
	$(CC) $(CFLAGS) -I$(LIB_DIR) -c $< -o $@

# Clean object files
clean:
	rm -rf $(OBJS_DIR)

# Clean binary and objects
fclean: clean
	rm -f $(LIB) $(TEST_EXE)

# Rebuild all
re: fclean all

.PHONY: all clean fclean re test
