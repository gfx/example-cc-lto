
## The result of `make diff` (as of gcc v11.2 on Ubuntu 20.04)


```diff
make clean
make[1]: Entering directory '/home/goro-fuji/test-lto'
rm -rf *.o cmd
make[1]: Leaving directory '/home/goro-fuji/test-lto'
make disasm OPTIM_FLAGS="-O2 -flto" > disasm-lto.txt
make clean
make[1]: Entering directory '/home/goro-fuji/test-lto'
rm -rf *.o cmd
make[1]: Leaving directory '/home/goro-fuji/test-lto'
make disasm OPTIM_FLAGS="-O2" > disasm-no-lto.txt
diff -u disasm-no-lto.txt disasm-lto.txt
--- disasm-no-lto.txt	2022-09-20 08:41:20.370210472 +0000
+++ disasm-lto.txt	2022-09-20 08:41:20.314209813 +0000
@@ -1,7 +1,7 @@
 make[1]: Entering directory '/home/goro-fuji/test-lto'
-cc -Wall -Wextra -g3 -O2 -o a.o -c a.c
-cc -Wall -Wextra -g3 -O2 -o b.o -c b.c
-cc -Wall -Wextra -g3 -O2 -o cmd a.o b.o
+cc -Wall -Wextra -g3 -O2 -flto -o a.o -c a.c
+cc -Wall -Wextra -g3 -O2 -flto -o b.o -c b.c
+cc -Wall -Wextra -g3 -O2 -flto -o cmd a.o b.o
 objdump --disassemble --source cmd

 cmd:     file format elf64-x86-64
@@ -60,10 +60,10 @@
     106f:	e8 dc ff ff ff       	call   1050 <puts@plt>
     return func();
 }
-    1074:	48 83 c4 08          	add    $0x8,%rsp
-    return func();
-    1078:	e9 f3 00 00 00       	jmp    1170 <func>
-    107d:	0f 1f 00             	nopl   (%rax)
+    1074:	b8 03 00 00 00       	mov    $0x3,%eax
+    1079:	48 83 c4 08          	add    $0x8,%rsp
+    107d:	c3                   	ret
+    107e:	66 90                	xchg   %ax,%ax

 0000000000001080 <_start>:
     1080:	f3 0f 1e fa          	endbr64
@@ -135,22 +135,12 @@
 0000000000001160 <frame_dummy>:
     1160:	f3 0f 1e fa          	endbr64
     1164:	e9 77 ff ff ff       	jmp    10e0 <register_tm_clones>
-    1169:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
-
-0000000000001170 <func>:
-
-int func(void) {
-    1170:	f3 0f 1e fa          	endbr64
-    return 3;
-}
-    1174:	b8 03 00 00 00       	mov    $0x3,%eax
-    1179:	c3                   	ret

 Disassembly of section .fini:

-000000000000117c <_fini>:
-    117c:	f3 0f 1e fa          	endbr64
-    1180:	48 83 ec 08          	sub    $0x8,%rsp
-    1184:	48 83 c4 08          	add    $0x8,%rsp
-    1188:	c3                   	ret
+000000000000116c <_fini>:
+    116c:	f3 0f 1e fa          	endbr64
+    1170:	48 83 ec 08          	sub    $0x8,%rsp
+    1174:	48 83 c4 08          	add    $0x8,%rsp
+    1178:	c3                   	ret
 make[1]: Leaving directory '/home/goro-fuji/test-lto'
```
