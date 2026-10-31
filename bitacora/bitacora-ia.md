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
| **Fecha de entrega** | _(AAAA-MM-DD)_ |

## 2. Declaración de uso de IA

### Declaración de uso (la firma cada integrante)

Quienes firman declaran que durante esta fase usaron las siguientes herramientas de IA generativa:

- **Claude (Anthropic) · Claude Opus 5.5 (`claude-opus-5-5`)** → para buscar y contrastar fuentes de datos, redactar el borrador de la Propuesta de Datos, escribir y depurar el script de descarga en R, _(completar: notebook, informe…)_.
- **_(otra herramienta, si se usa)_** → para _(propósito)_.

Partes del entregable redactadas o programadas sin IA: _(…)_.

Quienes firman declaran también que **comprenden, verificaron y pueden defender** como propio cada artefacto entregado, que cada integrante responde en la sustentación por una parte distinta del trabajo y que esta bitácora refleja con honestidad cómo se usaron estas herramientas.

| Integrante | Firma | Fecha |
| --- | --- | --- |
| Sergio Alexander Cardozo Ovadia | ______________________ | _(AAAA-MM-DD)_ |
| Cesar Augusto Coy Velandia | ______________________ | _(AAAA-MM-DD)_ |

## 3. Registro de interacciones

Cada interacción se marca como **Aceptada · Modificada · Rechazada**. La evidencia de origen (la salida literal de la IA, o una captura de pantalla con fecha y herramienta) es obligatoria en las entradas Modificada y Rechazada; en las Aceptadas es opcional. El identificador de cada entrada se escribe como comentario en la línea de código que cambió (`# E-3`).

### E-1

| Campo | Registro |
| --- | --- |
| **ID** | E-1 |
| **Fecha y hora** | 2026-10-27 _(hh:mm)_ |
| **Fase · paso** | F1 · Paso 0 (Propuesta de Datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | Propuesta de Datos, secciones 2 y 3 |
| **Objetivo de la consulta** | Verificar si el dengue cumple los requisitos de las tres fases, en especial una rama de imagen (≥ 500 imágenes, ≥ 3 clases) que no venga de Kaggle |
| **Indicación (resumen)** | Investigar a fondo fuentes de imagen y serie para un Centinela de dengue en Colombia |
| **Qué devolvió la IA** | Dos opciones válidas: (A) Sentinel-2 por municipio y semana de PhysioNet (CC0), con co-registro por (municipio, semana); (B) fotos de mosquitos de Ong y Ahmad (2022, CC BY 4.0), con alineación solo agregada. Descartó MosqVision-3K (Zenodo) por ser réplica de un conjunto de Kaggle |
| **Datos compartidos con la IA** | Ninguno |
| **Decisión** | Aceptada (opción A) |
| **Justificación** | El criterio 3 de la Fase 2 (30 %) premia el co-registro por muestra; la opción A lo permite con la clave (DIVIPOLA, semana epidemiológica). La opción B solo admite alineación agregada |
| **Cómo se verificó** | Se abrió la ficha de PhysioNet: licencia CC0 1.0, carpetas por código DIVIPOLA (10 municipios) y un archivo por semana (`image_2016-01-03.tiff` …). La prueba de acoplamiento del anexo A unió 10 filas reales |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

### E-2

| Campo | Registro |
| --- | --- |
| **ID** | E-2 |
| **Fecha y hora** | 2026-10-30 16:10 _(hh:mm)_ |
| **Fase · paso** | F1 · Paso 1 (preparación de datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | `scripts/01_descarga_sivigila.R`, bloque 3, función `descargar_anio()` |
| **Objetivo de la consulta** | Script en R que descargue SIVIGILA (dengue, 2007–2025) con `sivirep` |
| **Indicación (resumen)** | Escribir el script completo de descarga y agregación por municipio y semana |
| **Qué devolvió la IA** | `import_data_event(nombre_event = "dengue", years = anio)`, sin el argumento `ruta_dir` |
| **Datos compartidos con la IA** | Solo los mensajes de error de la consola |
| **Decisión** | Modificada |
| **Justificación** | Los 19 años fallaron con «argumento del nombre de archivo inválido». En el código fuente de `sivirep` 1.0.2, `obtener_ruta_dir()` ejecuta `dir.exists(ruta_dir)`; con `cache = FALSE` y `ruta_dir = NULL` eso es `dir.exists(NULL)`, que da ese error. Se agregó `ruta_dir` |
| **Cómo se verificó** | Se volvió a ejecutar: 19 de 19 años descargados, 1.757.820 casos × 68 columnas. Reproducción el 2026-10-30: el error indica "Error en dir.exists(ruta_dir)", la línea exacta identificada en el código fuente. |
| **Evidencia de origen** | bitacora/E-2a.png y E-2b.png (código original de la IA y su explicación, chat del 2026-10-30, 19:11 y 19:13) · bitacora/E-2.png (reproducción del error en R, 2026-10-30) |

### E-3

| Campo | Registro |
| --- | --- |
| **ID** | E-3 |
| **Fecha y hora** | 2026-10-30 18:32 |
| **Fase · paso** | F1 · Paso 1 (preparación de datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | `scripts/01_descarga_sivigila.R`, bloques 6 a 8 · etiqueta `# E-3` |
| **Objetivo de la consulta** | Excluir los casos descartados (ajuste 6 y D) antes de contar |
| **Indicación (resumen)** | Parte del mismo script de E-2 |
| **Qué devolvió la IA** | Filtro sobre una columna `ajuste_`, más una línea que la creaba vacía si no existía |
| **Datos compartidos con la IA** | Esquema (nombres de las 68 columnas) y conteos agregados |
| **Decisión** | Rechazada |
| **Justificación** | `sivirep` limpia los encabezados: la columna se llama `ajuste`. La línea «si no existe, créala vacía» ocultó el error: el filtro no excluyó nada y el script no avisó |
| **Cómo se verificó** | La salida mostraba `ajuste_` con 100 % de vacíos y una tabla con solo `<NA>` (1.757.820). Con `ajuste`: 0 = 1.133.267, 3 = 460.132, 5 = 69.566, 7 = 94.855. Se reemplazó la línea por un `stopifnot()` que detiene el script si falta la columna. El INS no publica casos con ajuste 6 ni D, así que el impacto en los conteos fue nulo |
| **Evidencia de origen** | `bitacora/E-3.png` (consola, 2026-10-30 18:32) · archivo `data/dengue_10mun_semana_v0_error_ajuste.csv` |

### E-4

| Campo | Registro |
| --- | --- |
| **ID** | E-4 |
| **Fecha y hora** | 2026-10-30 _(hh:mm)_ |
| **Fase · paso** | F1 · Paso 1 (preparación de datos) |
| **Integrante que hizo la consulta** | Sergio Cardozo |
| **Herramienta y modelo** | Claude (Anthropic) · Claude Opus 5.5 |
| **Celda o *commit* afectado** | `scripts/01_descarga_sivigila.R`, bloque 8 · etiqueta `# E-4` |
| **Objetivo de la consulta** | Definir qué eventos cuentan como caso |
| **Indicación (resumen)** | Revisión de la tabla de eventos (210, 220, 580) |
| **Qué devolvió la IA** | Contar solo 210 (dengue) y 220 (dengue grave); excluir 580 (mortalidad por dengue) para no contar dos veces |
| **Datos compartidos con la IA** | Conteos por código de evento |
| **Decisión** | Aceptada |
| **Justificación** | La primera versión del script contaba los tres eventos. El caso es la notificación de dengue o dengue grave; la muerte es un desenlace que se notifica como evento aparte |
| **Cómo se verificó** | Totales por municipio antes y después (p. ej., Medellín 57.383 → 57.343). _(Pendiente: confirmar en el protocolo de vigilancia de dengue del INS)_ |
| **Evidencia de origen** | _(opcional en Aceptada)_ |

## 4. Auditoría a la IA

_(Pendiente. E-3 es un fallo real y silencioso, pero sin efecto medible en los conteos; para el nivel Estratégico la auditoría debe reproducir un fallo con una métrica de decisión (recall, matriz o AUC) sobre los datos propios.)_

**Tipo de auditoría** (se marca una):

- [ ] **Real:** la IA produjo el fallo durante el proyecto.
- [ ] **Inducida y declarada.**

| Campo | Registro |
| --- | --- |
| **Entrada de la bitácora** | _(E-n)_ |
| **Contexto** | _(…)_ |
| **Qué dijo la IA** | _(…)_ |
| **Evidencia de origen** | _(…)_ |
| **Por qué estaba mal** | _(…)_ |
| **Cómo se detectó** | _(…)_ |
| **Corrección aplicada** | _(…)_ |
| **Reproducción** | _(celda con la versión de la IA · celda con la versión corregida · semilla · métrica)_ |
| **Resultado de la medición** | _(…)_ |
| **Lección** | _(…)_ |
