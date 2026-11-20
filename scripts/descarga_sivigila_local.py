# -*- coding: utf-8 -*-
"""
Centinela del Dengue · Fase 2 · Descarga de SIVIGILA desde un computador en Colombia.

Por qué existe: desde el 18 de noviembre de 2026, los servidores del INS no aceptan conexiones
desde Google Colab (que sale a internet desde Estados Unidos), pero sí desde Colombia. Este
script hace EXACTAMENTE lo mismo que la celda 2 del cuaderno de la Fase 2: descarga los
microdatos de los eventos 210 (dengue) y 220 (dengue grave) de 2007 a 2025 desde la API del
portal SIVIGILA, quita los registros descartados (ajuste 6 y D), los cuenta por municipio de
procedencia y semana, y descarta los microdatos de inmediato.

Qué produce (en la misma carpeta del script), solo agregados, sin datos personales:
  · sivigila_conteos.csv      → casos por municipio y semana epidemiológica
  · sivigila_procedencia.csv  → cada archivo descargado con su URL y su huella SHA-256
Esos dos archivos se suben a Colab en /content/centinela_fase2/ y la celda 2 los lee.

Requisitos: Python 3.9 o más reciente y las librerías:
  pip install pandas requests python-calamine openpyxl
Uso:  python descarga_sivigila_local.py      (tarda unos 10 a 15 minutos)
"""
import datetime
import hashlib
import io

import pandas as pd
import requests

ANIOS = list(range(2007, 2026))
DIVIPOLAS = ["05001", "05360", "08001", "23001", "41001", "50001", "54001", "68001", "73001", "76001"]
BASE_SIV = "https://portalsivigila.ins.gov.co/_api/"
EVENTOS = {"dengue": 210, "dengue grave": 220}          # el 580 (mortalidad) no se cuenta: auditoría E-4
COLUMNAS = ["cod_eve", "ano", "semana", "cod_dpto_o", "cod_mun_o", "ajuste"]
FECHA = datetime.date.today().isoformat()


def normalizar(col):
    return str(col).strip().lower().rstrip("_")          # el INS publica AJUSTE_, COD_EVE...


def archivos_del_anio(anio):
    consulta = (f"web/lists/GetByTitle('Microdatos')/items?$select=NombreEvento,A_x00f1_o,FileRef"
                f"&$filter=A_x00f1_o%20eq%20%27{anio}%27&$top=5000")
    r = requests.get(BASE_SIV + consulta, headers={"Accept": "application/json;odata=verbose"}, timeout=120)
    r.raise_for_status()
    return [(it["NombreEvento"], it["FileRef"]) for it in r.json()["d"]["results"]
            if it["NombreEvento"].strip().lower() in EVENTOS]


def leer_excel(contenido):
    try:
        return pd.read_excel(io.BytesIO(contenido), engine="calamine", dtype=str,
                             usecols=lambda c: normalizar(c) in COLUMNAS)
    except Exception:
        return pd.read_excel(io.BytesIO(contenido), engine="openpyxl", dtype=str,
                             usecols=lambda c: normalizar(c) in COLUMNAS)


def main():
    partes, procedencia = [], []
    for anio in ANIOS:
        for evento, ruta in archivos_del_anio(anio):
            url = BASE_SIV + f"Web/GetFileByServerRelativeUrl('{ruta}')/$value?binaryStringResponseBody=true"
            contenido = requests.get(url, timeout=600).content
            procedencia.append({"archivo": ruta.split("/")[-1], "url": url, "fecha_descarga": FECHA,
                                "sha256": hashlib.sha256(contenido).hexdigest()})
            df = leer_excel(contenido)
            df.columns = [normalizar(c) for c in df.columns]
            assert set(COLUMNAS) <= set(df.columns), f"Faltan columnas en {ruta}"
            df["ajuste"] = df["ajuste"].astype(str).str.strip().str.replace(r"\.0$", "", regex=True)
            df = df[~df["ajuste"].isin(["6", "D"])]
            df["divipola"] = (pd.to_numeric(df["cod_dpto_o"], errors="coerce").astype("Int64").astype(str).str.zfill(2)
                              + pd.to_numeric(df["cod_mun_o"], errors="coerce").astype("Int64").astype(str).str.zfill(3))
            df = df[df["divipola"].isin(DIVIPOLAS)]
            df["anio"] = pd.to_numeric(df["ano"], errors="coerce").astype(int)
            df["semana"] = pd.to_numeric(df["semana"], errors="coerce").astype(int)
            partes.append(df.groupby(["divipola", "anio", "semana"]).size().rename("casos").reset_index())
            del df, contenido                                   # se descartan los microdatos
        print(f"{anio} listo", flush=True)
    conteos = pd.concat(partes).groupby(["divipola", "anio", "semana"], as_index=False)["casos"].sum()
    conteos.to_csv("sivigila_conteos.csv", index=False)
    pd.DataFrame(procedencia).to_csv("sivigila_procedencia.csv", index=False)
    total = f"{conteos['casos'].sum():,}".replace(",", ".")
    print(f"\nListo: sivigila_conteos.csv ({len(conteos)} filas) y sivigila_procedencia.csv "
          f"({len(procedencia)} archivos). Casos en los 10 municipios: {total} (Fase 1: 563.245)")


if __name__ == "__main__":
    main()
