all: ud1_0 ud1_1 ud1_1_1 ud1_1_2 ud1_1_3

LOCAL_URL=http://127.0.0.1:8000/

OUTPUT_DIR=./pdf/

UD1_DIR=01-js/

UD1_0_MD=00-introduccion

gettitle=$(shell grep -m 1 '# ' $1 | sed -r 's/^# //')

ud1_0: docs/$(UD1_DIR)$(UD1_0_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_0_MD) $(OUTPUT_DIR)$(UD1_0_MD).pdf "$(title)"

UD1_1_MD=01-sintaxis

ud1_1: docs/$(UD1_DIR)$(UD1_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_MD) $(OUTPUT_DIR)$(UD1_1_MD).pdf "$(title)"

UD1_1_1_MD=01.1-objetos

ud1_1_1: docs/$(UD1_DIR)$(UD1_1_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_1_MD) $(OUTPUT_DIR)$(UD1_1_1_MD).pdf "$(title)"

UD1_1_2_MD=01.2-arrays

ud1_1_2: docs/$(UD1_DIR)$(UD1_1_2_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_2_MD) $(OUTPUT_DIR)$(UD1_1_2_MD).pdf "$(title)"

UD1_1_3_MD=01.3-programacion-funcional

ud1_1_3: docs/$(UD1_DIR)$(UD1_1_3_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_3_MD) $(OUTPUT_DIR)$(UD1_1_3_MD).pdf "$(title)"

clean:
	rm $(OUTPUT_DIR)*
