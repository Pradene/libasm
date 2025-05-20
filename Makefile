# Directories
SRCS_DIR := srcs
OBJS_DIR := objs

# Executable name
NAME := libasm

# Source files (just names, no paths)
SRC_FILES :=	main.s \
							ft_strcpy.s \
							ft_strlen.s

# Full paths
SRCS := $(addprefix $(SRCS_DIR)/, $(SRC_FILES))
OBJS := $(addprefix $(OBJS_DIR)/, $(SRC_FILES:.s=.o))

NASM = nasm
NASMFLAGS = -f elf64
LD = ld
LDFLAGS = 
AR = ar

# Default target
all: $(NAME)

# Link object files into the final binary
$(NAME): $(OBJS)
	$(LD) -o $@ $^

# Assemble .s into .o
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJS_DIR)
	$(NASM) $(NASMFLAGS) -o $@ $<

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

