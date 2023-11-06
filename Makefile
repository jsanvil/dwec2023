all: ud1_1 ud1_2 ud1_2_1 ud1_2_2 ud1_2_3 ud2_1 ud2_2 ud3_1 ud3_pr1

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

UD2_2_MD=ud2-2-BOMactividad

ud2_2: docs/$(UD2_DIR)$(UD2_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD2_DIR)$(UD2_2_MD) $(OUTPUT_DIR)$(UD2_2_MD).pdf "$(title)"

UD3_DIR=ud3/

UD3_1_MD=ud3-1-eventos

ud3_1: docs/$(UD3_DIR)$(UD3_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD3_DIR)$(UD3_1_MD) $(OUTPUT_DIR)$(UD3_1_MD).pdf "$(title)"

UD3_2_MD=ud3-2-formularios

ud3_2: docs/$(UD3_DIR)$(UD3_2_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD3_DIR)$(UD3_2_MD) $(OUTPUT_DIR)$(UD3_2_MD).pdf "$(title)"

UD4_DIR=ud4/

UD4_1_MD=ud4-1-oop

ud4_1: docs/$(UD4_DIR)$(UD4_1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD4_DIR)$(UD4_1_MD) $(OUTPUT_DIR)$(UD4_1_MD).pdf "$(title)"

UD4_2_MD=ud4-2-estructura

ud4_2: docs/$(UD4_DIR)$(UD4_2_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD4_DIR)$(UD4_2_MD) $(OUTPUT_DIR)$(UD4_2_MD).pdf "$(title)"

UD4_3_MD=ud4-3-mvc

ud4_3: docs/$(UD4_DIR)$(UD4_3_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(UD4_DIR)$(UD4_3_MD) $(OUTPUT_DIR)$(UD4_3_MD).pdf "$(title)"

PR_DIR=proyectos/

PR1_MD=pr1-clave-secreta

pr1: docs/$(PR_DIR)$(PR1_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(PR_DIR)$(PR1_MD) $(OUTPUT_DIR)$(PR1_MD).pdf "$(title)"

PR2_MD=pr2-todo-list

pr2: docs/$(PR_DIR)$(PR2_MD).md
	$(eval title := $(call gettitle, $<) )
	node exportpdf.js $(LOCAL_URL)$(PR_DIR)$(PR2_MD) $(OUTPUT_DIR)$(PR2_MD).pdf "$(title)"

clean:
	rm $(OUTPUT_DIR)*
