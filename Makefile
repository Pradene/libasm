# Executable name
LIB_DIR := lib
LIB := $(LIB_DIR)/libasm.a

# Source files (just names, no paths)
SRC_FILES :=	ft_strcpy.s \
		ft_strdup.s \
		ft_strlen.s \
		ft_strcmp.s \
		ft_read.s \
		ft_write.s

# Directories
SRCS_DIR := srcs
OBJS_DIR := objs

# Full paths
SRCS := $(addprefix $(SRCS_DIR)/, $(SRC_FILES))
OBJS := $(addprefix $(OBJS_DIR)/, $(SRC_FILES:.s=.o))

# Test files
TEST_DIR := tests
TEST_FILES := strlen.s

TEST_SRCS := $(addprefix $(TEST_DIR)/, $(TEST_FILES))
TEST_OBJS := $(addprefix $(OBJS_DIR)/, $(TEST_FILES:.s=.o))
TEST_EXE := tester

# Tools and flags
NASM = nasm
NASMFLAGS = -f elf64
AR = ar
ARFLAGS = rcs
LD = ld
LDFLAGS = -dynamic-linker /lib64/ld-linux-x86-64.so.2

# Default target
all: $(LIB)

# Link object files into the library
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

# Link the test program (assembly + library)
$(TEST_EXE): $(TEST_OBJS) $(LIB)
	$(LD) $(LDFLAGS) -o $@ $(TEST_OBJS) $(LIB) -lc

# Compile the test source file (assembly)
$(TEST_OBJS): $(TEST_SRCS) | $(OBJS_DIR)
	$(NASM) $(NASMFLAGS) -o $@ $<

# Clean object files
clean:
	rm -rf $(OBJS_DIR)

# Clean binary and objects
fclean: clean
	rm -rf $(LIB_DIR) $(TEST_EXE)

# Rebuild all
re: fclean all

.PHONY: all clean fclean re test
