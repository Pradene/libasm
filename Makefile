# Library configuration
NAME := libasm.a

# Source files (just names, no paths)
SRC_FILES := ft_strcpy.s \
			ft_list_size.s \
			ft_list_sort.s \
			ft_list_print.s \
			ft_list_push_front.s \
			ft_strdup.s \
			ft_strchr.s \
			ft_atoi_base.s \
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

TEST_DIR := tests
TEST_FILES := ft_atoi_base.s \
			ft_strlen.s \
			ft_list_size.s \
			ft_list_sort.s \
			ft_list_push_front.s \
			ft_strcpy.s \
			ft_strcmp.s \
			ft_strdup.s \
			ft_read.s \
			ft_write.s

TEST_SRCS := $(addprefix $(TEST_DIR)/, $(TEST_FILES))
TEST_OBJS := $(addprefix $(TEST_DIR)/, $(TEST_FILES:.s=.o))

# Tools and flags
NASM = nasm
NASMFLAGS = -f elf64 -I incs/
AR = ar
ARFLAGS = rcs
CC = gcc
CCFLAGS = -Wall -Wextra -Werror -g

# Default target
all: $(NAME)

# Link object files into the library
$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

# Assemble library source files
$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJS_DIR)
	$(NASM) $(NASMFLAGS) -o $@ $<

# Assemble test files
$(TEST_DIR)/%.o: $(TEST_DIR)/%.s
	$(NASM) $(NASMFLAGS) -o $@ $<

# Ensure build directories exist
$(OBJS_DIR):
	mkdir -p $@

# Test all - compile and run all test programs
test-all: $(NAME) $(TEST_OBJS)
	@echo "Running all tests..."
	@for test_file in $(TEST_FILES:.s=); do \
		echo && \
		$(CC) $(CCFLAGS) -o test_$$test_file $(TEST_DIR)/$$test_file.o $(NAME) && \
		./test_$$test_file && \
		echo "$$test_file: PASS" || echo "$$test_file: FAIL" && \
		rm -f test_$$test_file; \
	done
	@echo
	@echo "All tests completed."

# Parameterized test rule - Usage: make test FILE=strlen
test: $(NAME)
ifndef FILE
	@echo "Usage: make test FILE=<filename_without_extension>"
	@echo "Example: make test FILE=strlen"
	@echo "Available test files: $(TEST_FILES:.s=)"
else
	@echo "Building test object for $(FILE)..."
	@$(NASM) $(NASMFLAGS) -o $(TEST_DIR)/$(FILE).o $(TEST_DIR)/$(FILE).s
	@echo "Linking and running $(FILE) test..."
	@$(CC) $(CCFLAGS) -o test_$(FILE) $(TEST_DIR)/$(FILE).o $(NAME)
	@./test_$(FILE) && echo "$(FILE): PASS" || (echo "$(FILE): FAIL"; exit 1)
	@rm -f test_$(FILE)
endif


debug: $(NAME)
ifndef FILE
	@echo "Usage: make debug FILE=<filename_without_extension>"
	@echo "Example: make debug FILE=strlen"
	@echo "Available test files: $(TEST_FILES:.s=)"
else
	@echo "Building test object for $(FILE)..."
	@$(NASM) $(NASMFLAGS) -o $(TEST_DIR)/$(FILE).o $(TEST_DIR)/$(FILE).s
	@echo "Linking and running $(FILE) test..."
	@$(CC) $(CCFLAGS) -o test_$(FILE) $(TEST_DIR)/$(FILE).o $(NAME)
endif

# Clean object files
clean:
	rm -rf $(OBJS_DIR) $(TEST_OBJS)

# Clean binary and objects
fclean: clean
	rm -rf $(NAME)

# Rebuild all
re: fclean all

.PHONY: all clean fclean re test test-all
