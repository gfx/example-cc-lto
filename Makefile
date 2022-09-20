OPTIM_FLAGS:=-O2 -flto


all: cmd
.PHONY: all

a.o: a.c
	$(CC) -Wall -Wextra -g3 $(OPTIM_FLAGS) -o $@ -c $<

b.o: b.c
	$(CC) -Wall -Wextra -g3 $(OPTIM_FLAGS) -o $@ -c $<

cmd: a.o b.o
	$(CC) -Wall -Wextra -g3 $(OPTIM_FLAGS) -o $@ $^

disasm: cmd
	objdump --disassemble --source $<
.PHONY: disasm

diff:
	make clean
	make disasm OPTIM_FLAGS="-O2 -flto" > disasm-lto.txt
	make clean
	make disasm OPTIM_FLAGS="-O2" > disasm-no-lto.txt
	diff -u disasm-no-lto.txt disasm-lto.txt

clean:
	rm -rf *.o cmd
.PHONY: clean
