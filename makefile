
COBCWARN := -Wall
COBCXREF := -Xref

SRCS := $(wildcard ./*.cob)
LSTS := $(wildcard ./*.lst)
SRCS := $(filter-out ./abend.cob, $(SRCS))
EXES := $(patsubst %.cob,%,$(SRCS))
LSTS := $(patsubst %.cob,%.lst,$(LSTS))

all: $(EXES)

.PHONY: all

%: %.cob
	cobc -x $(COBCWARN) $^ abend.cob -T $*.lst $(COBCXREF)

clean:
	-rm $(EXES) $(LSTS)

