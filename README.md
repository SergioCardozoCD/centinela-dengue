# Centinela del Dengue

Sistema de alerta temprana de brotes de dengue por municipio en Colombia. Proyecto integrador **Centinela** del curso *Profundización I: Redes Neuronales y Deep Learning* (EA-N-F-004), Maestría en Ciencia de Datos, Universidad Santo Tomás. Docente: Javier Mauricio Sierra.

**Equipo:** Sergio Alexander Cardozo Ovadia · Cesar Augusto Coy Velandia

## Problema

Anticipar, con una semana de ventaja, si un municipio entrará en brote de dengue: la incidencia semanal supera el límite superior de su canal endémico (cuartil 3 de la misma semana en los 5 años previos) con al menos 5 casos. El cliente son los programas de Enfermedades Transmitidas por Vectores (ETV) de las secretarías de salud de 10 municipios: Barranquilla, Bucaramanga, Cali, Cúcuta, Ibagué, Itagüí, Medellín, Montería, Neiva y Villavicencio.

## Fase 1 · Entrega (2026-11-03)

| Entregable | Dónde está |
| --- | --- |
| Propuesta de Datos aprobada (v1, 2026-10-29) | [`propuesta/Propuesta_Datos_Fase1_v1.pdf`](propuesta/Propuesta_Datos_Fase1_v1.pdf) |
| Cuaderno de Colab (corre de principio a fin) | [`notebooks/centinela_fase1.ipynb`](notebooks/centinela_fase1.ipynb) · [Abrir en Colab](https://colab.research.google.com/github/SergioCardozoCD/centinela-dengue/blob/main/notebooks/centinela_fase1.ipynb) |
| Informe técnico-ético (PDF, 4 páginas + referencias) | [`informe/`](informe/) |
| Bitácora de IA y auditoría (E-1 a E-13, auditoría real E-4) | [`bitacora/bitacora-ia.md`](bitacora/bitacora-ia.md) |
| Script de descarga en R (verificación cruzada) | [`scripts/01_descarga_sivigila.R`](scripts/01_descarga_sivigila.R) |

**Resultado principal (prueba 2023–2025, una sola evaluación):** el MLP avisa el 95,4 % de las semanas en brote, con 88,9 % de alertas correctas y AUC 0,979, y anticipa 42 de los 73 inicios de brote, que la regla de persistencia nunca anticipa. Umbral de alerta: 0,306, elegido en validación para avisar al menos 9 de cada 10 brotes.

**Los cuatro puntos de la aprobación de la Propuesta** se resuelven en el cuaderno: Anexo B de procedencia con SHA-256 y búsqueda de Kaggle (celda 23), piso de 5 casos y métricas por municipio (celdas 9, 11 y 22), validación sin pandemia (celdas 19 y 21) y versión 1.0.0 de PhysioNet (sección 5).

## Fases

| Fase | Módulo | Qué se construye | Estado |
| --- | --- | --- | --- |
| 1 | Fundamentos | Línea base: MLP sobre la serie de casos y clima aplanada a tabla | Entregada |
| 2 | Arquitecturas | LSTM/GRU sobre la serie + CNN sobre imágenes Sentinel-2 + fusión | Pendiente |
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
├── notebooks/      Cuaderno de Google Colab (PyTorch)
├── informe/        Informe técnico-ético (PDF)
├── bitacora/       Bitácora de IA, auditoría y evidencias
└── scripts/        Descarga y agregación de datos en R
```

## Política de datos

Los casos de SIVIGILA son datos de salud (Ley 1581 de 2012, art. 5). Este repositorio **no publica microdatos ni tablas de casos**: las carpetas `data_raw/` y `data/` están en `.gitignore`. El cuaderno descarga los datos de la fuente oficial en cada ejecución, los reduce de inmediato a conteos por municipio y semana, y registra la huella SHA-256 de cada archivo (Anexo B).

## Cómo reproducir

1. Abrir el cuaderno con el botón **Abrir en Colab** de la tabla de arriba.
2. **Entorno de ejecución → Ejecutar todo.** Tarda unos 15 minutos, sobre todo por la descarga de SIVIGILA. No requiere GPU ni credenciales.
3. Opcional: `scripts/01_descarga_sivigila.R` reproduce la descarga en R; la celda 3 del cuaderno verifica que los totales de Python y de R coinciden.

## Uso de IA

El equipo usó Claude (Anthropic) como asistente de programación y redacción, bajo su dirección, y lo documenta en `bitacora/bitacora-ia.md`, según la plantilla del curso. El identificador de cada entrada aparece como comentario en el código que cambió (`# E-n`).
