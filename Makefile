all: ud1_0 ud1_1 ud1_1_1 ud1_1_2 ud1_1_3

LOCAL_URL=http://127.0.0.1:8000/

OUTPUT_DIR=./pdf/

UD1_DIR=01-js/

UD1_0_MD=00-introduccion
UD1_0_TITLE='UD1 0. Introducción a Javascript'

ud1_0: docs/$(UD1_DIR)$(UD1_0_MD).md
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_0_MD) $(OUTPUT_DIR)$(UD1_0_MD).pdf $(UD1_0_TITLE)

UD1_1_MD=01-sintaxis
UD1_1_TITLE='UD1 1. Sintaxis'

ud1_1: docs/$(UD1_DIR)$(UD1_1_MD).md
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_MD) $(OUTPUT_DIR)$(UD1_1_MD).pdf $(UD1_1_TITLE)

UD1_1_1_MD=01.1-objetos
UD1_1_1_TITLE='UD1 1.1. Objetos en Javascript'

ud1_1_1: docs/$(UD1_DIR)$(UD1_1_1_MD).md
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_1_MD) $(OUTPUT_DIR)$(UD1_1_1_MD).pdf $(UD1_1_1_TITLE)

UD1_1_2_MD=01.2-arrays
UD1_1_2_TITLE='1.2. Arrays'

ud1_1_2: docs/$(UD1_DIR)$(UD1_1_2_MD).md
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_2_MD) $(OUTPUT_DIR)$(UD1_1_2_MD).pdf $(UD1_1_2_TITLE)

UD1_1_3_MD=01.3-programacion-funcional
UD1_1_3_TITLE='UD1 1.3. Programación funcional'

ud1_1_3: docs/$(UD1_DIR)$(UD1_1_3_MD).md
	node exportpdf.js $(LOCAL_URL)$(UD1_DIR)$(UD1_1_3_MD) $(OUTPUT_DIR)$(UD1_1_3_MD).pdf $(UD1_1_3_TITLE)

clean:
	rm $(OUTPUT_DIR)*
