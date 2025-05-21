# Directories
SRCS_DIR := srcs
OBJS_DIR := objs

# Executable name
LIB := libasm.a

# Source files (just names, no paths)
SRC_FILES :=	ft_strcpy.s \
							ft_strdup.s \
							ft_strlen.s \
							ft_strcmp.s

# Full paths
SRCS := $(addprefix $(SRCS_DIR)/, $(SRC_FILES))
OBJS := $(addprefix $(OBJS_DIR)/, $(SRC_FILES:.s=.o))

TEST_SRC := test.s
TEST_OBJ := $(OBJS_DIR)/test.o
TEST := test

NASM = nasm
NASMFLAGS = -f elf64

# ld flags for libc linking
LD = ld
LDFLAGS = -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc

# Default target
all: $(LIB)

# Link object files into the final binary
$(LIB): $(OBJS)
	@ar rcs $@ $^

# Assemble .s into .o
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJS_DIR)
	$(NASM) $(NASMFLAGS) -o $@ $^

# Ensure build directory exists
$(OBJS_DIR):
	mkdir -p $@

test: $(LIB) $(TEST_OBJ)
	$(LD) $(LDFLAGS) $(OBJS) $(TEST_OBJ) -o $(TEST)
	./$(TEST)

$(OBJS_DIR)/test.o: $(TEST_SRC) | $(OBJS_DIR)
	$(NASM) $(NASMFLAGS) -o $@ $<

# Clean object files
clean:
	rm -rf $(OBJS_DIR)

# Clean binary and objects
fclean: clean
	rm -f $(LIB) $(TEST)

# Rebuild all
re: fclean all

.PHONY: all clean fclean re
