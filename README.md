# Centinela del Dengue

Sistema de alerta temprana de brotes de dengue por municipio en Colombia. Proyecto integrador **Centinela** del curso *Profundización I: Redes Neuronales y Deep Learning* (EA-N-F-004), Maestría en Ciencia de Datos, Universidad Santo Tomás. Docente: Javier Mauricio Sierra.

**Equipo:** Sergio Alexander Cardozo Ovadia · Cesar Augusto Coy Velandia

## Problema

Anticipar, con una semana de ventaja, si un municipio entrará en brote de dengue: la incidencia semanal supera el límite superior de su canal endémico (cuartil 3 de la misma semana en los 5 años previos) con al menos 5 casos. El cliente son los programas de Enfermedades Transmitidas por Vectores (ETV) de las secretarías de salud de 10 municipios: Barranquilla, Bucaramanga, Cali, Cúcuta, Ibagué, Itagüí, Medellín, Montería, Neiva y Villavicencio.

## Fase 2 · Sistema multimodal (entrega 2026-11-21)

| Entregable | Dónde está |
| --- | --- |
| Cuaderno de Colab con las ramas A (CNN), B (LSTM/GRU) y C (fusión), ejecutado de principio a fin | [`notebooks/centinela_fase2.ipynb`](notebooks/centinela_fase2.ipynb) · [Abrir en Colab](https://colab.research.google.com/github/SergioCardozoCD/centinela-dengue/blob/main/notebooks/centinela_fase2.ipynb) |
| Informe técnico (PDF, 6 páginas + referencias) | [`informe/Informe_tecnico_Fase2_Cardozo_Coy.pdf`](informe/Informe_tecnico_Fase2_Cardozo_Coy.pdf) |
| Gráficas comentadas para el cliente | [`Resultados/figuras/`](Resultados/figuras/) (lecturas en las celdas 39 y 40 del cuaderno) |
| Panel interactivo (bonus) | [`Resultados/figuras/panel_centinela.html`](Resultados/figuras/panel_centinela.html): descargarlo y abrirlo en el navegador |
| Pesos de los modelos entrenados (`.pth`, 14 archivos, 222 MB) | [Release «Fase 2»](https://github.com/SergioCardozoCD/centinela-dengue/releases/tag/fase2) · huellas SHA-256 en [`Resultados/anexo_pesos.csv`](Resultados/anexo_pesos.csv) |
| Bitácora de IA y auditoría (E-14 a E-23, auditoría real E-14) | [`bitacora/bitacora-ia-fase2.md`](bitacora/bitacora-ia-fase2.md) · evidencias en [`bitacora/fase2/`](bitacora/fase2/) |
| Procedencia de los datos (SHA-256 de cada archivo y de las 551 escenas) | [`Resultados/anexo_procedencia.csv`](Resultados/anexo_procedencia.csv) |
| Script de descarga de SIVIGILA desde Colombia | [`scripts/descarga_sivigila_local.py`](scripts/descarga_sivigila_local.py) |

**Resultados principales**

- **Rama B (serie).** RNN simple, LSTM y GRU con ventana de 12 semanas y 3 semillas. Prediciendo el cambio frente a esta semana, las redes superan a la persistencia en el pronóstico de casos (prueba 2023–2025: RMSE de la LSTM 2,871 frente a 2,977). El desvanecimiento del gradiente es medible: a 51 semanas, la RNN recibe unas 750.000 veces menos señal que la GRU. Para la alerta de brote, el MLP de la Fase 1 sigue siendo el mejor con el mismo número de falsas alarmas.
- **Rama A (imagen).** ResNet50 y EfficientNet-B0 preentrenadas: la extracción de rasgos supera al ajuste fino, que sobreajusta con 383 imágenes. La mejor CNN (F1 macro 0,392 en prueba) no supera a un modelo que solo conoce el municipio (0,453): aprendió sobre todo qué ciudad es (Grad-CAM, celda 33).
- **Rama C (fusión).** La imagen no aporta: PR-AUC de 0,962 con la serie sola frente a 0,920 con la fusión (diferencia −0,040; IC 95 %: −0,128 a 0,000).
- **Para el cliente.** En 2023–2025 el sistema avisa con una semana de anticipación 794 de 832 semanas de brote, con unas 3,3 falsas alarmas por municipio y año.

## Fase 1 · Línea base con un MLP (entrega 2026-11-03)

| Entregable | Dónde está |
| --- | --- |
| Propuesta de Datos aprobada (v1, 2026-10-29) | [`propuesta/Propuesta_Datos_Fase1_v1.pdf`](propuesta/Propuesta_Datos_Fase1_v1.pdf) |
| Cuaderno de Colab (corre de principio a fin) | [`notebooks/centinela_fase1.ipynb`](notebooks/centinela_fase1.ipynb) · [Abrir en Colab](https://colab.research.google.com/github/SergioCardozoCD/centinela-dengue/blob/main/notebooks/centinela_fase1.ipynb) |
| Informe técnico-ético (PDF, 4 páginas + referencias) | [`informe/`](informe/) |
| Bitácora de IA y auditoría (E-1 a E-13, auditoría real E-4) | [`bitacora/bitacora-ia.md`](bitacora/bitacora-ia.md) |
| Script de descarga en R (verificación cruzada) | [`scripts/01_descarga_sivigila.R`](scripts/01_descarga_sivigila.R) |

**Resultado principal (prueba 2023–2025, una sola evaluación):** el MLP avisa el 95,4 % de las semanas en brote, con 88,9 % de alertas correctas y AUC 0,979, y anticipa 42 de los 73 inicios de brote, que la regla de persistencia nunca anticipa.

## Fases

| Fase | Módulo | Qué se construye | Estado |
| --- | --- | --- | --- |
| 1 | Fundamentos | Línea base: MLP sobre la serie de casos y clima aplanada a tabla | Entregada |
| 2 | Arquitecturas | LSTM/GRU sobre la serie + CNN sobre imágenes Sentinel-2 + fusión | Entregada |
| 3 | Implementación | Pipeline, GPU y despliegue | Pendiente |

## Fuentes de datos

| Modalidad | Fuente | Licencia |
| --- | --- | --- |
| Serie | SIVIGILA, Instituto Nacional de Salud (eventos 210 y 220), API del portal SIVIGILA (la misma que usa el paquete de R `sivirep`) | Datos abiertos del Estado (Ley 1712 de 2014) |
| Serie | NASA POWER (clima diario por coordenadas) | Uso libre con cita |
| Serie | DANE, proyecciones de población municipal (vía TRACE-LAC/`sivirep`) | Datos abiertos |
| Imagen | Cajas et al. (2024), *A multi-modal satellite imagery dataset for public health analysis in Colombia*, PhysioNet, v1.0.0, [doi.org/10.13026/xr5s-xe24](https://doi.org/10.13026/xr5s-xe24) | CC0 1.0 |

## Estructura

```
centinela-dengue/
├── README.md
├── propuesta/      Propuesta de Datos (Paso 0), firmada
├── notebooks/      Cuadernos de Google Colab (PyTorch): Fase 1 y Fase 2
├── informe/        Informes técnicos (PDF) de cada fase
├── Resultados/     Fase 2: gráficas para el cliente, panel interactivo y anexos (SHA-256, ablación)
├── bitacora/       Bitácoras de IA, auditorías y evidencias (fase2/)
└── scripts/        Descarga de SIVIGILA: en R (Fase 1) y en Python desde Colombia (Fase 2)
```

Los pesos (`.pth`) no están en las carpetas porque dos de ellos pesan 94 MB: van en el [Release «Fase 2»](https://github.com/SergioCardozoCD/centinela-dengue/releases/tag/fase2).

## Política de datos

Los casos de SIVIGILA son datos de salud (Ley 1581 de 2012, art. 5). Este repositorio **no publica microdatos ni tablas de casos**: las carpetas `data_raw/` y `data/` y los conteos de SIVIGILA se quedan en el computador del equipo. Los cuadernos reducen los datos de inmediato a conteos por municipio y semana y registran la huella SHA-256 de cada archivo descargado. Las imágenes de PhysioNet son de dominio público y no muestran personas.

## Cómo reproducir la Fase 2

1. Abrir el cuaderno con el botón **Abrir en Colab** y elegir **Entorno de ejecución → Cambiar tipo de entorno de ejecución → T4 GPU** (la CNN lo necesita).
2. **SIVIGILA:** desde noviembre de 2026 la API del INS no acepta conexiones desde Colab, que sale a internet desde Estados Unidos. Desde un computador en Colombia, correr `python scripts/descarga_sivigila_local.py` (unos 10 a 15 minutos). Produce `sivigila_conteos.csv` y `sivigila_procedencia.csv`.
3. En Colab, ejecutar la celda 0 y subir esos dos archivos a `/content/centinela_fase2/`.
4. **Entorno de ejecución → Ejecutar todas.** Tarda unos 40 minutos: la mayor parte es la descarga de las imágenes y el entrenamiento de las redes. Las redes de la serie corren en CPU y dan exactamente las mismas cifras; la CNN en GPU puede variar en milésimas.

## Uso de IA

El equipo usó Claude (Anthropic) como asistente de programación y redacción, bajo su dirección, y lo documenta en `bitacora/bitacora-ia.md` (Fase 1) y `bitacora/bitacora-ia-fase2.md` (Fase 2), según la plantilla del curso. El identificador de cada entrada aparece en el código que cambió: como comentario `# E-n` en la Fase 1 y al final del comentario inicial de cada celda en la Fase 2.
