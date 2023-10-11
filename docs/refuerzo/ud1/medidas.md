# UD1 Ejercicio de refuerzo 7: Conversión de medidas

Realiza un programa que pida una medida y la convierta a centímetros (cm), metros (m) o kilómetros (km), pulgadas (in), pies (ft), yardas (yd), millas (mi).

El programa debe pedir:

- La **medida** a convertir. Debe ser un número real.
- La **unidad de entrada**. Debe ser una de las siguientes: `cm`, `m`, `km`, `in`, `ft`, `yd`, `mi`.
- La **unidad de salida**. Debe ser una de las siguientes: `cm`, `m`, `km`, `in`, `ft`, `yd`, `mi`.

Debe comprobar que la unidad de entrada y salida son válidas.

El programa debe mostrar el resultado de la conversión.

_Ejemplo de uso:_

```
Introduce la medida: 1
Introduce la unidad de entrada: m
Introduce la unidad de salida: cm
1.0 m son 100.0 cm
```

```
Introduce la medida: 5
Introduce la unidad de entrada: in
Introduce la unidad de salida: ft
5.0 in son 0.41 ft
```

```
Introduce la medida: 21
Introduce la unidad de entrada: km
Introduce la unidad de salida: mi
21.0 km son 13.04 mi
```

```
Introduce la medida: 8.3
Introduce la unidad de entrada: yd
Introduce la unidad de salida: m
8.3 yd son 7.59 m
```

Alternativa: en lugar de pedir la unidad de entrada y salida, se puede pedir la unidad de salida y mostrar todas las conversiones posibles.

```
Introduce la medida: 1
Introduce la unidad de entrada: cm
1.0 cm son 0.0000062137 mi
1.0 cm son 0.0109361 yd
1.0 cm son 0.0328084 ft
1.0 cm son 0.393701 in
1.0 cm son 0.01 m
1.0 cm son 0.00001 km
```

```
