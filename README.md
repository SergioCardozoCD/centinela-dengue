# Centinela del Dengue

Sistema de alerta temprana de brotes de dengue por municipio en Colombia. Proyecto integrador **Centinela** del curso *Profundización I: Redes Neuronales y Deep Learning* (EA-N-F-004), Maestría en Ciencia de Datos, Universidad Santo Tomás. Docente: Javier Mauricio Sierra.

**Equipo:** Sergio Alexander Cardozo Ovadia · Cesar Augusto Coy Velandia

## Problema

Anticipar, con una semana de ventaja, si un municipio entrará en brote de dengue (incidencia semanal por encima del límite superior de su canal endémico). El cliente son los programas de Enfermedades Transmitidas por Vectores (ETV) de las secretarías de salud de 10 municipios: Barranquilla, Bucaramanga, Cali, Cúcuta, Ibagué, Itagüí, Medellín, Montería, Neiva y Villavicencio.

## Fases

| Fase | Módulo | Qué se construye | Estado |
| --- | --- | --- | --- |
| 1 | Fundamentos | Línea base: MLP sobre la serie de casos y clima aplanada a tabla | En curso |
| 2 | Arquitecturas | LSTM/GRU sobre la serie + CNN sobre imágenes Sentinel-2 + fusión | Pendiente |
| 3 | Implementación | Pipeline, GPU y despliegue | Pendiente |

## Fuentes de datos

| Modalidad | Fuente | Licencia |
| --- | --- | --- |
| Serie | SIVIGILA, Instituto Nacional de Salud (eventos 210 y 220), vía el paquete de R `sivirep` | Datos abiertos del Estado (Ley 1712 de 2014) |
| Serie | NASA POWER (clima diario por coordenadas) | Uso libre con cita |
| Imagen | Cajas et al. (2024), *A multi-modal satellite imagery dataset for public health analysis in Colombia*, PhysioNet, [doi.org/10.13026/xr5s-xe24](https://doi.org/10.13026/xr5s-xe24) | CC0 1.0 |

## Estructura

```
centinela-dengue/
├── README.md
├── propuesta/      Propuesta de Datos (Paso 0)
├── scripts/        Descarga y agregación de datos (R)
├── notebooks/      Cuadernos de Google Colab (PyTorch)
├── bitacora/       Bitácora de IA y evidencias
└── informe/        Informe técnico-ético
```

## Política de datos

Los casos de SIVIGILA son datos de salud (Ley 1581 de 2012, art. 5). Este repositorio **no publica microdatos ni tablas de casos**: las carpetas `data_raw/` y `data/` están en `.gitignore`. Los datos se reproducen desde la fuente primaria con `scripts/01_descarga_sivigila.R`, que imprime la huella SHA-256 del archivo agregado para verificar que es el mismo que usa el cuaderno.

## Reproducir la descarga

1. Instalar R (4.4 o superior).
2. Abrir `scripts/01_descarga_sivigila.R`, ajustar `dir_proyecto` y ejecutarlo completo.
3. El script crea `data/dengue_10mun_semana.csv` (10 municipios × 992 semanas, 2007–2025).

## Uso de IA

El equipo usa asistentes de IA generativa y lo documenta en `bitacora/bitacora-ia.md`, según la plantilla del curso.
