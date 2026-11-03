# Bitácora de IA · Proyecto Centinela

La bitácora se diligencia a lo largo del proyecto, no al final. No se registra cada indicación (*prompt*): se documentan las interacciones que cambiaron una decisión técnica (arquitectura, datos, métricas, un error resuelto, un enfoque descartado). Cada entrada lleva la fecha y la hora de la consulta, anotadas cuando ocurre.

A un asistente de IA no se le pegan ni se le suben registros con datos personales ni datos de terceros sin su permiso: se le muestran el esquema y filas sintéticas, y la bitácora registra qué datos se compartieron.

## 1. Datos de la entrega

| Campo | Detalle |
| --- | --- |
| **Integrantes** | Sergio Alexander Cardozo Ovadia · Cesar Augusto Coy Velandia |
| **Proyecto** | Centinela del Dengue: alerta temprana de brotes por municipio en Colombia |
| **Fase** | Fase 1 · MLP |
| **Primer identificador de esta fase** | E-1 |
| **Fecha de entrega** | 2026-11-03 |

## 2. Declaración de uso de IA

### Declaración de uso (la firma cada integrante)

Quienes firman declaran que durante esta fase usaron las siguientes herramientas de IA generativa:

- **Claude (Anthropic) · Claude Opus 5.5 (`claude-opus-5-5`)** → como asistente de programación y redacción, bajo la dirección del equipo: para buscar y contrastar fuentes de datos; proponer el borrador de la Propuesta de Datos; escribir y depurar el script de descarga en R y las celdas del cuaderno de Colab (descarga, canal endémico, variables, MLP, evaluación y auditoría); y proponer los borradores de los textos del cuaderno, de esta bitácora y del informe técnico-ético.

**Trabajo del equipo.** El equipo definió el problema y el cliente, dirigió cada paso y no aceptó ninguna salida de la IA sin ejecutarla y revisarla:

- **Definición y fuentes:** eligió el tema (dengue, con el café como alternativa), buscó en Kaggle posibles réplicas de las fuentes y las declaró y contrastó en la Propuesta, gestionó con el docente las dudas y la aprobación, y firmó la Propuesta.
- **Ejecución y revisión:** corrió el script de R en su equipo y todo el cuaderno en Colab (tres veces desde un entorno limpio), revisó cada salida y gráfica, y detectó o reportó los fallos registrados en E-2, E-3, E-6, E-11 y E-13.
- **Decisiones:** tomó con los datos a la vista las decisiones de diseño: piso de 5 casos (E-7), validación sin pandemia como sensibilidad (E-8), criterio del umbral (E-10), tamaño de la red (E-12) y el fallo que se audita (sección 4).
- **Repositorio y textos:** organizó el repositorio de GitHub (versiones, rutas y archivos), revisó y ajustó los textos del cuaderno y de esta bitácora, y aprobó la versión final de cada artefacto.

Quienes firman declaran también que **comprenden, verificaron y pueden defender** como propio cada artefacto entregado, que cada integrante responde en la sustentación por una parte distinta del trabajo y que esta bitácora refleja con honestidad cómo se usaron estas herramientas.

| Integrante | Firma | Fecha |
| --- | --- | --- |
| Sergio Alexander Cardozo Ovadia | ______________________ | 2026-11-03 |
| Cesar Augusto Coy Velandia | ______________________ | 2026-11-03 |

## 3. Registro de interacciones

Cada interacción se marca como **Aceptada · Modificada · Rechazada**. La evidencia de origen (la salida literal de la IA, o una captura de pantalla con fecha y herramienta) es obligatoria en las entradas Modificada y Rechazada; en las Aceptadas es opcional. El identificador de cada entrada se escribe como comentario en la línea de código que cambió (`# E-3`).

**Datos compartidos con la IA en todo el proyecto:** solo esquemas (nombres de columnas), mensajes de error y salidas agregadas del cuaderno (conteos por municipio y año, métricas del modelo, gráficas). Nunca microdatos de SIVIGILA ni registros individuales.

| ID | Fecha | Tema | Decisión | Aporte del equipo | Dónde está en el entregable |
| --- | --- | --- | --- | --- | --- |
| E-1 | 2026-10-27 | Fuente de imagen para la Fase 2 | Aceptada | Eligió la opción A; buscó réplicas en Kaggle y las declaró | Propuesta, secciones 2 y 3 y Anexo B |
| E-2 | 2026-10-30 | `ruta_dir` faltante en `sivirep` | Modificada | Ejecutó, reportó los 19 errores y reprodujo el fallo | `scripts/01_descarga_sivigila.R`, bloque 3 |
| E-3 | 2026-10-30 | Columna `ajuste_` inexistente | Rechazada | Ejecutó y compartió la salida que delató el fallo | Script de R, bloques 6–8; cuaderno, celda 2 |
| E-4 | 2026-10-30 | Evento 580 contado como caso | Modificada | Eligió este fallo para la auditoría y la ejecutó | Script de R, bloque 8; cuaderno, celdas 2, 24 y 25 |
| E-5 | 2026-11-02 | Descarga de SIVIGILA en Python | Aceptada | Ejecutó y verificó la igualdad con R | Cuaderno, celdas 2 y 3 |
| E-6 | 2026-11-02 | Estilo de las gráficas | Modificada | **Detectó** el problema y pidió el cambio | Cuaderno, celda 8b y celdas 9–10 |
| E-7 | 2026-11-02 | Piso de 5 casos para la etiqueta | Aceptada | **Decidió** entre cuatro opciones con los datos | Cuaderno, celdas 8, 9 y 11 |
| E-8 | 2026-11-02 | Validación sin pandemia | Aceptada | **Decidió** el esquema de validación | Cuaderno, celdas 13, 19 y 21 |
| E-9 | 2026-11-02 | Fallos de presentación en las gráficas | Modificada | Compartió las capturas, aplicó y revisó las correcciones | Cuaderno, celdas 9, 10 y 16 |
| E-10 | 2026-11-02 | Criterio del umbral de decisión | Aceptada | **Decidió** el criterio según el costo de los errores | Cuaderno, celda 20 |
| E-11 | 2026-11-02 | Caché del clima sin huellas SHA-256 | Modificada | **Detectó** los errores de ejecución y verificó desde cero | Cuaderno, celdas 4 y 23 |
| E-12 | 2026-11-02 | Comparación medida de la capacidad | Aceptada | Ejecutó y **decidió** el tamaño de la red | Cuaderno, celda 17b |
| E-13 | 2026-11-02 | Ubicación del cuaderno en GitHub | Rechazada | **Corrigió a la IA** y reorganizó el repositorio | `notebooks/centinela_fase1.ipynb` |

### E-1

| Campo | Registro |
| --- | --- |
| **ID** | E-1 |
| **Fecha y hora** | 2026-10-27 _(hh:mm)_ |
| **Fase · paso** | F1 · Paso 0 (Propuesta de Datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Propuesta de Datos, secciones 2 y 3 y Anexo B |
| **Objetivo de la consulta** | El equipo propuso el dengue como tema (con el café como alternativa) y pidió verificar si cumplía los requisitos de las tres fases, en especial una rama de imagen (≥ 500 imágenes, ≥ 3 clases) que no viniera de Kaggle |
| **Indicación (resumen)** | Investigar fuentes de imagen y serie para un Centinela de dengue en Colombia |
| **Qué devolvió la IA** | Dos opciones: (A) Sentinel-2 por municipio y semana de PhysioNet (CC0), con co-registro por (municipio, semana); (B) fotos de mosquitos de Ong y Ahmad (2022, CC BY 4.0), con alineación solo agregada. Descartó MosqVision-3K (Zenodo) por ser réplica de un conjunto de Kaggle |
| **Datos compartidos con la IA** | Ninguno |
| **Decisión** | Aceptada (el equipo eligió la opción A) |
| **Justificación** | El criterio 3 de la Fase 2 (30 %) premia el co-registro por muestra; la opción A lo permite con la clave (DIVIPOLA, semana epidemiológica). La opción B solo admite alineación agregada |
| **Cómo se verificó** | El equipo abrió la ficha de PhysioNet: licencia CC0 1.0, carpetas por código DIVIPOLA (10 municipios) y un archivo por semana (`image_2016-01-03.tiff` …). Además, **buscó en Kaggle** conjuntos parecidos y encontró dos (dengue en Colombia y dengue con clima 2010–2024); los declaró y contrastó en el Anexo B de la Propuesta, lo que el docente destacó en la aprobación. La prueba de acoplamiento del Anexo A unió 10 filas reales, y la celda 6 del cuaderno descarga una escena (código 200, 3.489.977 bytes) y registra su SHA-256 |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-2

| Campo | Registro |
| --- | --- |
| **ID** | E-2 |
| **Fecha y hora** | 2026-10-30 16:10 |
| **Fase · paso** | F1 · Paso 1 (preparación de datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | `scripts/01_descarga_sivigila.R`, bloque 3, función `descargar_anio()` |
| **Objetivo de la consulta** | Script en R que descargue SIVIGILA (dengue, 2007–2025) con `sivirep` |
| **Indicación (resumen)** | Escribir el script completo de descarga y agregación por municipio y semana |
| **Qué devolvió la IA** | `import_data_event(nombre_event = "dengue", years = anio)`, sin el argumento `ruta_dir` |
| **Datos compartidos con la IA** | Solo los mensajes de error de la consola |
| **Decisión** | Modificada |
| **Justificación** | Al ejecutar el script, el equipo obtuvo el error «argumento del nombre de archivo inválido» en los 19 años y lo reportó. En el código fuente de `sivirep` 1.0.2, `obtener_ruta_dir()` ejecuta `dir.exists(ruta_dir)`; con `cache = FALSE` y `ruta_dir = NULL` eso es `dir.exists(NULL)`, que da ese error. Se agregó `ruta_dir` |
| **Cómo se verificó** | El equipo volvió a ejecutar: 19 de 19 años descargados, 1.757.820 casos × 68 columnas. También **reprodujo el fallo** en R el 2026-10-30: el mensaje «Error en dir.exists(ruta_dir)» señala la línea exacta identificada en el código fuente |
| **Evidencia de origen** | `bitacora/bitacora E-2a.jpg` y `bitacora E-2b.jpg` (código original de la IA y su explicación, chat del 2026-10-30, 19:11 y 19:13) · `bitacora/bitacora E-2.jpg` (reproducción del error en R, 2026-10-30) |

### E-3

| Campo | Registro |
| --- | --- |
| **ID** | E-3 |
| **Fecha y hora** | 2026-10-30 18:32 |
| **Fase · paso** | F1 · Paso 1 (preparación de datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | `scripts/01_descarga_sivigila.R`, bloques 6 a 8 · etiqueta `# E-3`. En el cuaderno, celda 2 (`assert` de columnas y filtro de ajuste) |
| **Objetivo de la consulta** | Excluir los casos descartados (ajuste 6 y D) antes de contar |
| **Indicación (resumen)** | Parte del mismo script de E-2 |
| **Qué devolvió la IA** | Filtro sobre una columna `ajuste_`, más una línea que la creaba vacía si no existía |
| **Datos compartidos con la IA** | Esquema (nombres de las 68 columnas) y conteos agregados |
| **Decisión** | Rechazada |
| **Justificación** | `sivirep` limpia los encabezados: la columna se llama `ajuste`. La línea «si no existe, créala vacía» ocultó el error: el filtro no excluyó nada y el script no avisó |
| **Cómo se verificó** | La salida de crudeza que el equipo ejecutó y compartió mostraba `ajuste_` con 100 % de vacíos y una tabla con solo `<NA>` (1.757.820). Con `ajuste`: 0 = 1.133.267, 3 = 460.132, 5 = 69.566, 7 = 94.855. Se reemplazó la línea por un `stopifnot()` que detiene el script si falta la columna (en el cuaderno, un `assert`). El INS no publica casos con ajuste 6 ni D, así que el impacto en los conteos fue nulo. El equipo conservó la salida errónea como evidencia |
| **Evidencia de origen** | `bitacora/bitacora E-3.jpg` (consola, 2026-10-30 18:32) · archivo local `data/dengue_10mun_semana_v0_error_ajuste.csv` (no se publica: datos de salud) |

### E-4

| Campo | Registro |
| --- | --- |
| **ID** | E-4 |
| **Fecha y hora** | 2026-10-30 18:32 (misma revisión de salidas que E-3) |
| **Fase · paso** | F1 · Paso 1 (preparación de datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | `scripts/01_descarga_sivigila.R`, bloque 8 · etiqueta `# E-4`. En el cuaderno: celda 2 (`EVENTOS = {"dengue": 210, "dengue grave": 220}`) y auditoría en las celdas 24 y 25 |
| **Objetivo de la consulta** | Definir qué eventos cuentan como caso de dengue |
| **Indicación (resumen)** | Parte del mismo script de E-2; después, revisión de la tabla de casos por código de evento |
| **Qué devolvió la IA** | La primera versión del script contaba como caso los eventos 210 (dengue), 220 (dengue grave) y 580 (mortalidad por dengue) |
| **Datos compartidos con la IA** | Conteos agregados por código de evento y por municipio |
| **Decisión** | Modificada |
| **Justificación** | Según el protocolo de vigilancia del INS (2022), el 580 es un evento aparte: registra el desenlace fatal, y el caso fatal se define a partir de un caso de dengue grave. La incidencia se construye con los casos de dengue y dengue grave; sumar el 580 mezcla un desenlace con la incidencia y puede contar dos veces a la misma persona. Se dejaron solo 210 y 220 |
| **Cómo se verificó** | Totales por municipio antes y después en la salida del script que ejecutó el equipo (Medellín 57.383 → 57.343). El equipo eligió este fallo real para la auditoría, en lugar de una auditoría inducida, y ejecutó las celdas 24–25: el evento 580 tiene exactamente 40 registros en Medellín, la misma diferencia (sección 4) |
| **Evidencia de origen** | `bitacora/bitacora E-4.jpg` (chat con Claude del 2026-10-30: respuesta de la IA «Se sumaron los tres eventos: 210 (dengue), 220 (dengue grave) y 580 (mortalidad por dengue)», junto con la SALIDA C del script ejecutado por el equipo, donde aparecen 2.115 registros del evento 580 en el país) |

### E-5

| Campo | Registro |
| --- | --- |
| **ID** | E-5 |
| **Fecha y hora** | 2026-11-02 _(hh:mm)_ |
| **Fase · paso** | F1 · Paso 1 (preparación de datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celdas 2 (descarga) y 3 (verificación cruzada con R) |
| **Objetivo de la consulta** | Que el cuaderno de Colab cargue los datos desde la fuente primaria sin publicar microdatos de salud en el repositorio público |
| **Indicación (resumen)** | Replicar en Python la descarga que hace `sivirep` (API del portal SIVIGILA del INS) y agregar en memoria |
| **Qué devolvió la IA** | Una celda que consulta la lista `Microdatos` del portal, descarga los archivos de los eventos 210 y 220, registra su SHA-256, los reduce de inmediato a conteos por municipio y semana y descarta los microdatos |
| **Datos compartidos con la IA** | Salidas agregadas de la celda 3 (totales por municipio) |
| **Decisión** | Aceptada |
| **Justificación** | El repositorio es público y los casos son datos de salud (Ley 1581 de 2012): no se pueden subir. Descargar desde la fuente en cada ejecución hace el cuaderno reproducible sin publicar datos |
| **Cómo se verificó** | El equipo ejecutó las celdas en Colab y comprobó que la celda 3 coincide con los totales 2007–2025 de su propio script de R (SALIDA D del 2026-10-30) en los 10 municipios (`True`), con 1.705.604 casos de dengue y 50.101 de dengue grave en el país. Luego corrió el cuaderno completo tres veces desde un entorno limpio, con resultados idénticos |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-6

| Campo | Registro |
| --- | --- |
| **ID** | E-6 |
| **Fecha y hora** | 2026-11-02 18:31 |
| **Fase · paso** | F1 · Paso 1 (EDA) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 8b (estilo único) y celdas 9 y 10 (gráficas del EDA); el estilo se usa en todas las gráficas posteriores |
| **Objetivo de la consulta** | Gráficas del balance de la etiqueta por municipio y del canal endémico de Cali |
| **Indicación (resumen)** | Graficar el balance por municipio, la incidencia de Cali frente al Q3 y la proporción de brotes por año |
| **Qué devolvió la IA** | Gráficas con colores distintos en cada una (gris y rojo intenso en una; azul oscuro, rojo y naranja en otra), sin un significado común para cada color |
| **Datos compartidos con la IA** | Capturas de las gráficas y tablas agregadas |
| **Decisión** | Modificada |
| **Justificación** | **El equipo detectó** que las gráficas no compartían color ni estilo y que los colores eran pesados, y pidió unificarlas. Se creó la celda 8b con una paleta fija (azul = dato principal, naranja = lo que pide atención, gris = contexto), rejilla suave y títulos a la izquierda, y se agregó la gráfica de casos por año para que el argumento de la pandemia se viera |
| **Cómo se verificó** | El equipo volvió a correr las celdas 9 y 10 y revisó las gráficas en Colab; todas las gráficas siguientes usan la misma paleta. El par azul–naranja se validó para personas con daltonismo con un verificador de paletas |
| **Evidencia de origen** | `bitacora/bitacora E-6.jpg` (chat con Claude del 2026-11-02, 18:31: capturas de Colab con las primeras gráficas y la observación del equipo: «no deberíamos manejar el mismo color y estilo visual? también veo un poco pesados los colores») |

### E-7

| Campo | Registro |
| --- | --- |
| **ID** | E-7 |
| **Fecha y hora** | 2026-11-02 18:34 |
| **Fase · paso** | F1 · Paso 1 (EDA y etiqueta) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celdas 8 (etiqueta con y sin piso), 9 (balance por municipio) y 11 (decisión) |
| **Objetivo de la consulta** | Resolver el punto 2 de la aprobación de la Propuesta: la etiqueta de brote en municipios con pocos casos (Itagüí) |
| **Indicación (resumen)** | Calcular la etiqueta con y sin un mínimo de casos y mostrar el balance por municipio para decidir con los datos |
| **Qué devolvió la IA** | El código de las dos variantes y cuatro opciones: piso de 5 casos para todos, piso solo para Itagüí, sin piso o excluir Itagüí |
| **Datos compartidos con la IA** | Tabla agregada de la celda 9 (porcentajes por municipio) |
| **Decisión** | Aceptada (**el equipo eligió** el piso de 5 casos para los 10 municipios) |
| **Justificación** | En Itagüí el 76,5 % de las semanas tiene menos de 5 casos y en el 5,5 % el Q3 vale 0, así que sin piso 1 o 2 casos cuentan como brote. Una sola regla para todos es más fácil de defender que una hecha a la medida de un municipio, y en la práctica solo cambia a Itagüí. Excluirlo hacía perder uno de los 10 municipios con imágenes para la Fase 2 |
| **Cómo se verificó** | Celda 9: con el piso, Itagüí pasa de 26,1 % a 16,8 % de semanas en brote; Montería de 52,0 % a 51,7 %; los otros 8 no cambian. Celda 11: 2.602 positivos de 7.310 (35,6 %). En prueba, las métricas por municipio (celda 22) muestran que Itagüí sigue siendo el caso inestable (5 semanas de brote, precisión 0,20) |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-8

| Campo | Registro |
| --- | --- |
| **ID** | E-8 |
| **Fecha y hora** | 2026-11-02 18:48 |
| **Fase · paso** | F1 · Paso 1 (partición) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celdas 13 (dos esquemas de partición), 19 (entrenamiento sin pandemia) y 21 (comparación en prueba) |
| **Objetivo de la consulta** | Resolver el punto 3 de la aprobación: la validación 2020–2022 coincide con la pandemia de COVID-19 |
| **Indicación (resumen)** | Opciones para manejar la validación a la luz de la proporción de brotes por año (celda 10) |
| **Qué devolvió la IA** | Tres opciones: mantener la partición aprobada y agregar una validación sin pandemia como sensibilidad, cambiar la principal a la validación sin pandemia, o solo justificar por escrito |
| **Datos compartidos con la IA** | Proporción de semanas en brote por año (agregada) |
| **Decisión** | Aceptada (**el equipo eligió** la partición aprobada como principal más la validación sin pandemia: entrenamiento 2012–2018, validación 2019 y 2022) |
| **Justificación** | La validación 2020–2022 tiene 17,7 % de semanas en brote, frente a 35,8 % en entrenamiento y 53,0 % en prueba. Mantener la partición aprobada respeta la Propuesta firmada, y la comparación muestra el efecto en vez de solo describirlo |
| **Cómo se verificó** | Celda 19: con la validación de la pandemia la parada temprana se detiene en la época 18; sin pandemia, en la 31. Celda 21: el modelo sin pandemia elige un umbral más alto (0,520) y anticipa el 30,1 % de los inicios de brote, frente al 57,5 % del esquema aprobado |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-9

| Campo | Registro |
| --- | --- |
| **ID** | E-9 |
| **Fecha y hora** | 2026-11-02 18:47 – 19:21 |
| **Fase · paso** | F1 · Pasos 1 y 4 (EDA y regularización) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celdas 9 y 10 (leyendas y barras por año) y celda 16 (función `graficar_curvas`) |
| **Objetivo de la consulta** | Revisar las gráficas tal como se ven en Colab |
| **Indicación (resumen)** | El equipo compartió capturas de cada salida para revisarlas antes de seguir |
| **Qué devolvió la IA** | Tres fallos de presentación en su propio código, visibles en las capturas: (1) la leyenda se montaba sobre el título en Colab; (2) la gráfica de brotes por año mostraba una barra de 2011 armada con solo 10 filas (la última semana de 2011 etiquetada con la primera de 2012); (3) el recuadro blanco del texto «época óptima» tapaba un tramo de la curva de validación y parecía un corte |
| **Datos compartidos con la IA** | Capturas de las gráficas |
| **Decisión** | Modificada |
| **Justificación** | (1) La leyenda pasó debajo del título; (2) la proporción por año se calcula con la etiqueta de la propia semana, así cada año tiene sus 52 o 53 semanas y la serie empieza en 2012; (3) el texto se movió al borde superior, junto a la línea naranja |
| **Cómo se verificó** | El equipo aplicó los cambios en Colab, volvió a correr las celdas y revisó el resultado: sin solapamientos, años 2012–2025 y curvas continuas |
| **Evidencia de origen** | `bitacora/bitacora E-9.jpg` (chat con Claude del 2026-11-02, 18:47–19:01: capturas de Colab compartidas por el equipo y respuesta de la IA que reconoce que «en Colab la leyenda se monta sobre el título», con la corrección) |

### E-10

| Campo | Registro |
| --- | --- |
| **ID** | E-10 |
| **Fecha y hora** | 2026-11-02 19:23 |
| **Fase · paso** | F1 · Paso 5 (evaluación y ética) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 20 (umbral) y celda 21 (evaluación en prueba) |
| **Objetivo de la consulta** | Elegir el umbral de decisión según el costo de los errores para el cliente |
| **Indicación (resumen)** | Opciones para fijar el umbral en validación |
| **Qué devolvió la IA** | Cuatro criterios: *recall* ≥ 0,90, máximo F1, máximo F2 o 0,5 fijo |
| **Datos compartidos con la IA** | Métricas agregadas de validación |
| **Decisión** | Aceptada (**el equipo eligió** el umbral más alto con *recall* ≥ 0,90 en validación) |
| **Justificación** | Para un programa de ETV, un brote no anticipado (falso negativo) cuesta más que una falsa alarma: retrasa el control del vector y la preparación de la red de atención. Una meta explícita de *recall* traduce ese costo en una regla, y supera a la persistencia (*recall* 0,842 en validación) |
| **Cómo se verificó** | Celda 20: umbral 0,306, con *recall* 0,903 y precisión 0,854 en validación (con 0,5 el *recall* era 0,831). Celda 21, usada una sola vez: en prueba, *recall* 0,954, precisión 0,889, 38 FN y 99 FP; anticipa 42 de 73 inicios de brote |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-11

| Campo | Registro |
| --- | --- |
| **ID** | E-11 |
| **Fecha y hora** | 2026-11-02 19:40 – 20:36 |
| **Fase · paso** | F1 · Paso 1 (procedencia, punto 1 de la aprobación) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 4 (clima con caché) y celda 23 (Anexo B) |
| **Objetivo de la consulta** | Que el Anexo B muestre la fecha y el SHA-256 de los 10 archivos de clima y de la imagen |
| **Indicación (resumen)** | Revisar el cuaderno guardado en GitHub antes de agregar el Anexo B |
| **Qué devolvió la IA** | Un fallo en su propio código: si la celda 4 leía el clima de la caché, no registraba las 10 huellas de NASA POWER y el Anexo B quedaba incompleto. Su primera corrección leía un archivo de huellas que no existía en la caché anterior |
| **Datos compartidos con la IA** | Los mensajes de error de la celda 4 |
| **Decisión** | Modificada |
| **Justificación** | **Al ejecutar, el equipo encontró** que la corrección fallaba con `FileNotFoundError` y lo reportó. La versión final solo usa la caché si también existe el archivo de huellas; si falta, vuelve a descargar el clima. La celda 23 tiene un `assert` que exige las 11 huellas (10 de clima y 1 de imagen) |
| **Cómo se verificó** | El equipo borró el entorno de Colab y corrió todo el cuaderno desde cero: la celda 23 registra 68 archivos (38 de SIVIGILA, 10 de NASA POWER, 19 del DANE, 1 de PhysioNet), con las 11 huellas completas y 0 coincidencias de «kaggle» |
| **Evidencia de origen** | `bitacora/bitacora E-11.jpg` (chat con Claude del 2026-11-02, 19:43: captura de Colab con el `FileNotFoundError` de la celda 4 reportado por el equipo y respuesta de la IA: «El error es mío») |

### E-12

| Campo | Registro |
| --- | --- |
| **ID** | E-12 |
| **Fecha y hora** | 2026-11-02 21:13 |
| **Fase · paso** | F1 · Paso 2 (arquitectura) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Cuaderno, celda 17b y su lectura |
| **Objetivo de la consulta** | Revisar el cuaderno contra la rúbrica v1.4 antes de cerrarlo |
| **Indicación (resumen)** | Verificar que cada criterio de la rúbrica tenga evidencia en el cuaderno |
| **Qué devolvió la IA** | Que el criterio 2 (nivel Estratégico) pide justificar la capacidad con al menos una comparación medida, y una celda que entrena tres tamaños con la misma semilla |
| **Datos compartidos con la IA** | La tabla de salida de la celda 17b |
| **Decisión** | Aceptada |
| **Justificación** | La primera capa de 56 neuronas venía de la regla de partida del curso (2 × variables), pero no estaba contrastada con otros tamaños |
| **Cómo se verificó** | El equipo ejecutó la celda 17b: 16 → 8 (609 parámetros) logra val mínima 0,1253 y AUC 0,9821; 56 → 28 (3.249), 0,1200 y 0,9831; 128 → 64 (12.033), 0,1151 y 0,9853, pero sube a 0,1403 en la época 50. Con esos resultados, **el equipo decidió mantener** 56 → 28: la ventaja de la red grande es pequeña, sale de una sola semilla y usa más parámetros que filas de entrenamiento |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-13

| Campo | Registro |
| --- | --- |
| **ID** | E-13 |
| **Fecha y hora** | 2026-11-02 21:46 – 21:55 |
| **Fase · paso** | F1 · Entrega (repositorio) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Repositorio: `notebooks/centinela_fase1.ipynb` (commit «Versión final del cuaderno en notebooks/») |
| **Objetivo de la consulta** | Confirmar que la versión final del cuaderno quedó en GitHub |
| **Indicación (resumen)** | Revisar el repositorio después de guardar desde Colab |
| **Qué devolvió la IA** | Que la versión final no estaba en GitHub, porque solo revisó la ruta `notebooks/centinela_fase1.ipynb`, donde seguía la versión anterior |
| **Datos compartidos con la IA** | Capturas del repositorio |
| **Decisión** | Rechazada |
| **Justificación** | **El equipo revisó el repositorio y mostró** que la versión final sí estaba, guardada en la raíz como `centinela_fase1_1.ipynb`. La conclusión de la IA era incorrecta. Con eso, el equipo guardó el cuaderno en la ruta que cita el README y borró la copia de la raíz, para que quedara una sola versión |
| **Cómo se verificó** | En GitHub queda un solo cuaderno, `notebooks/centinela_fase1.ipynb`: 62 celdas, 28 de código ejecutadas en orden, sin errores |
| **Evidencia de origen** | `bitacora/bitacora E-13.jpg` (chat con Claude del 2026-11-02, 21:50–21:51: la IA afirma que el cuaderno «sigue la versión anterior»; el equipo responde con la captura de GitHub y la IA reconoce «Tienes razón») |

## 4. Auditoría a la IA

**Tipo de auditoría** (se marca una):

- [x] **Real:** la IA produjo el fallo durante el proyecto.
- [ ] **Inducida y declarada.**

El equipo eligió auditar un fallo real del proyecto (E-4) en lugar de reproducir un caso ya publicado por el curso, como la doble sigmoide.

| Campo | Registro |
| --- | --- |
| **Entrada de la bitácora** | E-4 |
| **Contexto** | Construcción de la serie de casos semanales por municipio, de la que salen la incidencia, el canal endémico y la etiqueta de brote |
| **Qué dijo la IA** | La primera versión del script de descarga (`scripts/01_descarga_sivigila.R`) contaba como caso los eventos 210 (dengue), 220 (dengue grave) y 580 (mortalidad por dengue) |
| **Evidencia de origen** | `bitacora/bitacora E-4.jpg` (ver E-4) |
| **Por qué estaba mal** | Según el protocolo de vigilancia del INS (2022), el 580 es un evento aparte que registra el desenlace fatal; el caso fatal se define a partir de un caso de dengue grave. La incidencia se construye con los casos de dengue y dengue grave: sumar el 580 mezcla un desenlace con la incidencia y puede contar dos veces a la misma persona |
| **Cómo se detectó** | Al revisar la tabla de casos por código de evento en la salida del script de R que ejecutó el equipo, antes de modelar |
| **Corrección aplicada** | Contar solo 210 y 220 (`# E-4` en el script de R; en el cuaderno, `EVENTOS` de la celda 2) |
| **Reproducción** | Celda 24: descarga del evento 580 desde la misma API del INS (19 archivos, 2007–2025). Celda 25: la misma tubería (canal, etiqueta, variables, partición aprobada), la misma semilla (2026), el mismo MLP, el mismo criterio de umbral y 50 épocas, con la serie de la IA (210 + 220 + 580) y con la corregida (210 + 220). Las dos se miden en prueba contra la etiqueta correcta. Una corrida de control confirma que la tubería reproduce exactamente el modelo final (`True`). El equipo ejecutó las dos celdas en Colab |
| **Resultado de la medición** | La versión de la IA sumaba 495 muertes en los 10 municipios (entre 0,02 % y 0,14 % de los casos). En Medellín son 40, la misma diferencia que mostró el script de R (57.383 frente a 57.343). Cambiaron 5 de 7.300 etiquetas. En prueba 2023–2025: AUC 0,9790 frente a 0,9789; *recall* 0,9555 frente a 0,9543 (37 FN frente a 38); FP 100 frente a 99; *recall* de inicio 0,589 frente a 0,575 (un inicio de 73). Época óptima 18 en ambas; umbral 0,311 frente a 0,306 |
| **Lección** | El fallo era real y conceptual, pero se midió en lugar de suponerlo: en estos 10 municipios su efecto sobre la decisión fue despreciable porque la letalidad del dengue es muy baja. Sería más grave en municipios pequeños, en años de alta letalidad o en cualquier reporte de incidencia a la secretaría de salud. La definición de caso se verifica contra el protocolo de vigilancia, no contra lo que «suena razonable» |

**Referencia.** Instituto Nacional de Salud. (2022). *Protocolo de vigilancia en salud pública de dengue (código 210-220-580)*. https://www.saludcapital.gov.co/CTDLab/Publicaciones/2022/Prot_vigilancia_Dengue.pdf
