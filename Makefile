all: ud1_1 ud1_2 ud1_2_1 ud1_2_2 ud1_2_3 ud2_1 ud2_2

LOCAL_URL=http://127.0.0.1:8000/

OUTPUT_DIR=./pdf/

UD1_DIR=ud1/
UD2_DIR=ud2/

gettitle=$(shell grep -m 1 '# ' $1 | sed -r 's/^# //')

UD1_1_MD=ud1-1-tecnologias

ud1_1: docs/$(UD1_DIR)$(UD1_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_MD) $(OUTPUT_DIR)$(UD1_1_MD).pdf "$(title)"

UD1_2_MD=ud1-2-sintaxis

ud1_2: docs/$(UD1_DIR)$(UD1_2_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_2_MD) $(OUTPUT_DIR)$(UD1_2_MD).pdf "$(title)"

UD1_2_1_MD=ud1-2-1-objetos

ud1_2_1: docs/$(UD1_DIR)$(UD1_2_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_2_1_MD) $(OUTPUT_DIR)$(UD1_2_1_MD).pdf "$(title)"

UD1_2_2_MD=ud1-2-2-arrays

ud1_2_2: docs/$(UD1_DIR)$(UD1_2_2_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_2_2_MD) $(OUTPUT_DIR)$(UD1_2_2_MD).pdf "$(title)"

UD1_2_3_MD=ud1-2-3-programacion-funcional

ud1_2_3: docs/$(UD1_DIR)$(UD1_2_3_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_2_3_MD) $(OUTPUT_DIR)$(UD1_2_3_MD).pdf "$(title)"

UD2_1_MD=ud2-1-DOM

ud2_1: docs/$(UD2_DIR)$(UD2_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD2_DIR)$(UD2_1_MD) $(OUTPUT_DIR)$(UD2_1_MD).pdf "$(title)"

UD2_2_MD=ud2-2-BOM

ud2_2: docs/$(UD2_DIR)$(UD2_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD2_DIR)$(UD2_2_MD) $(OUTPUT_DIR)$(UD2_2_MD).pdf "$(title)"

clean:
	rm $(OUTPUT_DIR)*
