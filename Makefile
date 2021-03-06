# ���, Emacs, ��� -*- makefile -*-
#----------------------------------------------------------------------------
# ������ Makefile WinAVR, ���������� Eric B. Weddington, J�rg Wunsch � ������.
#
# ������������ � ��������� ����� (Public Domain)
#
# �������������� ��������� ��� ����� makefile �������� ��������:
# Peter Fleury
# Tim Henigan
# Colin O'Flynn
# Reiner Patommel
# Markus Pfaff
# Sander Pool
# Frederik Rouleau
# Carlos Lamas
#
#----------------------------------------------------------------------------
# ������������� ����� Makefile ����� ��������� ������:
#
# make all = ������ ���������.
#
# make clean = ������� �� ��������� ������ ������� (���������� ��� ������).
#
# make coff = ��������������� ������� ELF � ������ AVR COFF.
#
# make extcoff = ��������������� ������� ELF � ������ AVR Extended COFF.
#
# make program = �������� hex-����� ("��������", ���������� ���������) � ���������� 
#                � �������������� ������������� avrdude. ����������, ��������������
#                �������� ����������� ��������� avrdude (������� �����)!
#
# make debug = ������ ���� simulavr ��� avarice ��� ������� ��� �������, 
#              ������ � avr-gdb ��� avr-insight � �������� front end ��� �������.
#
# make filename.s = ������ �������������� filename.c ������ � ������������ ���.
#
# make filename.i = ������� �������������� ������������ (preprocessed) �������� ����
#					��� ������������� � ���������� �� ������� (bug reports) 
#					������� GCC.
#
# ��� ���������� ������� �������� "make clean", � ����� "make all".
#----------------------------------------------------------------------------


# ��� (��� ����������������) MCU
MCU = atmega8


# �������� ������� ���������� � ������.
#     ��� ������� ������ F_CPU, ������� �� ���� �������� ���� ������������ �������� 
#      �������� ������� ����������������. �� ������ ������������ ���� ������ � ��������
#      ���� ��� ���������� ���������� �������. �� ���������� � ����� 'UL', ��� �������������
#      ������� 32-������ �������� � ����� �������� ����.
#     �������� �������� F_CPU:
#         F_CPU =  1000000
#         F_CPU =  1843200
#         F_CPU =  2000000
#         F_CPU =  3686400
#         F_CPU =  4000000
#         F_CPU =  7372800
#         F_CPU =  8000000
#         F_CPU = 11059200
#         F_CPU = 14745600
#         F_CPU = 16000000
#         F_CPU = 18432000
#         F_CPU = 20000000
F_CPU = 8000000


# �������� ������ (����� ���� srec, ihex, binary).
FORMAT = ihex


# ������� ��� ����� (��� ����������).
TARGET = 1


# ����� ��� ��������� ������
#     ��� ����, ����� ��������� ����� ���������� � ������� ����������, ����������� ����� (.), 
#      �� ���������� ���� �������� ������ ��� blank macro!
OBJDIR = .


# ����� ������ ������ �������� ������ �� ����� C (C ����������� ������������ �������������).
SRC = $(TARGET).c 


# �� �� �����, �� ��� ������ C++ (C ����������� ������������ �������������).
CPPSRC = 


# ������ �������� ������ �� ����������.
#     ������� ������ ��� ����� ��������������� �� .S (����� "S" ���������). �����, ��������������
#      �� ��������� .s, �� ��������������� ��� �������� �����, ������ ��������������� ��� 
#      ��������������� ����� (������������ ����� �� �����������), � ����� ������� ��������
#      "make clean"!
#     ��������� �������� ������� DOS/Win* �� ������ �������� ����� .s and .S,
#      ������ ���� ������ �����������, � gcc ��� ��������� � ���, ��� ��� ������������ �� ������ 
#      � ��� ��������� ������.
ASRC =


# ������� �����������, ����� ���� [0, 1, 2, 3, s]. 
#     0 = ��������� �����������. s = �������������� �� �������.
#     (���������: 3 �� ������ ������ ������� �����������. ��. avr-libc FAQ.)
OPT = s


# ���������� ������.
#     ������������ ������� ��� AVR-GCC (����� -g) �������� dwarf-2 [default] ��� stabs.
#     AVR Studio 4.10 ������� dwarf-2.
#     AVR [Extended] COFF ������ ������� stabs, ���� ������ ������� avr-objcopy.
DEBUG = stabs


# ������ ����� �� �������������� �����, ��� ����� �������� ���������� ����� (��������� #include).
#     ������ ���� �� ����� ������ ���� ������� ��������. ����������� ������ ���� (/)
#      � �������� ����������� ���������� � ����. ��� �����, ���� �� ������� ����� �������,
#      ����������� ����, ����������� � �������.
EXTRAINCDIRS = 


# ����� ����������� ��� ��������� ������������ ������ C.
#     c89   = "ANSI" C
#     gnu89 = c89 ���� ���������� GCC
#     c99   = ISO C99 �������� (���� �� ��������� �������������)
#     gnu99 = c99 ���� ���������� GCC
CSTANDARD = -std=gnu99


# ��������� ����� ����� -D ��� -U ��� ���������� C
CDEFS = -DF_CPU=$(F_CPU)UL


# ��������� ����� ����� -D ��� -U ��� ���������� ASM
ADEFS = -DF_CPU=$(F_CPU)


# ��������� ����� ����� -D ��� -U ��� ���������� C++
CPPDEFS = -DF_CPU=$(F_CPU)UL
#CPPDEFS += -D__STDC_LIMIT_MACROS
#CPPDEFS += -D__STDC_CONSTANT_MACROS



#---------------- ����� ����������� C ----------------
#  -g*:          ������������ ���������� ����������
#  -O*:          ������� �����������
#  -f...:        ���������, ��. ����������� GCC � ������������ avr-libc
#  -Wall...:     ������� ��������������� ���������
#  -Wa,...:      ������� GCC �������� ��� ����������.
#    -adhlns...: �������� �������� ����������
CFLAGS = -g$(DEBUG)
CFLAGS += $(CDEFS)
CFLAGS += -O$(OPT)
CFLAGS += -funsigned-char
CFLAGS += -funsigned-bitfields
CFLAGS += -fpack-struct
CFLAGS += -fshort-enums
CFLAGS += -Wall
CFLAGS += -Wstrict-prototypes
#CFLAGS += -mshort-calls
#CFLAGS += -fno-unit-at-a-time
#CFLAGS += -Wundef
#CFLAGS += -Wunreachable-code
#CFLAGS += -Wsign-compare
CFLAGS += -Wa,-adhlns=$(<:%.c=$(OBJDIR)/%.lst)
CFLAGS += $(patsubst %,-I%,$(EXTRAINCDIRS))
CFLAGS += $(CSTANDARD)


#---------------- ����� ����������� C++ ----------------
#  -g*:          ������������ ���������� ����������
#  -O*:          ������� �����������
#  -f...:        ���������, ��. ����������� GCC � ������������ avr-libc
#  -Wall...:     ������� ��������������� ���������
#  -Wa,...:      ������� GCC �������� ��� ����������.
#    -adhlns...: �������� �������� ����������
CPPFLAGS = -g$(DEBUG)
CPPFLAGS += $(CPPDEFS)
CPPFLAGS += -O$(OPT)
CPPFLAGS += -funsigned-char
CPPFLAGS += -funsigned-bitfields
CPPFLAGS += -fpack-struct
CPPFLAGS += -fshort-enums
CPPFLAGS += -fno-exceptions
CPPFLAGS += -Wall
CFLAGS += -Wundef
#CPPFLAGS += -mshort-calls
#CPPFLAGS += -fno-unit-at-a-time
#CPPFLAGS += -Wstrict-prototypes
#CPPFLAGS += -Wunreachable-code
#CPPFLAGS += -Wsign-compare
CPPFLAGS += -Wa,-adhlns=$(<:%.cpp=$(OBJDIR)/%.lst)
CPPFLAGS += $(patsubst %,-I%,$(EXTRAINCDIRS))
#CPPFLAGS += $(CSTANDARD)


#---------------- ����� ���������� ----------------
#  -Wa,...:   ������� GCC �������� ��� ����������.
#  -adhlns:   ������� �������
#  -gstabs:   ��������� ���������� ��������� ���������� � ������� �����; ������� �� ��������,
#             ��� ��� ������������� � ������ COFF ���������� �������������� ���������� 
#             �� ������ ������ � �������, �������������� � ������������ �������� ������,
#             ��. avr-libc ������������ [FIXME: ���� �� ������� �����]
#  -listing-cont-lines: ������������� ������������ ����� ����� ����������� hex-�����
#             ������� ����� ������������ ��� ������������ ������ ��������� �����.
ASFLAGS = $(ADEFS) -Wa,-adhlns=$(<:%.S=$(OBJDIR)/%.lst),-gstabs,--listing-cont-lines=100


#---------------- ������������ ����� ----------------
# �������������� ������ printf
PRINTF_LIB_MIN = -Wl,-u,vfprintf -lprintf_min

# ������ printf, �������������� ��������� ����� (������� MATH_LIB = -lm ����)
PRINTF_LIB_FLOAT = -Wl,-u,vfprintf -lprintf_flt

# ���� ���� �������� �������� ������, ����� �������������� ����������� ������ printf.
PRINTF_LIB = 
#PRINTF_LIB = $(PRINTF_LIB_MIN)
#PRINTF_LIB = $(PRINTF_LIB_FLOAT)


# �������������� ������ scanf
SCANF_LIB_MIN = -Wl,-u,vfscanf -lscanf_min

# ��������� ����� + %[ ������ scanf (������� MATH_LIB = -lm ����)
SCANF_LIB_FLOAT = -Wl,-u,vfscanf -lscanf_flt

# ���� ���� �������� �������� ������, ����� �������������� ����������� ������ scanf.
SCANF_LIB = 
#SCANF_LIB = $(SCANF_LIB_MIN)
#SCANF_LIB = $(SCANF_LIB_FLOAT)


MATH_LIB = -lm


# ������ ����� �������������� �����, ��� ��� ���������� ����� �������� ����������.
#     ������ ���� �� ����� ������ ���� ������� ��������. ����������� ������ ���� (/)
#      � �������� ����������� ���������� � ����. ��� �����, ���� �� ������� ����� �������,
#      ����������� ����, ����������� � �������.
EXTRALIBDIRS = 



#---------------- ����� ������� (External) ������ ----------------

# 64 KB ������� RAM, ������������ ����� ���������� RAM (ATmega128!),
#  ������������ ��� ���������� (.data/.bss) � ���� (malloc()).
#EXTMEMOPTS = -Wl,-Tdata=0x801100,--defsym=__heap_end=0x80ffff

# 64 KB ������� RAM, ������������ ����� ���������� RAM (ATmega128!),
#  ������������ ������ ��� ���� (malloc()).
#EXTMEMOPTS = -Wl,--section-start,.data=0x801100,--defsym=__heap_end=0x80ffff

EXTMEMOPTS =



#---------------- ����� ������� ----------------
#  -Wl,...:     ������� GCC �������� ��� �������.
#    -Map:      ������� map-����
#    --cref:    �������� ������������ ������ �� map-����
LDFLAGS = -Wl,-Map=$(TARGET).map,--cref
LDFLAGS += $(EXTMEMOPTS)
LDFLAGS += $(patsubst %,-L%,$(EXTRALIBDIRS))
LDFLAGS += $(PRINTF_LIB) $(SCANF_LIB) $(MATH_LIB)
#LDFLAGS += -T linker_script.x



#---------------- ����� ������������� (avrdude) ----------------

# ��������������� ������
# �������: avrdude -c ?
# ��� ��������� ������� ��������.
#
AVRDUDE_PROGRAMMER = stk200

# com1 = ���������������� ����. ����������� lpt1 ��� ������������� ����� ������������ ����.
AVRDUDE_PORT = lpt1

AVRDUDE_WRITE_FLASH = -U flash:w:$(TARGET).hex
#AVRDUDE_WRITE_EEPROM = -U eeprom:w:$(TARGET).eep


# ���������������� ���������, ���� �� ������ ������� ������� ������ avrdude.
# ������� �� ��������, ��� ���� ������� ������� ������ ���� ������������������
#  � �������������� -Yn, �������� ����������� ������������� avrdude.
#AVRDUDE_ERASE_COUNTER = -y

# ���������������� ���������, ���� �� ������ /�� ������/ ������� �����������
#  ����� ���������������� ����������.
#AVRDUDE_NO_VERIFY = -V

# ��������� ������� "��������������" (������� ���������������� ���������). ����������
#  ����������� ��� ��� ��������� � ����� avrdude. ��. <http://savannah.nongnu.org/projects/avrdude> 
#  �� ������ bug-��������.
#AVRDUDE_VERBOSE = -v -v

AVRDUDE_FLAGS = -p $(MCU) -P $(AVRDUDE_PORT) -c $(AVRDUDE_PROGRAMMER)
AVRDUDE_FLAGS += $(AVRDUDE_NO_VERIFY)
AVRDUDE_FLAGS += $(AVRDUDE_VERBOSE)
AVRDUDE_FLAGS += $(AVRDUDE_ERASE_COUNTER)



#---------------- ����� ������� ----------------

# ������ ��� simulavr - �������� ������� �������� MCU.
DEBUG_MFREQ = $(F_CPU)

# ���������� DEBUG_UI ���� � gdb, ���� � insight.
# DEBUG_UI = gdb
DEBUG_UI = insight

# ������������� back-end ������� ���� � avarice, ���� � simulavr.
DEBUG_BACKEND = avarice
#DEBUG_BACKEND = simulavr

# ��� ����� GDB Init.
GDBINIT_FILE = __avr_gdbinit

# ��������� ��� JTAG, ����� ������������ avarice
JTAG_DEV = /dev/com1

# ���� �������, ����������� ��� ������������ ����� GDB / avarice / simulavr.
DEBUG_PORT = 4242

# ������������ ����, ������������ ��� ������������ ����� GDB / avarice / simulavr, 
#     ��������� ��������������� � localhost, �� ����������� ������������������ 
#     ���������� �����, ����� avarice ����������� �� ������ ����������.
DEBUG_HOST = localhost



#============================================================================


# ����������� �������� � ������.
SHELL = sh
CC = avr-gcc
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
SIZE = avr-size
AR = avr-ar rcs
NM = avr-nm
AVRDUDE = avrdude
REMOVE = rm -f
REMOVEDIR = rm -rf
COPY = cp
WINSHELL = cmd


# ����������� ���������
# (�� ���������� �����)
MSG_ERRORS_NONE = Errors: none
MSG_BEGIN = -------- begin --------
MSG_END = --------  end  --------
MSG_SIZE_BEFORE = Size before: 
MSG_SIZE_AFTER = Size after:
MSG_COFF = Converting to AVR COFF:
MSG_EXTENDED_COFF = Converting to AVR Extended COFF:
MSG_FLASH = Creating load file for Flash:
MSG_EEPROM = Creating load file for EEPROM:
MSG_EXTENDED_LISTING = Creating Extended Listing:
MSG_SYMBOL_TABLE = Creating Symbol Table:
MSG_LINKING = Linking:
MSG_COMPILING = Compiling C:
MSG_COMPILING_CPP = Compiling C++:
MSG_ASSEMBLING = Assembling:
MSG_CLEANING = Cleaning project:
MSG_CREATING_LIBRARY = Creating library:




# ����������� ���� ��������� ������.
OBJ = $(SRC:%.c=$(OBJDIR)/%.o) $(CPPSRC:%.cpp=$(OBJDIR)/%.o) $(ASRC:%.S=$(OBJDIR)/%.o) 

# ����������� ���� ������ ��������.
LST = $(SRC:%.c=$(OBJDIR)/%.lst) $(CPPSRC:%.cpp=$(OBJDIR)/%.lst) $(ASRC:%.S=$(OBJDIR)/%.lst) 


# ����� ����������� ��� ������������� ������ ����������� (dependency files).
#  ���� ������� ��-�����������, �� ��� ������������� �������� ������.
GENDEPFLAGS = -MMD -MP -MF .dep/$(@F).d


# �������������� ���� ����������� � ������������ ������.
# ���������� �������� ���������� � ������.
ALL_CFLAGS = -mmcu=$(MCU) -I. $(CFLAGS) $(GENDEPFLAGS)
ALL_CPPFLAGS = -mmcu=$(MCU) -I. -x c++ $(CPPFLAGS) $(GENDEPFLAGS)
ALL_ASFLAGS = -mmcu=$(MCU) -I. -x assembler-with-cpp $(ASFLAGS)





# ���� �� ��������� (Default target).
all: begin gccversion sizebefore build sizeafter end

# ��������� ���� ������ (build target) ��� ������ HEX-����� ��� ����������.
build: elf hex eep lss sym extcoff
#������: lib


elf: $(TARGET).elf
hex: $(TARGET).hex
eep: $(TARGET).eep
lss: $(TARGET).lss
sym: $(TARGET).sym
LIBNAME=lib$(TARGET).a
lib: $(LIBNAME)



# Eye candy.
# AVR Studio 3.x �� ��������� ��� ������ �� make, �� ������� �� ��������� 
#  ��������� �����, ������� ���������� ������� ����������.
begin:
	@echo
	@echo $(MSG_BEGIN)

end:
	@echo $(MSG_END)
	@echo


# ����������� ������� �����.
HEXSIZE = $(SIZE) --target=$(FORMAT) $(TARGET).hex
ELFSIZE = $(SIZE) --mcu=$(MCU) --format=avr $(TARGET).elf

sizebefore:
	@if test -f $(TARGET).elf; then echo; echo $(MSG_SIZE_BEFORE); $(ELFSIZE); \
	2>/dev/null; echo; fi

sizeafter:
	@if test -f $(TARGET).elf; then echo; echo $(MSG_SIZE_AFTER); $(ELFSIZE); \
	2>/dev/null; echo; fi



# ����������� ������ �����������.
gccversion : 
	@$(CC) --version



# �������� ����������.
program: $(TARGET).hex $(TARGET).eep
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH) $(AVRDUDE_WRITE_EEPROM)


# ��������� ����� avr-gdb config/init ������� ������ ���������:
#     ������ ������ ������, ��������� ������� ����, ����������� � ����� �
#     ������������� ����� �������� � ���� main().
gdb-config: 
	@$(REMOVE) $(GDBINIT_FILE)
	@echo define reset >> $(GDBINIT_FILE)
	@echo SIGNAL SIGHUP >> $(GDBINIT_FILE)
	@echo end >> $(GDBINIT_FILE)
	@echo file $(TARGET).elf >> $(GDBINIT_FILE)
	@echo target remote $(DEBUG_HOST):$(DEBUG_PORT)  >> $(GDBINIT_FILE)
ifeq ($(DEBUG_BACKEND),simulavr)
	@echo load  >> $(GDBINIT_FILE)
endif
	@echo break main >> $(GDBINIT_FILE)

debug: gdb-config $(TARGET).elf
ifeq ($(DEBUG_BACKEND), avarice)
	@echo Starting AVaRICE - Press enter when "waiting to connect" message displays.
	@$(WINSHELL) /c start avarice --jtag $(JTAG_DEV) --erase --program --file \
	$(TARGET).elf $(DEBUG_HOST):$(DEBUG_PORT)
	@$(WINSHELL) /c pause

else
	@$(WINSHELL) /c start simulavr --gdbserver --device $(MCU) --clock-freq \
	$(DEBUG_MFREQ) --port $(DEBUG_PORT)
endif
	@$(WINSHELL) /c start avr-$(DEBUG_UI) --command=$(GDBINIT_FILE)




# ����������� ELF � COFF ��� ������������� ��� ������� / ��������� � AVR Studio ��� VMLAB.
COFFCONVERT = $(OBJCOPY) --debugging
COFFCONVERT += --change-section-address .data-0x800000
COFFCONVERT += --change-section-address .bss-0x800000
COFFCONVERT += --change-section-address .noinit-0x800000
COFFCONVERT += --change-section-address .eeprom-0x810000



coff: $(TARGET).elf
	@echo
	@echo $(MSG_COFF) $(TARGET).cof
	$(COFFCONVERT) -O coff-avr $< $(TARGET).cof


extcoff: $(TARGET).elf
	@echo
	@echo $(MSG_EXTENDED_COFF) $(TARGET).cof
	$(COFFCONVERT) -O coff-ext-avr $< $(TARGET).cof



# �������� �������� �������� ������ (.hex, .eep) �� ��������� ����� ELF.
%.hex: %.elf
	@echo
	@echo $(MSG_FLASH) $@
	$(OBJCOPY) -O $(FORMAT) -R .eeprom -R .fuse -R .lock $< $@

%.eep: %.elf
	@echo
	@echo $(MSG_EEPROM) $@
	-$(OBJCOPY) -j .eeprom --set-section-flags=.eeprom="alloc,load" \
	--change-section-lma .eeprom=0 --no-change-warnings -O $(FORMAT) $< $@ || exit 0

# �������� ������������ ����� �������� �� ��������� ����� ELF.
%.lss: %.elf
	@echo
	@echo $(MSG_EXTENDED_LISTING) $@
	$(OBJDUMP) -h -S -z $< > $@

# �������� ������� �������� �� ��������� ����� ELF.
%.sym: %.elf
	@echo
	@echo $(MSG_SYMBOL_TABLE) $@
	$(NM) -n $< > $@



# �������� ���������� �� ��������� ������.
.SECONDARY : $(TARGET).a
.PRECIOUS : $(OBJ)
%.a: $(OBJ)
	@echo
	@echo $(MSG_CREATING_LIBRARY) $@
	$(AR) $@ $(OBJ)


# ��������: �������� ��������� ����� ELF �� ��������� ������.
.SECONDARY : $(TARGET).elf
.PRECIOUS : $(OBJ)
%.elf: $(OBJ)
	@echo
	@echo $(MSG_LINKING) $@
	$(CC) $(ALL_CFLAGS) $^ --output $@ $(LDFLAGS)


# ����������: �������� ��������� ������ �� �������� ������ �� ����� C.
$(OBJDIR)/%.o : %.c
	@echo
	@echo $(MSG_COMPILING) $<
	$(CC) -c $(ALL_CFLAGS) $< -o $@ 


# ����������: �������� ��������� ������ �� �������� ������ �� ����� C++.
$(OBJDIR)/%.o : %.cpp
	@echo
	@echo $(MSG_COMPILING_CPP) $<
	$(CC) -c $(ALL_CPPFLAGS) $< -o $@ 


# ����������: �������� ������ ���������� �� �������� ������ �� ����� C.
%.s : %.c
	$(CC) -S $(ALL_CFLAGS) $< -o $@


# ����������: �������� ������ ���������� �� �������� ������ �� ����� C++.
%.s : %.cpp
	$(CC) -S $(ALL_CPPFLAGS) $< -o $@


# ���������������: �������� ��������� ������ �� �������� ������ �� ����� ����������.
$(OBJDIR)/%.o : %.S
	@echo
	@echo $(MSG_ASSEMBLING) $<
	$(CC) -c $(ALL_ASFLAGS) $< -o $@


# �������� �������������� ������������� (preprocessed) ��������� ��� �������������
#  � �������� ���-�������.
%.i : %.c
	$(CC) -E -mmcu=$(MCU) -I. $(CFLAGS) $< -o $@ 


# ����: ������� �������.
clean: begin clean_list end

clean_list :
	@echo
	@echo $(MSG_CLEANING)
	$(REMOVE) $(TARGET).hex
	$(REMOVE) $(TARGET).eep
	$(REMOVE) $(TARGET).cof
	$(REMOVE) $(TARGET).elf
	$(REMOVE) $(TARGET).map
	$(REMOVE) $(TARGET).sym
	$(REMOVE) $(TARGET).lss
	$(REMOVE) $(SRC:%.c=$(OBJDIR)/%.o)
	$(REMOVE) $(SRC:%.c=$(OBJDIR)/%.lst)
	$(REMOVE) $(SRC:.c=.s)
	$(REMOVE) $(SRC:.c=.d)
	$(REMOVE) $(SRC:.c=.i)
	$(REMOVEDIR) .dep


# �������� ����� ��� ��������� ������
$(shell mkdir $(OBJDIR) 2>/dev/null)


# ��������� ������ ������������ (dependency).
-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)


# ���������� ������ (phony) �����.
.PHONY : all begin finish end sizebefore sizeafter gccversion \
build elf hex eep lss sym coff extcoff \
clean clean_list program debug gdb-config


