FILES   := Makefile autoloads.in autoloads.el autoloads.elc
DIRS    := $(filter-out $(FILES),$(wildcard *))
SPECIAL := autoloads.el
SOURCE  := $(wildcard $(addsuffix /*.el,$(DIRS)))
TARGET  := $(patsubst %.el,%.elc,$(SPECIAL) $(SOURCE))
EMACS   := emacs
EMACS-BATCH := $(EMACS) --batch

.PHONY: all

all: $(TARGET)

autoloads.el: autoloads.in $(SOURCE)
	$(info Generating $@...)
	-@$(RM) autoloads.elc
	-@cp $< $@
	@$(EMACS-BATCH) \
		-l $(shell pwd)/autoloads \
		-f generate-autoloads \
		$(shell pwd)/autoloads.el \
		$(DIRS)
	-@$(RM) autoloads.el~

%.elc: %.el
	$(info Compiling $<...)
	@$(EMACS-BATCH) \
		$(strip $(DIRS:%=-L % )) \
		-f batch-byte-compile $<

clean:
	$(info Cleaning compiled files...)
	-@$(RM) $(TARGET)

fullclean: clean
	$(info Cleaning generated files...)
	-@$(RM) $(SPECIAL) $(addsuffix /*.elc,$(DIRS))
