# Directories
SRCS_DIR := srcs
OBJS_DIR := objs

# Executable name
NAME := libasm

# Source files (just names, no paths)
SRC_FILES :=	main.s \
							ft_strcpy.s \
							ft_strdup.s \
							ft_strlen.s \
							ft_strcmp.s

# Full paths
SRCS := $(addprefix $(SRCS_DIR)/, $(SRC_FILES))
OBJS := $(addprefix $(OBJS_DIR)/, $(SRC_FILES:.s=.o))

NASM = nasm
NASMFLAGS = -f elf64

# ld flags for libc linking
LD = ld
LDFLAGS =	-dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc

# Default target
all: $(NAME)

# Link object files into the final binary
$(NAME): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

# Assemble .s into .o
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJS_DIR)
	$(NASM) $(NASMFLAGS) -o $@ $^

# Ensure build directory exists
$(OBJS_DIR):
	mkdir -p $@

# Clean object files
clean:
	rm -rf $(OBJS_DIR)

# Clean binary and objects
fclean: clean
	rm -f $(NAME)

# Rebuild all
re: fclean all

.PHONY: all clean fclean re
