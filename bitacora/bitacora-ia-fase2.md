# Bitácora de IA · Proyecto Centinela · Fase 2

Continúa la bitácora de la Fase 1 (`bitacora/bitacora-ia.md`, entradas E-1 a E-13). Se documentan las interacciones que cambiaron una decisión técnica: datos, arquitectura, métricas, un error resuelto o un enfoque descartado. A la IA no se le compartieron microdatos ni registros individuales.

## 1. Datos de la entrega

| Campo | Detalle |
| --- | --- |
| **Integrantes** | Sergio Alexander Cardozo Ovadia · Cesar Augusto Coy Velandia |
| **Proyecto** | Centinela del Dengue: alerta temprana de brotes por municipio en Colombia |
| **Fase** | Fase 2 · Sistema multimodal (CNN + LSTM/GRU + fusión) |
| **Primer identificador de esta fase** | E-14 |
| **Fecha de entrega** | 2026-11-21 |

## 2. Declaración de uso de IA

### Declaración de uso (la firma cada integrante)

Quienes firman declaran que durante esta fase usaron las siguientes herramientas de IA generativa:

- **Claude (Anthropic) · Claude Opus 5.5 (`claude-opus-5-5`)** → como asistente de programación y redacción, bajo la dirección del equipo: para explorar el conjunto de imágenes de PhysioNet; escribir, probar y depurar las celdas del cuaderno (control de calidad de las imágenes, rama B, rama A, fusión, auditoría, gráficas y panel); diagnosticar el bloqueo de la API del INS; y proponer los borradores de las lecturas del cuaderno, de esta bitácora y del informe técnico.

**Trabajo del equipo.** El equipo dirigió cada paso y no aceptó ninguna salida de la IA sin ejecutarla y revisarla:

- **Ejecución y revisión:** Sergio ejecutó en Colab la exploración y cada versión del cuaderno, la última de principio a fin con GPU, revisó cada salida y gráfica y compartió las capturas. Cesar revisó resultados y ejecutó partes del cuaderno en Colab.
- **Detección de fallos:** el equipo detectó en una figura que la misma ciudad aparecía en carpetas de municipios distintos, lo que reveló el fallo de la IA que se audita (E-14). También rechazó una indicación equivocada de la IA sobre el repositorio (E-19) y no aceptó el plan B que la IA ofreció para los datos de SIVIGILA (E-18).
- **Decisiones:** tomó con los datos a la vista las decisiones de diseño: zonas del canal como etiqueta de la CNN y partición por bloques (E-17), umbral de nubes (E-16), probar el objetivo «cambio» en la rama B en contra de la recomendación de la IA (E-20) y color de la imagen (E-21).
- **Datos:** descargó SIVIGILA desde su computador en Colombia con el mismo código del cuaderno cuando el INS bloqueó a Colab (E-18) y mantuvo los conteos fuera del repositorio.
- **Textos y entregables:** revisó las lecturas del cuaderno, esta bitácora, el informe y las diapositivas (Cesar participa en el informe y en la exposición), y aprobó la versión final de cada artefacto.

Quienes firman declaran también que **comprenden, verificaron y pueden defender** como propio cada artefacto entregado, que cada integrante responde en la sustentación por una parte distinta del trabajo y que esta bitácora refleja con honestidad cómo se usaron estas herramientas.

| Integrante | Firma | Fecha |
| --- | --- | --- |
| Sergio Alexander Cardozo Ovadia | _ SergioCardozo _ | 2026-11-21 |
| Cesar Augusto Coy Velandia | _ Cesar A Coy _ | 2026-11-21 |

## 3. Registro de interacciones

Cada interacción se marca como **Aceptada · Modificada · Rechazada**. La evidencia de origen (la salida literal de la IA o una captura con fecha y herramienta) es obligatoria en las entradas Modificada y Rechazada. El identificador de cada entrada aparece en el comentario inicial de la celda afectada del cuaderno (`· bitácora E-n`).

**Datos compartidos con la IA en esta fase:** salidas agregadas del cuaderno (conteos por municipio y año, métricas, tablas y gráficas), capturas de pantalla, mensajes de error y la respuesta en XML de la API del INS vista desde el navegador. Nunca microdatos de SIVIGILA ni registros individuales.

| ID | Fecha | Tema | Decisión | Aporte del equipo | Dónde está en el entregable |
| --- | --- | --- | --- | --- | --- |
| E-14 | 2026-11-17 | Imágenes «únicas» por ETag dentro de cada carpeta | Rechazada | **Detectó** en una figura la misma ciudad en carpetas distintas | Cuaderno, celdas 8 y 38 (auditoría) |
| E-15 | 2026-11-17 | Ubicación real por georreferencia y repetidas por contenido | Modificada | Ejecutó, reportó los errores y verificó la reasignación | Cuaderno, celdas 7 y 8 |
| E-16 | 2026-11-17 a 19 | Umbral de nubes | Aceptada | **Decidió** el umbral 0,30 con la tabla y los ejemplos | Cuaderno, celdas 9 y 10 |
| E-17 | 2026-11-17 | Etiqueta de 3 zonas y partición por bloques | Aceptada | **Decidió** la etiqueta, el objetivo de la serie y la partición | Cuaderno, celdas 5 y 12 |
| E-18 | 2026-11-18 a 19 | SIVIGILA bloqueado desde Colab | Modificada | **Rechazó el plan B**, pidió un diagnóstico a fondo y descargó los datos desde Colombia | Cuaderno, celda 2; script local |
| E-19 | 2026-11-19 | Indicación sobre `.gitignore` | Rechazada | **Corrigió a la IA**: la carpeta no es un repositorio git | Carpeta local `data/` (fuera del repositorio) |
| E-20 | 2026-11-19 | Objetivo «cambio» en la rama B | Aceptada | **Eligió probar la mejora** en contra de la recomendación de la IA | Cuaderno, celda 25 |
| E-21 | 2026-11-19 | Color de la imagen para la CNN | Aceptada | **Decidió** color verdadero más una prueba con falso color | Cuaderno, celdas 27 y 31 |
| E-22 | 2026-11-19 | Primera versión de la auditoría | Modificada | Ejecutó la corrección y verificó la cifra de 1.060 | Cuaderno, celda 38 |
| E-23 | 2026-11-19 | Validación del MLP en la ventana 2016–2018 | Aceptada | Ejecutó y revisó el resultado | Cuaderno, celda 15 |

### E-14

| Campo | Registro |
| --- | --- |
| **ID** | E-14 |
| **Fecha y hora** | 2026-11-17 ≈ 11:20 (reporte de la IA) · 12:24 (figura en la que el equipo vio el fallo) |
| **Fase · paso** | F2 · Rama A, paso 1 (exploración y calidad de las imágenes) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 8 (control de calidad) y celda 38 (auditoría) |
| **Objetivo de la consulta** | Saber cuántas imágenes distintas hay por municipio y si alcanzan el mínimo de 500 en 3 clases |
| **Indicación (resumen)** | Inventariar el subconjunto `10_municipalities` de PhysioNet y quitar las escenas vacías y repetidas |
| **Qué devolvió la IA** | Quitó las repetidas comparando el ETag de S3 (la huella del archivo) **dentro de cada carpeta** y dio por buenas 1.060 escenas (1.270 con contenido menos 210 copias de relleno), cada una con el municipio de su carpeta |
| **Datos compartidos con la IA** | Inventario de archivos (rutas, tamaños y ETag) y la figura de muestras por carpeta |
| **Decisión** | Rechazada |
| **Justificación** | **El equipo vio en la figura** la misma ciudad en carpetas de municipios distintos. Comparar el ETag carpeta por carpeta no puede ver que el mismo archivo está también en otra carpeta, ni que la carpeta no corresponde al municipio que muestra la escena. Unir la etiqueta de un municipio con la foto de otro es un pareo artificial entre modalidades, que la actividad no admite |
| **Cómo se verificó** | Con la georreferencia de cada escena (celda 8): las carpetas de Barranquilla, Bucaramanga, Itagüí, Montería y Neiva mezclan escenas de esos cinco municipios; la de Barranquilla, por ejemplo, tiene 25 escenas de Barranquilla, 30 de Itagüí y 18 de Bucaramanga. Tras reasignar y quitar repetidas quedan 748 escenas válidas. La auditoría de la sección 4 mide el efecto |
| **Evidencia de origen** | `bitacora/fase2/E-14a.jpg` (chat con Claude: la IA reporta las 1.060 escenas) · `bitacora/fase2/E-14b.png` (figura «Los 6 pares de imágenes más parecidos», Colab, 2026-11-17 12:24: la misma escena aparece en las carpetas de Barranquilla, Montería, Neiva y Bucaramanga) · `bitacora/fase2/E-14c.jpg` (salida de la verificación con la georreferencia) |

### E-15

| Campo | Registro |
| --- | --- |
| **ID** | E-15 |
| **Fecha y hora** | 2026-11-17 11:38 (primer error reportado por el equipo) |
| **Fase · paso** | F2 · Rama A, paso 1 (calidad de las imágenes) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celdas 7 (lectura de la georreferencia y reducción a 224 × 224) y 8 (reasignación y repetidas) |
| **Objetivo de la consulta** | Corregir el problema de E-14: saber qué municipio muestra cada escena y quitar las repetidas de verdad |
| **Indicación (resumen)** | Proponer una forma verificable de ubicar cada escena y de detectar repetidas |
| **Qué devolvió la IA** | Leer el punto de anclaje y el tamaño del píxel de cada GeoTIFF (`ModelTiepointTag`, `ModelPixelScaleTag`) y asignar la escena al municipio cuyo casco urbano cae dentro de su huella; detectar repetidas por contenido (firma de 28 × 28, diferencia media menor que 1). Las primeras versiones de las celdas exploratorias fallaron: `ValueError` al convertir el código «23001.0» y `KeyError: 'nubes'` por archivos de una versión anterior en la carpeta de trabajo |
| **Datos compartidos con la IA** | Mensajes de error, capturas y tablas agregadas por municipio y año |
| **Decisión** | Modificada |
| **Justificación** | El método se aceptó, pero el código necesitó correcciones que salieron de los errores que el equipo obtuvo al ejecutarlo. Con los errores a la vista, el equipo pidió borrar la exploración y rehacer el cuaderno con celdas ordenadas |
| **Cómo se verificó** | Celda 8: tabla de carpeta frente a municipio real; Cali, Cúcuta, Ibagué, Medellín y Villavicencio quedan intactas; 522 repetidas; 748 válidas, de 142 (Medellín) a 16 (Montería). Las escenas de Cúcuta de las semanas 25 y 41 de 2018 se ven casi iguales en el Grad-CAM (celda 33): la regla de repetidas puede dejar pasar algunas, y se declara como limitación |
| **Evidencia de origen** | `bitacora/fase2/E-15.png` (Colab, 2026-11-17 11:38: `ValueError: invalid literal for int() with base 10: '23001.0'`) |

### E-16

| Campo | Registro |
| --- | --- |
| **ID** | E-16 |
| **Fecha y hora** | 2026-11-17 12:19 (tabla de umbrales en la exploración) · 2026-11-18 ≈ 11:30 (recomendación de 0,30) |
| **Fase · paso** | F2 · Rama A, paso 1 (selección de imágenes) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celdas 9 (ejemplos por nivel de nubes y tabla de umbrales) y 10 (`UMBRAL_NUBES = 0.30`) |
| **Objetivo de la consulta** | Descartar las escenas cubiertas de nubes sin bajar del mínimo de 500 imágenes |
| **Indicación (resumen)** | Medir las nubes y mostrar cuántas imágenes quedan con cada umbral |
| **Qué devolvió la IA** | Medida de nubes (fracción de píxeles con azul ≥ 100), ejemplos por nivel y la tabla de umbrales; recomendó 0,30 |
| **Datos compartidos con la IA** | La tabla de umbrales y la figura de ejemplos |
| **Decisión** | Aceptada (**el equipo fijó** 0,30 en la celda 10) |
| **Justificación** | Es el umbral más estricto que cumple el mínimo de la actividad: 551 imágenes (con 0,20 serían 496) |
| **Cómo se verificó** | Celda 10: 551 imágenes en 10 municipios (Montería, la que menos, con 11). Limitación declarada: la medida no detecta bruma, nubes grises ni franjas sin datos |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-17

| Campo | Registro |
| --- | --- |
| **ID** | E-17 |
| **Fecha y hora** | 2026-11-17 ≈ 10:30 (etiquetas) · ≈ 12:45 (partición por bloques) |
| **Fase · paso** | F2 · Planeación (etiquetas y partición) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celdas 5 (tres etiquetas) y 12 (partición por bloques de 4 semanas) |
| **Objetivo de la consulta** | Cumplir las 3 categorías que pide la rama de imagen cuando la etiqueta de la Fase 1 es binaria, y partir las imágenes sin fuga |
| **Indicación (resumen)** | Opciones de etiqueta para la CNN y para la serie, y opciones de partición |
| **Qué devolvió la IA** | Para la CNN, las zonas del canal endémico (seguridad, alerta, brote) u otras opciones; para la serie, regresión de la incidencia con alerta derivada; para la partición, bloques de semanas en lugar de un corte por años o un reparto al azar |
| **Datos compartidos con la IA** | Proporción de zonas por año y por municipio (agregada) |
| **Decisión** | Aceptada (**el equipo eligió** las zonas del canal, la regresión de la incidencia y la partición por bloques) |
| **Justificación** | Las zonas del canal son las que ya usa la vigilancia en salud pública. Un reparto al azar dejaría la gemela casi exacta de cada imagen de prueba en entrenamiento; un corte por años dejaría la validación o la prueba sin alguna clase, porque 2017 casi no tuvo brotes (3 %) |
| **Cómo se verificó** | Celda 12: 383 / 83 / 85 imágenes, con las tres zonas en validación (12 alertas, 7 brotes) y en prueba (10 y 11) |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-18

| Campo | Registro |
| --- | --- |
| **ID** | E-18 |
| **Fecha y hora** | 2026-11-18 ≈ 09:35 (error en Colab) a 2026-11-19 10:36 (descarga local completa) |
| **Fase · paso** | F2 · Datos de la serie |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 2 (lee los conteos de la carpeta de trabajo si existen) · script `descarga_sivigila_local.py` (mismo código de la celda 2) |
| **Objetivo de la consulta** | Resolver el error `ConnectTimeout` de la celda 2 al descargar SIVIGILA desde Colab |
| **Indicación (resumen)** | Diagnosticar el error y proponer cómo seguir |
| **Qué devolvió la IA** | Primero, que podía ser una falla temporal o de conexión, con la opción de esperar o de usar el agregado del script de R (plan B). Después, a pedido del equipo, un diagnóstico por capas: el nombre del servidor resuelve (186.154.202.183), pero los puertos 443 y 80 no responden desde Colab, que sale a internet desde Estados Unidos (red de Google) |
| **Datos compartidos con la IA** | Mensajes de error, salida del diagnóstico y la respuesta XML de la API vista desde el navegador del equipo |
| **Decisión** | Modificada |
| **Justificación** | La primera explicación era equivocada: no era una falla temporal. **El equipo no aceptó el plan B** y pidió un diagnóstico a fondo; mantener la misma fuente y el mismo código de la Fase 1 conserva la trazabilidad. Desde su navegador en Colombia, la API respondía con la estructura esperada: el INS bloquea conexiones desde fuera del país o desde la nube. La solución fue correr el mismo código de la celda 2 en el computador del equipo y subir los conteos agregados a la sesión |
| **Cómo se verificó** | El script local (Python 3.13.5) devolvió 9.479 filas de 38 archivos y 563.245 casos, igual que la Fase 1; la celda 2 lo confirma («563.245 (Fase 1: 563.245)»). Los conteos no se publican en el repositorio |
| **Evidencia de origen** | `bitacora/fase2/E-18a.jpg` (error `ConnectTimeout` y respuesta inicial de la IA con el plan B) · `bitacora/fase2/E-18b.jpg` (diagnóstico por capas y respuesta de la API en el navegador) · `bitacora/fase2/E-18c.jpg` (salida del script local) |

### E-19

| Campo | Registro |
| --- | --- |
| **ID** | E-19 |
| **Fecha y hora** | 2026-11-19 10:41 |
| **Fase · paso** | F2 · Repositorio (política de datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Carpeta local del proyecto (los CSV de SIVIGILA quedaron en `data/`, fuera de lo que se sube a GitHub) |
| **Objetivo de la consulta** | Evitar que los conteos de SIVIGILA terminen en el repositorio público |
| **Indicación (resumen)** | Cómo proteger los archivos descargados en E-18 |
| **Qué devolvió la IA** | Agregar líneas a un archivo `.gitignore`, suponiendo que la carpeta era un repositorio git; el equipo pegó las líneas en PowerShell y obtuvo un error |
| **Datos compartidos con la IA** | Captura de la terminal y del explorador de archivos |
| **Decisión** | Rechazada |
| **Justificación** | **El equipo aclaró** que la carpeta no es un repositorio git: sube los archivos desde la página web de GitHub. El `.gitignore` no protegía nada. La IA reconoció el error; la solución fue mover los CSV a la carpeta `data/`, que no se sube |
| **Cómo se verificó** | El repositorio no contiene `sivigila_conteos.csv` ni `sivigila_procedencia.csv` |
| **Evidencia de origen** | `bitacora/fase2/E-19a.png` (VS Code, 2026-11-19 10:41: PowerShell rechaza las líneas que indicó la IA) · `bitacora/fase2/E-19b.jpg` (respuesta de la IA que reconoce que la carpeta no era un repositorio git) |

### E-20

| Campo | Registro |
| --- | --- |
| **ID** | E-20 |
| **Fecha y hora** | 2026-11-19 14:22 (opciones de la IA) · 14:35 (decisión del equipo) |
| **Fase · paso** | F2 · Rama B (mejora del modelo) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 25 (objetivo «cambio») y su lectura |
| **Objetivo de la consulta** | Decidir qué hacer porque ninguna red superaba a la persistencia en RMSE ni en MAE de prueba (celda 20) |
| **Indicación (resumen)** | Opciones con la entrega a dos días |
| **Qué devolvió la IA** | Dos opciones: dejar la rama B como estaba y analizar el resultado negativo (recomendada por la IA, para dedicar el tiempo a la CNN y la fusión), o probar que la red prediga el cambio frente a esta semana |
| **Datos compartidos con la IA** | Tablas agregadas de las celdas 20 a 24 |
| **Decisión** | Aceptada (**el equipo eligió probar la mejora**, en contra de la recomendación de la IA) |
| **Justificación** | Con una autocorrelación de 0,95 a una semana, la red gastaba su capacidad en reconstruir el nivel de la serie. Como la idea surgió después de ver la prueba, la elección entre «nivel» y «cambio» se fijó antes de correr y **solo con la validación**, y se declara en el cuaderno |
| **Cómo se verificó** | Celda 25: en validación, las tres redes superan a la persistencia (RMSE de 1,271 a 1,289, frente a 1,332); en prueba, la LSTM (2,871) y la GRU (2,911) la superan en RMSE y las tres en MAE. La regla eligió la RNN con objetivo «cambio» para la fusión, aunque con la prueba habría ganado la LSTM |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-21

| Campo | Registro |
| --- | --- |
| **ID** | E-21 |
| **Fecha y hora** | 2026-11-19 14:22 (opciones de la IA) · 14:35 (decisión del equipo) |
| **Fase · paso** | F2 · Rama A (entrada de la CNN) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celdas 27 (color verdadero) y 31 (prueba con falso color) |
| **Objetivo de la consulta** | Elegir qué 3 canales recibe la red preentrenada, cuando hay 4 bandas (azul, verde, rojo e infrarrojo cercano) |
| **Indicación (resumen)** | Opciones de entrada para la CNN |
| **Qué devolvió la IA** | Tres opciones: color verdadero con una prueba de falso color (recomendada), solo color verdadero, o solo falso color |
| **Datos compartidos con la IA** | Ninguno nuevo |
| **Decisión** | Aceptada (**el equipo eligió** color verdadero más la prueba) |
| **Justificación** | El color verdadero se parece más a las fotos con que se preentrenaron las redes; el infrarrojo muestra vegetación y agua, relacionadas con el hábitat del mosquito, así que vale la pena medirlo |
| **Cómo se verificó** | Celda 31: el falso color queda 0,030 por debajo en F1 macro de validación, dentro de la variación entre semillas (0,055): no se adopta. En prueba sale mejor (0,480), pero la prueba no se usa para elegir; queda como pista para la Fase 3 |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-22

| Campo | Registro |
| --- | --- |
| **ID** | E-22 |
| **Fecha y hora** | 2026-11-19 19:06 (salida de la primera versión) · 19:12 (corrección de la IA) · 19:18 (salida corregida) |
| **Fase · paso** | F2 · Auditoría a la IA |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 38 |
| **Objetivo de la consulta** | Medir cuánto habría cambiado el resultado si se hubiera aceptado la propuesta de E-14 |
| **Indicación (resumen)** | Construir el conjunto «contaminado» y entrenar con él la CNN ganadora |
| **Qué devolvió la IA** | Una primera versión que quitaba repetidas por ETag **en todo el conjunto** (758 escenas), no dentro de cada carpeta como en E-14. Con ella, la copia de una escena en otra carpeta desaparecía y la brecha medida salió casi nula (+0,003) |
| **Datos compartidos con la IA** | La salida de la celda 38 |
| **Decisión** | Modificada |
| **Justificación** | Esa versión no reproducía el error real, así que no lo medía. Al leer la salida que compartió el equipo (758, no 1.060), la IA reconoció su error y corrigió la celda para comparar el ETag carpeta por carpeta |
| **Cómo se verificó** | El equipo ejecutó la celda corregida: la primera línea reproduce exactamente las 1.060 escenas de E-14. Los resultados están en la sección 4 |
| **Evidencia de origen** | `bitacora/fase2/E-22.jpg` (salida de la primera versión con 758 y respuesta de la IA que reconoce el error) |

### E-23

| Campo | Registro |
| --- | --- |
| **ID** | E-23 |
| **Fecha y hora** | 2026-11-19 12:11 |
| **Fase · paso** | F2 · Compromiso de la Propuesta v1 |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 15 |
| **Objetivo de la consulta** | Cumplir lo prometido en la Propuesta de Datos: el MLP en la ventana 2016–2018 (entrenamiento 2016–2017, prueba 2018) |
| **Indicación (resumen)** | Incluir esa comparación en el cuaderno |
| **Qué devolvió la IA** | Que la Propuesta no reservó validación y, sin ella, no hay parada temprana ni umbral; propuso usar como validación el 20 % de los bloques de 4 semanas de 2016–2017, elegidos con semilla fija, y declarar la desviación |
| **Datos compartidos con la IA** | Ninguno nuevo |
| **Decisión** | Aceptada |
| **Justificación** | Mantiene la prueba prometida (todo 2018) y hace explícita la desviación en el cuaderno |
| **Cómo se verificó** | Celda 15: con solo 2016–2017, el MLP no supera a la persistencia en 2018 (F1 0,651 frente a 0,838) y no anticipa ninguno de los 10 inicios. Por eso la rama de la serie de la fusión se preentrena con 2012–2015 (celda 34) |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

## 4. Auditoría a la IA

**Tipo de auditoría** (se marca una):

- [x] **Real:** la IA produjo el fallo durante el proyecto.
- [ ] **Inducida y declarada.**

| Campo | Registro |
| --- | --- |
| **Entrada de la bitácora** | E-14 (y E-22, el error en la primera versión de la propia auditoría) |
| **Contexto** | Preparación de las imágenes de la rama A: de qué municipio es cada escena y cuáles están repetidas |
| **Qué dijo la IA** | Que había 1.060 escenas distintas, tras quitar repetidas por ETag dentro de cada carpeta, cada una con el municipio de su carpeta |
| **Evidencia de origen** | `bitacora/fase2/E-14a.jpg`, `E-14b.png` y `E-14c.jpg` (ver E-14) |
| **Por qué estaba mal** | El ETag solo detecta archivos idénticos dentro de lo que se compara. Comparado carpeta por carpeta, no ve que el mismo archivo está también en otra carpeta ni que la carpeta no corresponde al municipio que muestra la escena. Resultado: imágenes de una ciudad con la etiqueta epidemiológica de otra (pareo artificial entre modalidades) y la misma foto enseñada como zonas distintas |
| **Cómo se detectó** | **El equipo** vio en una figura de la exploración la misma ciudad en carpetas de municipios distintos; la georreferencia de cada escena lo confirmó (celda 8) |
| **Corrección aplicada** | Reasignar cada escena al municipio que muestra según su georreferencia y quitar repetidas por contenido (celdas 7 y 8, E-15): 748 escenas válidas y 551 tras el filtro de nubes |
| **Reproducción** | Celda 38: el conjunto que habría salido de la propuesta (ETag dentro de cada carpeta, municipio de la carpeta, mismo umbral de nubes y misma partición por bloques) y la CNN ganadora (ResNet50 con extracción de rasgos, semilla 2026) entrenada con él, evaluada en su propia prueba y en la prueba limpia |
| **Resultado de la medición** | La celda reproduce las 1.060 escenas. El conjunto contaminado tendría 808 imágenes en lugar de 551 (en apariencia, un 47 % más de datos), pero el 31 % (247) con el municipio de otra ciudad, el 41 % (333) repetidas en varias carpetas y 55 archivos con dos zonas distintas. La fuga entre entrenamiento y prueba es mínima (2 de 128 imágenes). **La CNN contaminada saca casi lo mismo en su propia prueba (F1 macro 0,281) que en la prueba limpia (0,285)**, pero frente a la CNN limpia (0,392) pierde 0,107 (−27 %); la exactitud balanceada baja de 0,474 a 0,378 |
| **Lección** | Un error en la preparación de los datos puede no verse en las métricas, porque contamina también la prueba: aquí la cifra reportada habría parecido coherente y el modelo habría sido un 27 % peor. Solo una verificación independiente del dato (mirar las imágenes y su georreferencia) lo detecta. Desde entonces, el equipo revisa visualmente las imágenes antes de aceptar un conteo de la IA. La propia auditoría tuvo un error de la IA (E-22), que se detectó porque la cifra no coincidía con la de E-14: cada número que la IA reporta se contrasta con una salida ejecutada |

## 5. Evidencias

Ya incluidas en `bitacora/fase2/` (capturas que el equipo compartió en el chat):

| Archivo | Qué muestra |
| --- | --- |
| `E-14b.png` | La figura de pares con la misma escena en carpetas de municipios distintos (2026-11-17 12:24) |
| `E-15.png` | El `ValueError` de la exploración (2026-11-17 11:38) |
| `E-19a.png` | El error de PowerShell con las líneas que indicó la IA (2026-11-19 10:41) |

Pendientes: capturas del chat con Claude que el equipo toma y guarda en `bitacora/fase2/` con estos nombres:

| Archivo | Qué debe mostrar | Dónde está en el chat |
| --- | --- | --- |
| `E-14a.jpg` | El mensaje de la IA con las 1.060 escenas | 17 nov, hacia las 11:20 |
| `E-14c.jpg` | La salida de la verificación con la georreferencia | 17 nov, después de las 12:24 |
| `E-18a.jpg` | El `ConnectTimeout` de la celda 2 y la primera respuesta de la IA (falla temporal, plan B) | 18 nov, hacia las 09:35 |
| `E-18b.jpg` | El diagnóstico por capas y la respuesta XML de la API en el navegador | 19 nov, en la mañana |
| `E-18c.jpg` | La salida del script local (563.245 casos) | 19 nov, 10:36 |
| `E-19b.jpg` | La respuesta de la IA que reconoce que la carpeta no era un repositorio git | 19 nov, después de las 10:41 |
| `E-22.jpg` | La salida de la primera versión de la auditoría (758) y la respuesta de la IA que reconoce el error | 19 nov, 19:06 y 19:12 |

*Horas en hora de Colombia. Las marcadas con «≈» son aproximadas: se reconstruyeron a partir de la hora de los archivos de trabajo de esa sesión; las demás corresponden a la hora del mensaje en el chat.*
