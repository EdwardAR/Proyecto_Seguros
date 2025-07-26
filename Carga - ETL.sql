
--====================CARGAS(para 3 TABLAS)====================

SELECT COUNT(*)AS 'Cantidad de datos de [BD_CLIENTE]' FROM [BD_SEGUROS].[dbo].[BD_CLIENTE]
--902284
--AHORA CON LA PRIMERA CARGA
--1198856
--AHORA CON LA SEGUNDA CARGA
--1495428
--YA LIMPIA 1369783


SELECT COUNT(*)AS 'Cantidad de datos de [BD_TB_SEGURO]' FROM [BD_SEGUROS].[dbo].[BD_TB_SEGURO]
--1129733
--AHORA CON LA PRIMERA CARGA
--1423305
--AHORA CON LA SEGUNDA CARGA
--1719877
select*from[dbo].[BD_AGENCIAS]

SELECT COUNT(*)AS 'Cantidad de datos de [TB_PRODUCTOS_FINANCIEROS]' FROM [BD_SEGUROS].[dbo].[TB_PRODUCTOS_FINANCIEROS]
--902284
--AHORA CON LA PRIMERA CARGA
--1198856
--AHORA CON LA SEGUNDA CARGA
--1495428

SELECT*FROM [dbo].[DIM_AGENCIA]
-- ==================== [dbo].[BD_AGENCIAS] ====================
SELECT  * FROM [dbo].[BD_AGENCIAS]
SELECT  * FROM [dbo].BD_CLIENTE

SELECT DISTINCT COD_AGENCIA FROM [dbo].[BD_AGENCIAS]
SELECT COD_AGENCIA,COUNT(COD_AGENCIA) AS 'CNT_COD_AGENCIA' FROM [dbo].[BD_AGENCIAS] GROUP BY COD_AGENCIA

SELECT DISTINCT BANCA FROM [dbo].[BD_AGENCIAS]
SELECT BANCA,COUNT(BANCA) AS 'CNT_BANCA' FROM [dbo].[BD_AGENCIAS] GROUP BY BANCA
--==========================
--SIN ESPECIFICAR		29 |
--==========================
--NEGOCIOS				4
--EMPRESA				35
--MERCADOS				30
--INVERSIONES			16
--ADMINISTRATIVA		765
--RED AGENCIAS			418

--CAMBIO DE DATOS SIN ESPECIFICAR A DESCONOCIDO EN LA COLUMMNA "BANCA"
UPDATE [dbo].[BD_AGENCIAS] SET BANCA = 'DESCONOCIDO' WHERE BANCA = 'SIN ESPECIFICAR';
-- SELECT BANCA,COUNT(BANCA) AS 'CNT_BANCA' FROM [dbo].[BD_AGENCIAS] WHERE BANCA = 'DESCONOCIDO' GROUP BY BANCA 

--create database BDS_SEGUROS

SELECT DISTINCT ZONA FROM [dbo].[BD_AGENCIAS]
SELECT ZONA,COUNT(ZONA) AS 'CNT_ZONA' FROM [dbo].[BD_AGENCIAS] GROUP BY ZONA
--==============================
--SIN ESPECIFICAR			29 |
--==============================
--PROVINCIA SUR				40
--NEGOCIOS					4 → NO ES ZONA
--LIMA NORTE				33
--LIMA CENTRO				71
--EMPRESA					35 → NO ES ZONA
--MERCADOS					30 → NO ES ZONA
--LIMA SUR					26
--INVERSIONES				16 → NO ES ZONA
--ADMINISTRATIVA			765 → NO ES ZONA
--PROVINCIA CENTRO ORIENTE	32
--LIMA OESTE				34
--LIMA ESTE					32
--LIMA MODERNA				91
--PROVINCIA NORTE			43
--CENTRO NEGOCIOS			16 → NO ES ZONA
SELECT*FROM [dbo].[BD_TB_SEGURO]
--CAMBIO DE DATOS SIN ESPECIFICAR A DESCONOCIDO EN LA COLUMMNA "ZONA"
UPDATE [dbo].[BD_AGENCIAS] SET ZONA = 'DESCONOCIDO' WHERE ZONA = 'SIN ESPECIFICAR';
--CAMBIO DE DATOS SIN ESPECIFICAR A DESCONOCIDO EN LA COLUMMNA "ZONA"
UPDATE [dbo].[BD_AGENCIAS] SET ZONA = 'DESCONOCIDO' WHERE ZONA IN ('NEGOCIOS', 'EMPRESA', 'MERCADOS', 'INVERSIONES', 'ADMINISTRATIVA', 'CENTRO NEGOCIOS');
-- SELECT * FROM [dbo].[BD_AGENCIAS]
--SELECT ZONA,COUNT(ZONA) AS 'CNT_ZONA' FROM [dbo].[BD_AGENCIAS] WHERE ZONA = 'DESCONOCIDO' GROUP BY ZONA 

SELECT DISTINCT AGENCIA FROM [dbo].[BD_AGENCIAS]
SELECT AGENCIA,COUNT(AGENCIA) AS 'CNT_BANCA' FROM [dbo].[BD_AGENCIAS] GROUP BY AGENCIA ORDER BY 'CNT_BANCA' DESC

--ADMINISTRATIVA		858 → NO ES AGENCIA
--EMPRESA				35  → NO ES AGENCIA
--MERCADOS				30  → NO ES AGENCIA
--SIN ESPECIFICAR		29  → NO ES AGENCIA
--INVERSIONES			16  → NO ES AGENCIA
--SAN ISIDRO          	11
--NEGOCIOS				4   → NO ES AGENCIA
--ENAPU               	2
--ESPEC. CLUB VILLA   	1
--ESPECIAL GAMARRA    	1
--.
--.
--.

--CAMBIO DE DATOS ('ADMINISTRATIVA', 'EMPRESA', 'SIN ESPECIFICAR', 'MERCADOS', 'INVERSIONES', 'NEGOCIOS') A DESCONOCIDO EN LA COLUMMNA "ZONA" DE LOS CAMPOS 
UPDATE [dbo].[BD_AGENCIAS] SET AGENCIA = 'DESCONOCIDO' WHERE AGENCIA IN ('ADMINISTRATIVA', 'EMPRESA', 'SIN ESPECIFICAR', 'MERCADOS', 'INVERSIONES', 'NEGOCIOS');
--SELECT * FROM [BD_SEGUROS].[dbo].[BD_AGENCIAS] ORDER BY COD_AGENCIA ASC

-- CREACION DE TABLA LIMPIA PARA LA BDS_SEGUROS
IF OBJECT_ID('BDS_SEGUROS.dbo.BD_AGENCIAS_LMP', 'U') IS NOT NULL
    DROP TABLE BDS_SEGUROS.dbo.BD_AGENCIAS_LMP;
GO

/*───────────────────────────────────────────────────────────────
  2. Copia estructura y datos tal cual
───────────────────────────────────────────────────────────────*/
SELECT *
INTO   BDS_SEGUROS.dbo.BD_AGENCIAS_LMP          -- 
FROM   bd_seguros.dbo.BD_AGENCIAS;          -- 
GO

SELECT COUNT(*) AS RegistrosCopiados  -- MUESTRA CUANTOS REGISTROS SE COPIARON EN ESTE CASO : 1297
FROM   BDS_SEGUROS.dbo.BD_AGENCIAS_LMP;
GO



-- ==================== [dbo].[BD_CLIENTE] ====================

SELECT COUNT(*) AS 'CNT_[dbo].[BD_CLIENTE]' FROM [dbo].[BD_CLIENTE]
SELECT * FROM [dbo].[BD_CLIENTE] ORDER BY MES_CORTE ASC

SELECT DISTINCT MES_CORTE FROM [dbo].[BD_CLIENTE] ORDER BY MES_CORTE ASC

-- Elimina registros de la tabla BD_CLIENTE donde el campo CODIGO está vacío o solo contiene espacios
DELETE FROM [dbo].[BD_CLIENTE] WHERE LTRIM(RTRIM(CODIGO)) = '';

SELECT COUNT(*) AS RegistrosAEliminar FROM [dbo].[BD_CLIENTE] WHERE SEXO IN ('P', 'U');
-- Elimina registros de la tabla BD_CLIENTE donde el campo SEXO tenga valores no válidos ('P' o 'U')
DELETE FROM [dbo].[BD_CLIENTE] WHERE SEXO IN ('P', 'U');
-- select from* [dbo].[BD_CLIENTE]


SELECT CODIGO, COUNT(CODIGO) AS 'CNT_CODIGO' FROM [dbo].[BD_CLIENTE] GROUP BY CODIGO ORDER BY 'CNT_CODIGO' DESC

SELECT COUNT(*) AS RegistrosAEliminar FROM [dbo].[BD_CLIENTE] WHERE SEXO IN ('P', 'U');
SELECT COUNT(*) FROM [dbo].[BD_CLIENTE] WHERE SEXO IN ('P', 'U');
SELECT COUNT(*) FROM [dbo].[BD_CLIENTE] WHERE EDAD IS NULL

-- ==================== ==================== ==================== ==================== ====================


SELECT SITUACION, COUNT(*) AS Total FROM [dbo].[BD_CLIENTE] WHERE SITUACION IN ('A', 'P', 'C') GROUP BY SITUACION;

--cuenta los datos de cada sexo ,m, f, x(DESCONOCIDO
SELECT SEXO, COUNT(*) AS Total
FROM [dbo].[BD_CLIENTE]
WHERE SEXO IN ('M', 'F', 'X')
GROUP BY SEXO;

SELECT * FROM DIM_SEXO;

--ACTUALIZAR UBIGEO NULO O VACIO A 999999999
UPDATE [BD_CLIENTE] SET UBIGEO = '9999999' WHERE UBIGEO IS NULL OR LTRIM(RTRIM(UBIGEO)) = '';

SELECT SEXO, COUNT(*) AS Total
FROM [dbo].[BD_CLIENTE]
WHERE SEXO IN ('M', 'F', 'X')
GROUP BY SEXO;

-- Busca registros donde la edad es -1 (posibles errores en datos)
SELECT * FROM [dbo].[BD_CLIENTE] WHERE edad = -1;

-- Corrige valores de edad inválidos, estableciendo '999' en registros con '-1', NULL o vacíos
UPDATE dbo.BD_CLIENTE 
SET EDAD = '999' 
WHERE EDAD = '-1' OR EDAD IS NULL OR LTRIM(RTRIM(EDAD)) = '';

-- CREA LA VISTA DE DIMENSION SEXO 
CREATE VIEW DIM_SEXO AS
SELECT DISTINCT
  SEXO AS COD_SEXO,
  CASE 
    WHEN SEXO = 'M' THEN 'MASCULINO'
    WHEN SEXO = 'F' THEN 'FEMENINO'
    WHEN SEXO = 'X' THEN 'DESCONOCIDO'
    ELSE 'NO ESPECIFICADO'
  END AS DESC_SEXO
FROM [dbo].[BD_CLIENTE]
WHERE SEXO IS NOT NULL;

SELECT * FROM DIM_SEXO;

  -- Descripción del rango de edad
  CASE 
    WHEN TRY_CAST(EDAD AS INT) BETWEEN 0 AND 17 THEN 'Niño / Adolescente'
    WHEN TRY_CAST(EDAD AS INT) BETWEEN 18 AND 29 THEN 'Joven Adulto'
    WHEN TRY_CAST(EDAD AS INT) BETWEEN 30 AND 59 THEN 'Adulto'
    WHEN TRY_CAST(EDAD AS INT) BETWEEN 60 AND 74 THEN 'Adulto Mayor'
    WHEN TRY_CAST(EDAD AS INT) BETWEEN 75 AND 998 THEN 'Longevo'
    ELSE 'Desconocido'  -- Incluye 999 y valores inesperados
  END AS RANGO_EDAD

FROM [dbo].[BD_CLIENTE]
WHERE ISNUMERIC(EDAD) = 1 AND EDAD IS NOT NULL;

-- Consulta la vista creada
SELECT * FROM DIM_RANGO_EDAD ORDER BY EDAD ASC;


/*
   Esta consulta analiza la calidad de los datos en la tabla 'BD_TB_SEGURO',
   verificando la integridad de las fechas registradas.

   - 'fh_apertura': Cuenta valores nulos y válidos en la fecha de apertura.
   - 'fh_vencimiento': Cuenta valores nulos y válidos en la fecha de vencimiento.
   - 'fechas_invertidas': Identifica registros donde la fecha de apertura es posterior a la fecha de vencimiento,
     lo cual representa un posible error lógico en los datos.

   Útil para validaciones de calidad de datos y asegurarse de la coherencia temporal en los registros.
*/
SELECT 
    -- Análisis de 'fh_apertura'
    SUM(CASE WHEN fh_apertura IS NULL THEN 1 ELSE 0 END) AS apertura_nulos,
    SUM(CASE WHEN fh_apertura IS NOT NULL THEN 1 ELSE 0 END) AS apertura_validos,

    -- Análisis de 'fh_vencimiento'
    SUM(CASE WHEN fh_vencimiento IS NULL THEN 1 ELSE 0 END) AS vencimiento_nulos,
    SUM(CASE WHEN fh_vencimiento IS NOT NULL THEN 1 ELSE 0 END) AS vencimiento_validos,

    -- Identificación de errores lógicos en fechas
    SUM(CASE WHEN fh_apertura IS NOT NULL AND fh_vencimiento IS NOT NULL AND fh_apertura > fh_vencimiento THEN 1 ELSE 0 END) AS fechas_invertidas

FROM dbo.BD_TB_SEGURO;

-- CLIENTES BDS 
SELECT*FROM [dbo].[BD_CLIENTE]


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'AGENCIAS';

[dbo].[BD_AGENCIAS][dbo].[BD_CLIENTE][dbo].[BD_SEGMENTO][dbo].[BD_TB_SEGURO][dbo].[BD_UBIGEO][dbo].[TB_PRODUCTOS_FINANCIEROS][dbo].[TB_TIPO_SEGURO]



SELECT 
    TABLE_NAME,
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH, 
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo' 
  AND TABLE_NAME IN (
      'BD_AGENCIAS',
      'BD_CLIENTE',
      'BD_SEGMENTO',
      'BD_TB_SEGURO',
      'BD_UBIGEO',
      'TB_PRODUCTOS_FINANCIEROS',
      'TB_TIPO_SEGURO'
  )
ORDER BY TABLE_NAME, ORDINAL_POSITION;
-- CLIENTES BDS UNICOS
-- [1] Borrar la tabla si ya existe
IF OBJECT_ID('BDS_SEGUROS.dbo.CLIENTE_UNICO', 'U') IS NOT NULL
    DROP TABLE BDS_SEGUROS.dbo.CLIENTE_UNICO;

-- [2] Crear tabla con un solo cliente por CODIGO (el más reciente)
SELECT
    CODIGO,
    AGENCIA,
    SEGMENTO,
    MES_CORTE,
    SEXO,
    EDAD,
    UBIGEO,
    INGRESO,
    SITUACION,
    FECHA_ALTA
INTO BDS_SEGUROS.dbo.CLIENTE_UNICO
FROM (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY LTRIM(RTRIM(CODIGO))
            ORDER BY MES_CORTE DESC
        ) AS rn
    FROM bd_seguros.dbo.BD_CLIENTE
    WHERE
        LTRIM(RTRIM(CODIGO)) <> ''
        AND CODIGO IS NOT NULL
        AND SEXO IN ('M', 'F', 'X')
) AS clientes_filtrados
WHERE rn = 1;

use BDS_SEGUROS
select *from [dbo].[CLIENTE_UNICO]; -- 264,636 CLIENTES UNICOS -- 264,811 CON SEXO DESCONOCIDO



-- ==================== [dbo].[BD_SEGMENTO] ====================

--INSERTAR EL REGISTRO SIN ESPECIFICAR TABLA BD SEGMENTO 
INSERT INTO [dbo].[BD_SEGMENTO] (COD_SEGMENTO, DESC_SEGMENTO, GRUPO)
VALUES ('999999', 'SIN ESPECIFICAR', 'NO DEFINIDO');

IF OBJECT_ID('BDS_SEGUROS.dbo.BD_SEGMENTO_LMP', 'U') IS NOT NULL
    DROP TABLE BDS_SEGUROS.dbo.BD_SEGMENTO_LMP;
GO
select* from[dbo].[BD_TB_SEGURO]
/* ─────────────────────────────────────────────────────────────
   2. Copia estructura + datos directamente
      (SELECT … INTO crea la tabla y luego inserta)
   ───────────────────────────────────────────────────────────── */
SELECT *
INTO   BDS_SEGUROS.dbo.BD_SEGMENTO_LMP      -- ←
FROM   bd_seguros.dbo.BD_SEGMENTO;          -- ← 
GO

-- ==================== [dbo].[BD_TB_SEGURO] ====================

}



-- ==================== [dbo].[TB_TIPO_SEGURO] ====================
SELECT * FROM [dbo].[BD_CLIENTE]

SELECT * FROM [dbo].[TB_TIPO_SEGURO]
SELECT COUNT(*)AS 'Cantidad de datos de [dbo].[TB_TIPO_SEGURO]' FROM [BD_SEGUROS].[dbo].[TB_TIPO_SEGURO]

SELECT DISTINCT CODIGO FROM [BD_SEGUROS].[dbo].[TB_TIPO_SEGURO]
SELECT DISTINCT GRUPO FROM [BD_SEGUROS].[dbo].[TB_TIPO_SEGURO]
SELECT DISTINCT TIPO FROM [BD_SEGUROS].[dbo].[TB_TIPO_SEGURO]
SELECT DISTINCT SUBTIPO FROM [BD_SEGUROS].[dbo].[TB_TIPO_SEGURO]
SELECT DISTINCT DESCRIPCION FROM [BD_SEGUROS].[dbo].[TB_TIPO_SEGURO]


SELECT 
    COUNT(*) AS total_registros,
    SUM(CASE WHEN CODIGO IS NULL THEN 1 ELSE 0 END) AS cantidad_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(CODIGO)) = '' THEN 1 ELSE 0 END) AS cantidad_vacios,
    SUM(CASE WHEN CODIGO IS NOT NULL AND LTRIM(RTRIM(CODIGO)) <> '' THEN 1 ELSE 0 END) AS cantidad_validos
FROM dbo.BD_TB_SEGURO;

SELECT 
    -- Para cd_subproducto
    SUM(CASE WHEN cd_subproducto IS NULL THEN 1 ELSE 0 END) AS cd_subproducto_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(cd_subproducto)) = '' THEN 1 ELSE 0 END) AS cd_subproducto_vacios,
    SUM(CASE WHEN cd_subproducto IS NOT NULL AND LTRIM(RTRIM(cd_subproducto)) <> '' THEN 1 ELSE 0 END) AS cd_subproducto_validos,

    -- Para cd_canal_venta
    SUM(CASE WHEN cd_canal_venta IS NULL THEN 1 ELSE 0 END) AS cd_canal_venta_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(cd_canal_venta)) = '' THEN 1 ELSE 0 END) AS cd_canal_venta_vacios,
    SUM(CASE WHEN cd_canal_venta IS NOT NULL AND LTRIM(RTRIM(cd_canal_venta)) <> '' THEN 1 ELSE 0 END) AS cd_canal_venta_validos

FROM dbo.BD_TB_SEGURO;

/*
   Esta consulta realiza un análisis sobre la columna 'cd_divisa' en la tabla 'BD_TB_SEGURO'.
   - Cuenta cuántos registros tienen valores NULL en 'cd_divisa' (divisa_nulos).
   - Cuenta cuántos registros tienen valores vacíos ('') en 'cd_divisa' (divisa_vacios).
   - Cuenta cuántos registros tienen el valor 'USD' en 'cd_divisa' (divisa_usd).
   - Cuenta cuántos registros tienen el valor 'PEN' en 'cd_divisa' (divisa_pen).
   Para garantizar precisión, usa funciones de limpieza como LTRIM, RTRIM y UPPER 
   para eliminar espacios y estandarizar mayúsculas.
*/
SELECT 
    SUM(CASE WHEN cd_divisa IS NULL THEN 1 ELSE 0 END) AS divisa_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(cd_divisa)) = '' THEN 1 ELSE 0 END) AS divisa_vacios,
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(cd_divisa))) = 'USD' THEN 1 ELSE 0 END) AS divisa_usd,
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(cd_divisa))) = 'PEN' THEN 1 ELSE 0 END) AS divisa_pen
FROM dbo.BD_TB_SEGURO;

/*
   Esta consulta limpia los valores de las columnas 'fh_apertura' y 'fh_vencimiento' en la tabla 'BD_TB_SEGURO'. 
   - Usa LTRIM y RTRIM para eliminar espacios en blanco al inicio y al final de los valores almacenados.
   - Mejora la calidad de los datos, evitando problemas en futuras comparaciones y cálculos de fechas.
   - Útil para garantizar la consistencia en registros antes de realizar análisis o validaciones.
*/
UPDATE dbo.BD_TB_SEGURO
SET 
    fh_apertura = LTRIM(RTRIM(fh_apertura)),
    fh_vencimiento = LTRIM(RTRIM(fh_vencimiento));


/*
   Esta consulta analiza la calidad de los datos en la tabla 'BD_TB_SEGURO', 
   verificando la integridad y coherencia de las fechas registradas.

   - 'fh_apertura': Cuenta valores nulos y válidos en la fecha de apertura.
   - 'fh_vencimiento': Cuenta valores nulos y válidos en la fecha de vencimiento.
   - 'fechas_invertidas_correctas': Identifica registros donde la fecha de apertura es posterior 
     a la fecha de vencimiento, asegurando que ambas fechas sean válidas con TRY_CAST a tipo DATE.

   TRY_CAST se usa para evitar errores al convertir valores no válidos y garantizar comparaciones seguras.
   Útil para auditorías de calidad de datos y validaciones en procesos administrativos.
*/
SELECT 
    -- Análisis de 'fh_apertura'
    SUM(CASE WHEN fh_apertura IS NULL THEN 1 ELSE 0 END) AS apertura_nulos,
    SUM(CASE WHEN fh_apertura IS NOT NULL THEN 1 ELSE 0 END) AS apertura_validos,

    -- Análisis de 'fh_vencimiento'
    SUM(CASE WHEN fh_vencimiento IS NULL THEN 1 ELSE 0 END) AS vencimiento_nulos,
    SUM(CASE WHEN fh_vencimiento IS NOT NULL THEN 1 ELSE 0 END) AS vencimiento_validos,

    -- Identificación de errores lógicos en fechas
    SUM(CASE 
            WHEN TRY_CAST(fh_apertura AS DATE) IS NOT NULL 
                 AND TRY_CAST(fh_vencimiento AS DATE) IS NOT NULL 
                 AND TRY_CAST(fh_apertura AS DATE) > TRY_CAST(fh_vencimiento AS DATE) 
            THEN 1 ELSE 0 
        END) AS fechas_invertidas_correctas

FROM dbo.BD_TB_SEGURO;

USE BD_SEGUROS
/*
   Esta consulta actualiza la columna 'fh_vencimiento' en la tabla 'BD_TB_SEGURO', 
   estableciendo la fecha '2015/03/19' en registros con valores inválidos.

   - Se reemplazan valores NULL y vacíos ('').
   - Se corrigen registros donde el tamaño del campo no es de 10 caracteres.
   - Se validan los formatos incorrectos con la condición NOT LIKE usando expresiones regulares 
     para asegurar que la fecha siga el formato 'DD/MM/YYYY'.
*/
UPDATE [dbo].[BD_TB_SEGURO]
SET fh_vencimiento = '2015/03/19'
WHERE 
    fh_vencimiento IS NULL
    OR fh_vencimiento = ''
    OR LEN(fh_vencimiento) <> 10
    OR fh_vencimiento NOT LIKE '[0-3][0-9]/[0-1][0-9]/[0-9][0-9][0-9][0-9]';


/*
   Esta consulta corrige registros en la tabla 'BD_TB_SEGURO' donde la fecha de apertura ('fh_apertura') 
   es posterior a la fecha de vencimiento ('fh_vencimiento'), lo cual representa un error lógico.

   - Se usa TRY_CAST para asegurarse de que las fechas sean válidas antes de procesarlas.
   - DATEADD(YEAR, 1, fh_apertura) ajusta la fecha de vencimiento sumando un año a la fecha de apertura.
   - CONVERT(VARCHAR(10), ..., 120) formatea la nueva fecha en formato 'YYYY-MM-DD' para mantener la coherencia.
*/
UPDATE dbo.BD_TB_SEGURO
SET fh_vencimiento = CONVERT(VARCHAR(10), DATEADD(YEAR, 1, TRY_CAST(fh_apertura AS DATE)), 120)
WHERE 
    TRY_CAST(fh_apertura AS DATE) IS NOT NULL 
    AND TRY_CAST(fh_vencimiento AS DATE) IS NOT NULL 
    AND TRY_CAST(fh_apertura AS DATE) > TRY_CAST(fh_vencimiento AS DATE);

-- aca termina las fechas 
SELECT *
FROM dbo.BD_TB_SEGURO
WHERE 
    TRY_CAST(fh_apertura AS DATE) IS NOT NULL AND
    fh_vencimiento = CONVERT(VARCHAR(10), DATEADD(YEAR, 1, TRY_CAST(fh_apertura AS DATE)), 120);

SELECT
    SUM(CASE WHEN im_prima IS NULL THEN 1 ELSE 0 END) AS prima_nulos,
    SUM(CASE WHEN im_prima IS NOT NULL THEN 1 ELSE 0 END) AS prima_validos
FROM dbo.BD_TB_SEGURO;

SELECT
    SUM(CASE WHEN im_prima IS NULL THEN 1 ELSE 0 END) AS prima_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(im_prima)) = '' THEN 1 ELSE 0 END) AS prima_vacios,
    SUM(CASE WHEN im_prima IS NOT NULL AND LTRIM(RTRIM(im_prima)) <> '' THEN 1 ELSE 0 END) AS prima_validos
FROM dbo.BD_TB_SEGURO;

--- nulos tipo numerico
SELECT
    SUM(CASE WHEN im_capital_aseg IS NULL THEN 1 ELSE 0 END) AS capital_aseg_nulos,
    SUM(CASE WHEN im_capital_aseg IS NOT NULL THEN 1 ELSE 0 END) AS capital_aseg_validos
FROM dbo.BD_TB_SEGURO;
--nulos y posibles vacios
SELECT
    SUM(CASE WHEN im_capital_aseg IS NULL THEN 1 ELSE 0 END) AS capital_aseg_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(im_capital_aseg)) = '' THEN 1 ELSE 0 END) AS capital_aseg_vacios,
    SUM(CASE WHEN im_capital_aseg IS NOT NULL AND LTRIM(RTRIM(im_capital_aseg)) <> '' THEN 1 ELSE 0 END) AS capital_aseg_validos
FROM dbo.BD_TB_SEGURO;

--nulos tipo numerico
SELECT
    SUM(CASE WHEN im_comision IS NULL THEN 1 ELSE 0 END) AS comision_nulos,
    SUM(CASE WHEN im_comision IS NOT NULL THEN 1 ELSE 0 END) AS comision_validos
FROM dbo.BD_TB_SEGURO;
--nulos y posibles vacios
SELECT
    SUM(CASE WHEN im_comision IS NULL THEN 1 ELSE 0 END) AS comision_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(im_comision)) = '' THEN 1 ELSE 0 END) AS comision_vacios,
    SUM(CASE WHEN im_comision IS NOT NULL AND LTRIM(RTRIM(im_comision)) <> '' THEN 1 ELSE 0 END) AS comision_validos
FROM dbo.BD_TB_SEGURO;

USE BDS_SEGUROS;
GO

-- 1. Eliminar la tabla limpia si ya existe
IF OBJECT_ID('dbo.TB_SEGUROS_LIMPIO', 'U') IS NOT NULL
    DROP TABLE dbo.TB_SEGUROS_LIMPIO;
GO

CREATE TABLE dbo.TB_SEGUROS_LIMPIO (
    id_seguro           INT IDENTITY(101000,1) PRIMARY KEY,
    CODIGO              VARCHAR(20) NOT NULL,
    MES_CORTE           VARCHAR(6)  NOT NULL,
    cd_subproducto      VARCHAR(255) NULL,
    cd_canal_venta      VARCHAR(10) NULL,
    cd_divisa           VARCHAR(10) NULL,
    fh_apertura         VARCHAR(255) NULL,
    fh_vencimiento      VARCHAR(255) NULL,
    im_prima            FLOAT NULL,
    im_capital_aseg     FLOAT NULL,
    im_comision         FLOAT NULL
);
GO

-- INSERTA LOS DATOS LIMPIOS (ELIMINA CÓDIGOS VACÍOS)
WITH seguros_sin_duplicados AS (
    SELECT 
        LTRIM(RTRIM(CODIGO))            AS CODIGO,
        LTRIM(RTRIM(MES_CORTE))         AS MES_CORTE,
        LTRIM(RTRIM(cd_subproducto))    AS cd_subproducto,
        LTRIM(RTRIM(cd_canal_venta))    AS cd_canal_venta,
        UPPER(LTRIM(RTRIM(cd_divisa)))  AS cd_divisa,
        LTRIM(RTRIM(fh_apertura))       AS fh_apertura,
        LTRIM(RTRIM(fh_vencimiento))    AS fh_vencimiento,
        im_prima,
        im_capital_aseg,
        im_comision,
        ROW_NUMBER() OVER (
            PARTITION BY 
                LTRIM(RTRIM(CODIGO)),
                LTRIM(RTRIM(MES_CORTE)),
                LTRIM(RTRIM(cd_subproducto)),
                LTRIM(RTRIM(cd_canal_venta)),
                UPPER(LTRIM(RTRIM(cd_divisa))),
                LTRIM(RTRIM(fh_apertura)),
                LTRIM(RTRIM(fh_vencimiento)),
                im_prima,
                im_capital_aseg,
                im_comision
            ORDER BY CODIGO
        ) AS fila
    FROM BD_SEGUROS.dbo.BD_TB_SEGURO
    WHERE LTRIM(RTRIM(ISNULL(CODIGO, ''))) <> ''
)
INSERT INTO dbo.TB_SEGUROS_LIMPIO (
    CODIGO,
    MES_CORTE,
    cd_subproducto,
    cd_canal_venta,
    cd_divisa,
    fh_apertura,
    fh_vencimiento,
    im_prima,
    im_capital_aseg,
    im_comision
)
SELECT 
    CODIGO,
    MES_CORTE,
    cd_subproducto,
    cd_canal_venta,
    cd_divisa,
    fh_apertura,
    fh_vencimiento,
    im_prima,
    im_capital_aseg,
    im_comision
FROM seguros_sin_duplicados
WHERE fila = 1;
GO

select *from dbo.TB_SEGUROS_LIMPIO

































-- Crea una tabla temporal con numeración por grupo lógico

--1719,877 la tabla normal 1,716,333 esta tabla temporal





-- ==================== [dbo].[BD_UBIGEO] ====================
SELECT * FROM [dbo].[BD_UBIGEO]

SELECT * FROM [dbo].[BD_UBIGEO] WHERE DISTRITO =''
SELECT * FROM [dbo].[BD_UBIGEO] WHERE DISTRITO ='DESCONOCIDO'

-- Reemplaza valores vacíos en la columna 'DISTRITO' por 'DESCONOCIDO' para asegurar consistencia en los datos
UPDATE [dbo].[BD_UBIGEO] SET DISTRITO = 'DESCONOCIDO' WHERE DISTRITO = '';

SELECT DISTINCT PROVINCIA FROM [dbo].[BD_UBIGEO]
SELECT DISTINCT DEPARTAMENTO FROM [dbo].[BD_UBIGEO]

IF OBJECT_ID('BDS_SEGUROS.dbo.BD_UBIGEO_limpio', 'U') IS NOT NULL
    DROP TABLE BDS_SEGUROS.dbo.BD_UBIGEO_limpio;
GO

/*2. Copia la estructura y los datos tal cual están  (SELECT INTO crea la tabla y luego inserta) */
  select*from   [dbo].[DIM_TIEMPO]
SELECT *
INTO   BDS_SEGUROS.dbo.BD_UBIGEO_limpio
FROM   bd_seguros.dbo.BD_UBIGEO;
GO
-- para saber registros copiados
SELECT COUNT(*) AS RegistrosCopiados
FROM   BDS_SEGUROS.dbo.BD_UBIGEO_limpio;
GO
-- ==================== [dbo].[TB_PRODUCTOS_FINANCIEROS] ====================
select* from[dbo].[CLIENTE_UNICO]
--TB PRODUCTOS FINANCIEROS -- 1495428  -- 61898 SE ELIMINARION 123798 DATOS DUPLICADOS DE OTRA TABLA 
  DELETE FROM [dbo].[TB_PRODUCTOS_FINANCIEROS] WHERE FLGTC IN ('P', 'U');


  SELECT
    SUM(CASE WHEN CODIGO IS NULL THEN 1 ELSE 0 END) AS codigo_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(CODIGO)) = '' THEN 1 ELSE 0 END) AS codigo_vacios,
    SUM(CASE WHEN CODIGO IS NOT NULL AND LTRIM(RTRIM(CODIGO)) <> '' THEN 1 ELSE 0 END) AS codigo_validos
FROM dbo.TB_PRODUCTOS_FINANCIEROS;


  SELECT
    SUM(CASE WHEN MES_CORTE IS NULL THEN 1 ELSE 0 END) AS mes_corte_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(MES_CORTE)) = '' THEN 1 ELSE 0 END) AS mes_corte_vacios,
    SUM(CASE WHEN MES_CORTE IS NOT NULL AND LTRIM(RTRIM(MES_CORTE)) <> '' THEN 1 ELSE 0 END) AS mes_corte_validos
FROM dbo.TB_PRODUCTOS_FINANCIEROS;
---
SELECT
    -- FLGVIP
    SUM(CASE WHEN FLGVIP IS NULL THEN 1 ELSE 0 END) AS flgvip_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(FLGVIP)) = '' THEN 1 ELSE 0 END) AS flgvip_vacios,
    SUM(CASE WHEN FLGVIP IS NOT NULL AND LTRIM(RTRIM(FLGVIP)) <> '' THEN 1 ELSE 0 END) AS flgvip_validos,

    -- FLGVPH
    SUM(CASE WHEN FLGVPH IS NULL THEN 1 ELSE 0 END) AS flgvph_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(FLGVPH)) = '' THEN 1 ELSE 0 END) AS flgvph_vacios,
    SUM(CASE WHEN FLGVPH IS NOT NULL AND LTRIM(RTRIM(FLGVPH)) <> '' THEN 1 ELSE 0 END) AS flgvph_validos,

    -- FLGTC
    SUM(CASE WHEN FLGTC IS NULL THEN 1 ELSE 0 END) AS flgtc_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(FLGTC)) = '' THEN 1 ELSE 0 END) AS flgtc_vacios,
    SUM(CASE WHEN FLGTC IS NOT NULL AND LTRIM(RTRIM(FLGTC)) <> '' THEN 1 ELSE 0 END) AS flgtc_validos,

    -- FLGAHO
    SUM(CASE WHEN FLGAHO IS NULL THEN 1 ELSE 0 END) AS flgaho_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(FLGAHO)) = '' THEN 1 ELSE 0 END) AS flgaho_vacios,
    SUM(CASE WHEN FLGAHO IS NOT NULL AND LTRIM(RTRIM(FLGAHO)) <> '' THEN 1 ELSE 0 END) AS flgaho_validos,

    -- FLGSEG
    SUM(CASE WHEN FLGSEG IS NULL THEN 1 ELSE 0 END) AS flgseg_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(FLGSEG)) = '' THEN 1 ELSE 0 END) AS flgseg_vacios,
    SUM(CASE WHEN FLGSEG IS NOT NULL AND LTRIM(RTRIM(FLGSEG)) <> '' THEN 1 ELSE 0 END) AS flgseg_validos,

    -- FLGSBS
    SUM(CASE WHEN FLGSBS IS NULL THEN 1 ELSE 0 END) AS flgsbs_nulos,
    SUM(CASE WHEN LTRIM(RTRIM(FLGSBS)) = '' THEN 1 ELSE 0 END) AS flgsbs_vacios,
    SUM(CASE WHEN FLGSBS IS NOT NULL AND LTRIM(RTRIM(FLGSBS)) <> '' THEN 1 ELSE 0 END) AS flgsbs_validos

FROM dbo.TB_PRODUCTOS_FINANCIEROS;
--
SELECT
    SUM(CASE WHEN FLGVIP NOT IN ('0', '1') AND FLGVIP IS NOT NULL AND LTRIM(RTRIM(FLGVIP)) <> '' THEN 1 ELSE 0 END) AS flgvip_invalidos,
    SUM(CASE WHEN FLGVPH NOT IN ('0', '1') AND FLGVPH IS NOT NULL AND LTRIM(RTRIM(FLGVPH)) <> '' THEN 1 ELSE 0 END) AS flgvph_invalidos,
    SUM(CASE WHEN FLGTC  NOT IN ('0', '1') AND FLGTC  IS NOT NULL AND LTRIM(RTRIM(FLGTC))  <> '' THEN 1 ELSE 0 END) AS flgtc_invalidos,
    SUM(CASE WHEN FLGAHO NOT IN ('0', '1') AND FLGAHO IS NOT NULL AND LTRIM(RTRIM(FLGAHO)) <> '' THEN 1 ELSE 0 END) AS flgaho_invalidos,
    SUM(CASE WHEN FLGSEG NOT IN ('0', '1') AND FLGSEG IS NOT NULL AND LTRIM(RTRIM(FLGSEG)) <> '' THEN 1 ELSE 0 END) AS flgseg_invalidos,
    SUM(CASE WHEN FLGSBS NOT IN ('0', '1') AND FLGSBS IS NOT NULL AND LTRIM(RTRIM(FLGSBS)) <> '' THEN 1 ELSE 0 END) AS flgsbs_invalidos
FROM dbo.TB_PRODUCTOS_FINANCIEROS;

SELECT * FROM dbo.TB_PRODUCTOS_FINANCIEROS;

-- CREACION DE TABLA  LIMPIA PRODUCTOS FINANCIEROS 

IF OBJECT_ID('BDS_SEGUROS.dbo.TB_PRODUCTOS_FINANCIEROS_LMP', 'U') IS NOT NULL
    DROP TABLE BDS_SEGUROS.dbo.TB_PRODUCTOS_FINANCIEROS_LMP;
GO

/*───────────────────────────────────────────────────────────────
  2. Copia estructura + datos en la nueva tabla LMP
───────────────────────────────────────────────────────────────*/
SELECT *
INTO   BDS_SEGUROS.dbo.TB_PRODUCTOS_FINANCIEROS_LMP      -- ←  
FROM   bd_seguros.dbo.TB_PRODUCTOS_FINANCIEROS;  -- 
GO



-- ==================== [dbo].[TB_TIPO_SEGURO] ====================
SELECT * FROM [dbo].[TB_TIPO_SEGURO]


SELECT DISTINCT CODIGO FROM [dbo].[TB_TIPO_SEGURO]
SELECT DISTINCT GRUPO FROM [dbo].[TB_TIPO_SEGURO]
SELECT DISTINCT TIPO FROM [dbo].[TB_TIPO_SEGURO]
SELECT DISTINCT GRUPO FROM [dbo].[TB_TIPO_SEGURO]
SELECT DISTINCT DESCRIPCION FROM [dbo].[TB_TIPO_SEGURO]

SELECT 
    SUM(CASE WHEN CODIGO IS NULL OR LTRIM(RTRIM(CODIGO)) = '' THEN 1 ELSE 0 END) AS codigo_nulos_vacios,
    SUM(CASE WHEN GRUPO IS NULL OR LTRIM(RTRIM(GRUPO)) = '' THEN 1 ELSE 0 END) AS grupo_nulos_vacios,
    SUM(CASE WHEN TIPO IS NULL OR LTRIM(RTRIM(TIPO)) = '' THEN 1 ELSE 0 END) AS tipo_nulos_vacios,
    SUM(CASE WHEN DESCRIPCION IS NULL OR LTRIM(RTRIM(DESCRIPCION)) = '' THEN 1 ELSE 0 END) AS descripcion_nulos_vacios
FROM dbo.TB_TIPO_SEGURO;

--PASAR LA TABLA TIPO SEGUROS A LA BDS YA LIMPIA

IF OBJECT_ID('BDS_SEGUROS.dbo.TB_TIPO_SEGURO_LMP', 'U') IS NOT NULL
    DROP TABLE BDS_SEGUROS.dbo.TB_TIPO_SEGURO_LMP

/* ─────────────────────────────────────────────────────────────
   2. Copia estructura + datos directamente desde la tabla limpia
   ───────────────────────────────────────────────────────────── */
SELECT *
INTO   BDS_SEGUROS.dbo.TB_TIPO_SEGURO_LMP          -- 
FROM   bd_seguros.dbo.TB_TIPO_SEGURO;          -- ← 
GO

-- ==========================================================

-- Obtiene las edades únicas junto con la cantidad de clientes por edad, ordenadas ascendentemente
SELECT EDAD, COUNT(EDAD) AS CANTIDAD FROM [dbo].[BD_CLIENTE] GROUP BY EDAD ORDER BY EDAD ASC;


SELECT  COUNT(*) FROM [dbo].[BD_TB_SEGURO]


USE bds_SEGUROS;
GO






SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'BD_CLIENTE';

--
USE bds_SEGUROS;
GO

/*==================CREACION DE VISTAS PARA LA ODS ===================*/

USE ODS_SEGURO;
GO

/*-------------------------------------------------------------
  0-bis. Asegura que el esquema ODS exista en ODS_SEGURO
-------------------------------------------------------------*/
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'ods')
    EXEC('CREATE SCHEMA ods AUTHORIZATION dbo');
GO


/*-------------------------------------------------------------
  1-B. Vista de Pólizas / Seguros
-------------------------------------------------------------*/
CREATE OR ALTER VIEW ods.vw_seguro
AS
SELECT
    s.CODIGO  AS cod_cliente,
    s.MES_CORTE AS mes_corte,
    s.cd_subproducto AS cod_seguro,
    s.cd_canal_venta AS cod_canal_venta,
    s.cd_divisa      AS cod_divisa,

    /* --------- FECHA APERTURA ---------- */
    CASE
        WHEN TRY_CONVERT(date, s.fh_apertura, 103) IS NOT NULL
             THEN TRY_CONVERT(date, s.fh_apertura, 103)      -- dd/MM/yyyy
        WHEN TRY_CONVERT(date, s.fh_apertura, 105) IS NOT NULL
             THEN TRY_CONVERT(date, s.fh_apertura, 105)      -- dd-MM-yyyy
        WHEN TRY_CONVERT(date, s.fh_apertura, 101) IS NOT NULL
             THEN TRY_CONVERT(date, s.fh_apertura, 101)      -- MM/dd/yyyy
        WHEN TRY_CONVERT(date, s.fh_apertura, 112) IS NOT NULL
             THEN TRY_CONVERT(date, s.fh_apertura, 112)      -- yyyymmdd
        WHEN TRY_CONVERT(date, LEFT(s.fh_apertura,10), 120) IS NOT NULL
             THEN TRY_CONVERT(date, LEFT(s.fh_apertura,10), 120) -- YYYY-MM-DD HH:MM:SS
        ELSE NULL
    END AS fecha_apertura,

    /* --------- FECHA VENCIMIENTO ---------- */
    CASE
        WHEN TRY_CONVERT(date, s.fh_vencimiento, 103) IS NOT NULL
             THEN TRY_CONVERT(date, s.fh_vencimiento, 103)
        WHEN TRY_CONVERT(date, s.fh_vencimiento, 105) IS NOT NULL
             THEN TRY_CONVERT(date, s.fh_vencimiento, 105)
        WHEN TRY_CONVERT(date, s.fh_vencimiento, 101) IS NOT NULL
             THEN TRY_CONVERT(date, s.fh_vencimiento, 101)
        WHEN TRY_CONVERT(date, s.fh_vencimiento, 112) IS NOT NULL
             THEN TRY_CONVERT(date, s.fh_vencimiento, 112)
        WHEN TRY_CONVERT(date, LEFT(s.fh_vencimiento,10), 120) IS NOT NULL
             THEN TRY_CONVERT(date, LEFT(s.fh_vencimiento,10), 120)
        ELSE NULL
    END AS fecha_vencimiento,

    -- Métricas
    s.im_prima,
    s.im_capital_aseg,
    s.im_comision
FROM  BDS_SEGUROS.dbo.TB_SEGUROS_LIMPIO s;
GO

SELECT*FROM [ods].[vw_seguro]

SELECT TOP 100
       s.fh_apertura,
       s.fh_vencimiento
FROM   BDS_SEGUROS.dbo.TB_SEGUROS_LIMPIO s
WHERE  TRY_CONVERT(date, s.fh_apertura,   103) IS NULL
  AND  NULLIF(LTRIM(RTRIM(s.fh_apertura)), '') IS NOT NULL;   -- la cadena no está vacía

SELECT COUNT(*) AS restantes_null
FROM   ods.vw_seguro
WHERE  fecha_apertura IS NULL
   OR  fecha_vencimiento IS NULL;

/*-------------------------------------------------------------
  1-C. Vista de Productos Financieros (snapshot cliente-mes)
-------------------------------------------------------------*/
CREATE OR ALTER VIEW ods.vw_producto_fin
AS
SELECT
    p.CODIGO        AS cod_cliente,
    p.MES_CORTE     AS mes_corte,
    CAST(p.FLGVIP   AS TINYINT) AS VIP,       -- Cliente VIP
    CAST(p.FLGVPH   AS TINYINT) AS PH,        -- Cliente PH
    CAST(p.FLGTC    AS TINYINT) AS TC,        -- Tarjeta de Crédito
    CAST(p.FLGAHO   AS TINYINT) AS AHO,    -- Cuenta de Ahorro
    CAST(p.FLGSEG   AS TINYINT) AS SEG,    -- Seguro Vinculado
    CAST(p.FLGSBS   AS TINYINT) AS SBS        -- Reportado SBS
FROM BDS_SEGUROS.dbo.TB_PRODUCTOS_FINANCIEROS_LMP p;
GO


SELECT*FROM ods.vw_producto_fin

/*-------------------------------------------------------------
  1-D. Vistas de Catálogo (Agencia, Segmento, Ubigeo, Tipo Seguro)
-------------------------------------------------------------*/
CREATE OR ALTER VIEW ods.vw_agencia
AS SELECT * FROM BDS_SEGUROS.dbo.BD_AGENCIAS_LMP;
GO

CREATE OR ALTER VIEW ods.vw_segmento
AS SELECT * FROM BDS_SEGUROS.dbo.BD_SEGMENTO_LMP;
GO

CREATE OR ALTER VIEW ods.vw_ubigeo
AS SELECT * FROM BDS_SEGUROS.dbo.BD_UBIGEO_limpio;
GO

CREATE OR ALTER VIEW ods.vw_tipo_seg
AS SELECT * FROM BDS_SEGUROS.dbo.TB_TIPO_SEGURO_LMP;
GO

select*from ods.vw_agencia

/* Crea el esquema si no existe */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'ods')
    EXEC('CREATE SCHEMA ods AUTHORIZATION dbo');
GO

/* Vista de catálogo Sexo: M, F, X, … */
CREATE OR ALTER VIEW ods.vw_sexo
AS
SELECT DISTINCT
       /* código normalizado (TRIM + UPPER) */
       cod_sexo  = UPPER(LTRIM(RTRIM(SEXO))) COLLATE Modern_Spanish_CI_AS ,
       /* descripción legible */
       desc_sexo = CASE UPPER(LTRIM(RTRIM(SEXO)))
                       WHEN 'M' THEN N'MASCULINO'
                       WHEN 'F' THEN N'FEMENINO'
                       WHEN 'X' THEN N'DESCONOCIDO'
                       ELSE          N'NO ESPECIFICADO'
                   END
FROM   BDS_SEGUROS.dbo.CLIENTE_UNICO         -- tabla staging limpia (ya contiene X)
WHERE  SEXO IS NOT NULL
  AND  LTRIM(RTRIM(SEXO)) <> '';
GO
/*==================CREACION DE LAS DIMENSIONES PARA LA DWH ===================*/
SELECT DISTINCT
       '[' + SEXO + ']' AS raw_val,
       LEN(SEXO)        AS largo,
       UPPER(LTRIM(RTRIM(SEXO))) AS normalizado
FROM   BDS_SEGUROS.dbo.CLIENTE_UNICO
WHERE  SEXO IS NOT NULL;


/*-------------------------------------------------------------
  2-A  DIM_AGENCIA
-------------------------------------------------------------*/
USE DWH_SEGUROS;
GO

IF OBJECT_ID('dbo.DIM_AGENCIA','U') IS NOT NULL DROP TABLE dbo.DIM_AGENCIA;

CREATE TABLE dbo.DIM_AGENCIA (
    
    cod_agencia VARCHAR(4) NOT NULL PRIMARY KEY,
    banca       NVARCHAR(25),
    zona        NVARCHAR(35),
    agencia     NVARCHAR(25)
);

INSERT INTO dbo.DIM_AGENCIA (cod_agencia,banca,zona,agencia)
SELECT DISTINCT COD_AGENCIA ,BANCA ,ZONA ,AGENCIA
FROM   ODS_SEGURO.ods.vw_agencia;   -- ← nombre de 3 partes
GO

SELECT* FROM [dbo].[DIM_AGENCIA]

IF OBJECT_ID('dbo.DIM_UBIGEO','U') IS NOT NULL DROP TABLE dbo.DIM_UBIGEO;
CREATE TABLE dbo.DIM_UBIGEO( 
    cod_ubigeo    NVARCHAR(10) PRIMARY KEY,
    distrito      NVARCHAR(30),
    provincia     NVARCHAR(30),
    departamento  NVARCHAR(30)
);
INSERT INTO dbo.DIM_UBIGEO (cod_ubigeo,distrito,provincia,departamento)
SELECT DISTINCT COD_UBIGEO,DISTRITO,PROVINCIA,DEPARTAMENTO
FROM  ODS_SEGURO.ods.vw_ubigeo;
GO

--SELECT* FROM dbo.DIM_UBIGEO

--SELECT* FROM[dbo].[TB_PRODUCTOS_FINANCIEROS_LMP]

--SELECT* FROM[dbo].[CLIENTE_UNICO]
--SELECT* FROM  [dbo].[TB_SEGUROS_LIMPIO]

/*-------------------------------------------------------------
  2-E  DIM_TIPO_SEGURO
-------------------------------------------------------------*/
IF OBJECT_ID('dbo.DIM_TIPO_SEGURO','U') IS NOT NULL DROP TABLE dbo.DIM_TIPO_SEGURO;
CREATE TABLE dbo.DIM_TIPO_SEGURO(
    cod_seguro  NVARCHAR(255)PRIMARY KEY,
    grupo       NVARCHAR(255),
    tipo        NVARCHAR(255),
    subtipo     NVARCHAR(255),
    descripcion NVARCHAR(255)
);
INSERT INTO dbo.DIM_TIPO_SEGURO (cod_seguro,grupo,tipo,subtipo,descripcion)
SELECT DISTINCT CODIGO, GRUPO, TIPO, SUBTIPO, DESCRIPCION
FROM  ODS_SEGURO.ods.vw_tipo_seg;
GO

select*from dbo.DIM_TIPO_SEGURO

/*-----------------------------------------------------------------
  3 ▸ Elimina y crea la tabla DIM_SEXO
-----------------------------------------------------------------*/
IF OBJECT_ID('dbo.DIM_SEXO','U') IS NOT NULL
    DROP TABLE dbo.DIM_SEXO;
GO

CREATE TABLE dbo.DIM_SEXO
(
    id_sexo   INT IDENTITY(1,1) PRIMARY KEY,
    cod_sexo  CHAR(1) COLLATE Modern_Spanish_CI_AS  NOT NULL UNIQUE,
    desc_sexo NVARCHAR(20) COLLATE Modern_Spanish_CI_AS  NULL
);
GO
select*from [ods].[vw_sexo]
/* Pobla—solo inserta códigos que aún no existan */
INSERT INTO dbo.DIM_SEXO (cod_sexo, desc_sexo)
SELECT  v.cod_sexo,
        v.desc_sexo
FROM    ODS_SEGURO.ods.vw_sexo  AS v
LEFT    JOIN dbo.DIM_SEXO       AS d
           ON d.cod_sexo = v.cod_sexo
WHERE   d.cod_sexo IS NULL;        -- evita duplicados
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'ods')
    EXEC('CREATE SCHEMA ods AUTHORIZATION dbo');
GO

/* vista de rangos de edad (códigos 1-7) */
CREATE OR ALTER VIEW ods.vw_rango_edad
AS
SELECT
    id_rango_edad = CASE
                       WHEN EDAD IS NULL            THEN 7     -- sin dato
                       WHEN EDAD < 18               THEN 1     -- 1  <18
                       WHEN EDAD BETWEEN 18 AND 25  THEN 2     -- 2  18-25
                       WHEN EDAD BETWEEN 26 AND 35  THEN 3     -- 3  26-35
                       WHEN EDAD BETWEEN 36 AND 45  THEN 4     -- 4  36-45
                       WHEN EDAD BETWEEN 46 AND 60  THEN 5     -- 5  46-60
                       WHEN EDAD BETWEEN 61 AND 110 THEN 6     -- 6  61-110
                       ELSE 7                                   -- 7  >110
                    END,
  desc_rango = CASE
               WHEN EDAD IS NULL            THEN 'SIN EDAD / >110'   -- id 7
               WHEN EDAD < 18               THEN 'MENOR'             -- id 1
               WHEN EDAD BETWEEN 18 AND 25  THEN 'JOVEN'             -- id 2
               WHEN EDAD BETWEEN 26 AND 35  THEN 'ADULTO JOVEN'      -- id 3
               WHEN EDAD BETWEEN 36 AND 45  THEN 'ADULTO'            -- id 4
               WHEN EDAD BETWEEN 46 AND 60  THEN 'ADULTO MADURO'     -- id 5
               WHEN EDAD BETWEEN 61 AND 110 THEN 'ADULTO MAYOR'      -- id 6
               ELSE '> 110'                                         -- id 7
             END,
    EDAD                                
FROM   BDS_SEGUROS.dbo.CLIENTE_UNICO;
GO
/*-----------------------------------------------------------------
  3 ▸ Elimina y crea la tabla DIM_RANGO_EDAD
-----------------------------------------------------------------*/
IF OBJECT_ID('dbo.DIM_RANGO_EDAD','U') IS NOT NULL
    DROP TABLE dbo.DIM_RANGO_EDAD;
GO

CREATE TABLE dbo.DIM_RANGO_EDAD
(
    id_rango_edad INT PRIMARY KEY,          -- 1 … 7
    desc_rango    VARCHAR(25) NOT NULL
);

/* Carga estática con los textos acordados */
INSERT INTO dbo.DIM_RANGO_EDAD (id_rango_edad, desc_rango) VALUES
 (1,'MENOR'),
 (2,'JOVEN'),
 (3,'ADULTO JOVEN'),
 (4,'ADULTO'),
 (5,'ADULTO MADURO'),
 (6,'ADULTO MAYOR'),
 (7,'>110 / SIN EDAD');
GO

select*from dbo.DIM_RANGO_EDAD;


IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'ods')
    EXEC('CREATE SCHEMA ods AUTHORIZATION dbo');
GO


/*-----------------------------------------------------------------
  3 ▸CREACION DE VISTA Y DIMENSION DE CANAL DE VENTA
-----------------------------------------------------------------*/

/* Vista de Canal de Venta con ID numérico */
CREATE OR ALTER VIEW ods.vw_canal
AS
SELECT DISTINCT
       cod_canal = LTRIM(RTRIM(cod_canal_venta)) COLLATE Modern_Spanish_CI_AS,
       id_canal_venta =
           CASE LTRIM(RTRIM(cod_canal_venta))
               WHEN '01' THEN 1              -- Agencias
               WHEN '02' THEN 2              -- Digital
               WHEN '03' THEN 3              -- Telemarketing
               ELSE         0
           END,
       desc_canal =
           CASE LTRIM(RTRIM(cod_canal_venta))
               WHEN '01' THEN N'Agencias'
               WHEN '02' THEN N'Digital'
               WHEN '03' THEN N'Telemarketing'
               ELSE         N'Por Definir'
           END
FROM   ODS_SEGURO.[ods].[vw_seguro]
WHERE  cod_canal_venta IS NOT NULL
  AND  LTRIM(RTRIM(cod_canal_venta)) <> '';
GO

SELECT DISTINCT cod_canal_venta
FROM ODS_SEGURO.[ods].[vw_seguro]
WHERE cod_canal_venta IS NOT NULL;

SELECT*FROM ods.vw_canal


--
IF OBJECT_ID('DWH_SEGUROS.dbo.DIM_CANAL','U') IS NOT NULL
    DROP TABLE DWH_SEGUROS.dbo.DIM_CANAL;
GO

CREATE TABLE DWH_SEGUROS.dbo.DIM_CANAL (
    id_canal    INT PRIMARY KEY,
    cod_canal   VARCHAR(2) NOT NULL,
    desc_canal  NVARCHAR(50) NOT NULL
);

INSERT INTO DWH_SEGUROS.dbo.DIM_CANAL (id_canal, cod_canal, desc_canal)
SELECT DISTINCT
       id_canal_venta,
       cod_canal,
       desc_canal
FROM   ODS_SEGURO.ods.vw_canal;
GO

SELECT*FROM dbo.DIM_CANAL

/* Asegura que el esquema ODS exista */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'ods')
    EXEC('CREATE SCHEMA ods AUTHORIZATION dbo');
GO

/* Vista de Rango de Ingreso */
CREATE OR ALTER VIEW ods.vw_rango_ingreso
AS
SELECT DISTINCT
    cod_rango_ingreso =
        CASE 
            WHEN INGRESO IS NULL THEN 0
            WHEN INGRESO < 500    THEN 1
            WHEN INGRESO < 1000   THEN 2
            WHEN INGRESO < 2000   THEN 3
            WHEN INGRESO < 3000   THEN 4
            WHEN INGRESO < 5000   THEN 5
            WHEN INGRESO < 10000  THEN 6
            ELSE 7
        END,
    desc_rango_ingreso =
        CASE 
            WHEN INGRESO IS NULL THEN N'Sin Ingreso'
            WHEN INGRESO < 500    THEN N'< S/ 500'
            WHEN INGRESO < 1000   THEN N'S/ 500 - S/ 999'
            WHEN INGRESO < 2000   THEN N'S/ 1,000 - S/ 1,999'
            WHEN INGRESO < 3000   THEN N'S/ 2,000 - S/ 2,999'
            WHEN INGRESO < 5000   THEN N'S/ 3,000 - S/ 4,999'
            WHEN INGRESO < 10000  THEN N'S/ 5,000 - S/ 9,999'
            ELSE                   N'≥ S/ 10,000'
        END
FROM BDS_SEGUROS.dbo.CLIENTE_UNICO
WHERE INGRESO IS NOT NULL;
GO
SELECT*FROM [ods].[vw_rango_ingreso];
--

IF OBJECT_ID('DWH_SEGUROS.dbo.DIM_RANGO_INGRESO','U') IS NOT NULL
    DROP TABLE DWH_SEGUROS.dbo.DIM_RANGO_INGRESO;
GO

CREATE TABLE DWH_SEGUROS.dbo.DIM_RANGO_INGRESO (
    id_rango_ingreso INT PRIMARY KEY,
    desc_rango_ingreso NVARCHAR(50)
);

INSERT INTO DWH_SEGUROS.dbo.DIM_RANGO_INGRESO (id_rango_ingreso, desc_rango_ingreso)
SELECT DISTINCT 
    cod_rango_ingreso,
    desc_rango_ingreso
FROM ODS_SEGURO.ods.vw_rango_ingreso;
GO
---

IF OBJECT_ID('DWH_SEGUROS.dbo.DIM_PRODUCTO_FINANCIERO', 'U') IS NOT NULL
    DROP TABLE DWH_SEGUROS.dbo.DIM_PRODUCTO_FINANCIERO;
GO

CREATE TABLE DWH_SEGUROS.dbo.DIM_PRODUCTO_FINANCIERO (
    id_producto_fin INT IDENTITY(1,1) PRIMARY KEY,
    vip   TINYINT,
    ph    TINYINT,
    tc    TINYINT,
    aho   TINYINT,
    seg   TINYINT,
    sbs   TINYINT
);
GO

-- Insertar combinaciones únicas desde la vista
INSERT INTO DWH_SEGUROS.dbo.DIM_PRODUCTO_FINANCIERO (vip, ph, tc, aho, seg, sbs)
SELECT DISTINCT
    VIP, PH, TC, AHO, SEG, SBS
FROM ODS_SEGURO.ods.vw_producto_fin;
GO
SELECT * FROM DWH_SEGUROS.dbo.DIM_PRODUCTO_FINANCIERO;


/*-------------------------------------------------------------
  2-D. DIM_TIEMPO – Dimensión de fechas por mes
-------------------------------------------------------------*/
IF OBJECT_ID('DWH_SEGUROS.dbo.DIM_TIEMPO','U') IS NOT NULL 
    DROP TABLE DWH_SEGUROS.dbo.DIM_TIEMPO;
GO

CREATE TABLE DWH_SEGUROS.dbo.DIM_TIEMPO (
    id_mes      INT PRIMARY KEY,
    anio        INT,
    mes         TINYINT,
    nombre_mes  VARCHAR(15),
    trimestre   TINYINT,
    semestre    TINYINT
);
GO

;WITH todos AS (
    SELECT mes_corte COLLATE Modern_Spanish_CI_AS AS mes FROM ods_seguro.ods.vw_seguro
    UNION
    SELECT mes_corte COLLATE Modern_Spanish_CI_AS FROM ods_seguro.ods.vw_producto_fin
    UNION
    SELECT mes_actual COLLATE Modern_Spanish_CI_AS FROM ods_seguro.ods.vw_cliente
)
,fechas AS (
    SELECT MIN(CONVERT(INT, mes)) AS min_m, MAX(CONVERT(INT, mes)) AS max_m
    FROM todos
)
,serie AS (
    SELECT TOP (600)
           yyyymm = CONVERT(INT,
                    FORMAT(DATEADD(MONTH, ROW_NUMBER() OVER(ORDER BY (SELECT NULL))-1,
                                   DATEFROMPARTS(f.min_m/100, f.min_m%100,1)),'yyyyMM'))
    FROM fechas f CROSS JOIN sys.all_objects
)
INSERT INTO DWH_SEGUROS.dbo.DIM_TIEMPO (id_mes, anio, mes, nombre_mes, trimestre, semestre)
SELECT 
    yyyymm,
    yyyymm / 100 AS anio,
    yyyymm % 100 AS mes,
    DATENAME(MONTH, DATEFROMPARTS(yyyymm / 100, yyyymm % 100, 1)) AS nombre_mes,
    ((yyyymm % 100 - 1) / 3) + 1 AS trimestre,
    CASE WHEN (yyyymm % 100) <= 6 THEN 1 ELSE 2 END AS semestre
FROM serie
WHERE yyyymm BETWEEN (SELECT min_m FROM fechas) AND (SELECT max_m FROM fechas);
GO

select*from dbo.DIM_TIEMPO

--SELECT 
--    LTRIM(RTRIM(UPPER(SITUACION))) AS cod_situacion,
--    COUNT(*)                       AS cantidad
--FROM 
--    BDS_SEGUROS.dbo.CLIENTE_UNICO
--GROUP BY 
--    LTRIM(RTRIM(UPPER(SITUACION)))
--ORDER BY 
--    cantidad DESC;


/*-------------------------------------------------------------
  6-D. DIM_TIEMPO – CREACION DE VISTA Y DIMENSION DE LA SITUACION DEL CLIENTE
-------------------------------------------------------------*/
CREATE OR ALTER VIEW ods.vw_situacion
AS
SELECT DISTINCT
    cod_situacion = UPPER(LTRIM(RTRIM(SITUACION))),
    desc_situacion =
        CASE UPPER(LTRIM(RTRIM(SITUACION)))
            WHEN 'A' THEN N'Activo'
            WHEN 'P' THEN N'Pasivo'
            WHEN 'C' THEN N'Cerrado'
            ELSE N'Desconocido'
        END
FROM BDS_SEGUROS.dbo.CLIENTE_UNICO
WHERE SITUACION IS NOT NULL AND LTRIM(RTRIM(SITUACION)) <> '';
GO
-- DWH SEGUROS DIMENSION 
IF OBJECT_ID('DWH_SEGUROS.dbo.DIM_SITUACION','U') IS NOT NULL
    DROP TABLE DWH_SEGUROS.dbo.DIM_SITUACION;
GO

CREATE TABLE DWH_SEGUROS.dbo.DIM_SITUACION (
    id_situacion   INT IDENTITY(1,1) PRIMARY KEY,
    cod_situacion  VARCHAR(10) NOT NULL UNIQUE,
    desc_situacion NVARCHAR(50)
);
GO


-- Poblar desde la vista ODS
INSERT INTO DWH_SEGUROS.dbo.DIM_SITUACION (cod_situacion, desc_situacion)
SELECT cod_situacion, desc_situacion
FROM   ODS_SEGURO.ods.vw_situacion;
GO

--CREACION DE DIMENSION SEGMENTO : 
/* Elimina si ya existe */
IF OBJECT_ID('DWH_SEGUROS.dbo.DIM_SEGMENTO','U') IS NOT NULL
    DROP TABLE DWH_SEGUROS.dbo.DIM_SEGMENTO;
GO


CREATE TABLE DWH_SEGUROS.dbo.DIM_SEGMENTO (
    cod_segmento  NVARCHAR(255) PRIMARY KEY,  -- 
    desc_segmento NVARCHAR(255),
    grupo         NVARCHAR(255)
);
GO

SELECT * FROM DWH_SEGUROS.dbo.DIM_SEGMENTO;



/* Inserta los valores desde la vista ODS */
INSERT INTO DWH_SEGUROS.dbo.DIM_SEGMENTO (cod_segmento, desc_segmento, grupo)
SELECT DISTINCT
    COD_SEGMENTO COLLATE Modern_Spanish_CI_AS,
    DESC_SEGMENTO COLLATE Modern_Spanish_CI_AS,
    GRUPO COLLATE Modern_Spanish_CI_AS
FROM ODS_SEGURO.ods.vw_segmento;
GO



SELECT* FROM dbo.DIM_SITUACION
--CREACION DE LA DIMENSION CLIENTE
USE DWH_SEGUROS;
GO

/*-------------------------------------------------------------
  1-A. Vista de Clientes 
-------------------------------------------------------------*/



SELECT TOP 1 * FROM ODS_SEGURO.ods.vw_cliente;
--DWH SEGUROS CLIENTE CREACION DE DIMENSION
-- Eliminar tabla si ya existe


SELECT DISTINCT desc_rango_ingreso FROM DWH_SEGUROS.dbo.DIM_RANGO_INGRESO;


SELECT*FROM [dbo].[BD_TB_SEGURO]



SELECT 
    CODIGO,
    MES_CORTE,
    cd_subproducto,
    cd_canal_venta,
    cd_divisa,
    fh_apertura,
    fh_vencimiento,
    im_prima,
    im_capital_aseg,
    im_comision,
    COUNT(*) AS cantidad
FROM dbo.BD_TB_SEGURO
GROUP BY 
    CODIGO,
    MES_CORTE,
    cd_subproducto,
    cd_canal_venta,
    cd_divisa,
    fh_apertura,
    fh_vencimiento,
    im_prima,
    im_capital_aseg,
    im_comision
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;










SELECT*FROM [dbo].[TB_SEGUROS_LIMPIO]





select*from DIM_CLIENTE






select*from[dbo].[CLIENTE_UNICO]
select*from[dbo].[TB_SEGUROS_LIMPIO]  70980xxx
select*from[dbo].[TB_PRODUCTOS_FINANCIEROS_LMP]

SELECT CODIGO, COUNT(*) AS cantidad
FROM [dbo].[CLIENTE_UNICO]
GROUP BY CODIGO
HAVING COUNT(*) > 1;


SELECT CODIGO, MES_CORTE, COUNT(*) AS cantidad
FROM [dbo].[TB_SEGUROS_LIMPIO]
GROUP BY CODIGO, MES_CORTE
HAVING COUNT(*) > 1;

SELECT * FROM [dbo].[CLIENTE_UNICO]
WHERE CODIGO = '8002581030';

SELECT * FROM [dbo].[TB_SEGUROS_LIMPIO]
WHERE CODIGO = '8002581030';

SELECT DISTINCT s.CODIGO
FROM [dbo].[TB_SEGUROS_LIMPIO] s
LEFT JOIN [dbo].[CLIENTE_UNICO] c 
    ON s.CODIGO COLLATE Modern_Spanish_CI_AS = c.CODIGO COLLATE Modern_Spanish_CI_AS
WHERE c.CODIGO IS NULL;

SELECT 
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DIM_PRODUCTO_FINANCIERO' 
  AND TABLE_SCHEMA = 'dbo';
  SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TB_SEGUROS_LIMPIO'
  AND TABLE_SCHEMA = 'dbo';

  select*from DIM_PRODUCTO_FINANCIERO

ALTER TABLE [dbo].[CLIENTE_UNICO]
ADD CONSTRAINT PK_CLIENTE_UNICO PRIMARY KEY (CODIGO);

-- GENERACION DE PK EN TB SEGURO LIMPIO 
-- 1. Agrega una nueva columna (si no existe aún)
;WITH seguros_numerados AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn,
        *
    FROM dbo.TB_SEGUROS_LIMPIO
)
UPDATE seguros_numerados
SET cod_seguro = RIGHT('707' + RIGHT('000000' + CAST(rn AS VARCHAR), 6), 9);




-- Duplicados
SELECT cod_seguro, COUNT(*) 
FROM dbo.TB_SEGUROS_LIMPIO
GROUP BY cod_seguro
HAVING COUNT(*) > 1;

-- Nulos
SELECT COUNT(*) FROM dbo.TB_SEGUROS_LIMPIO WHERE cod_seguro IS NULL;



USE DWH_SEGUROS;
GO

-- ========================================
-- CREACIÓN DE TABLA DE HECHOS: FACT_SEGURO
--DIMENSIONES DIM_TIEMPO DIM_TIPO_SEGURO  DIM_CANAL  DIM_SEGMENTO   DIM_SITUACION   CLIENTE_UNICO 
-- ========================================








select*from [dbo].[TB_PRODUCTOS_FINANCIEROS_LMP]



select*from [dbo].[CLIENTE_UNICO]



select*from[dbo].[TB_SEGUROS_LIMPIO]

select*from [dbo].[DIM_PRODUCTO_FINANCIERO]
select*from DIM_PRODUCTO_FINANCIERO
--EXEC sp_help DIM_PRODUCTO_FINANCIERO;
--EXEC sp_help DIM_TIPO_SEGURO;
--EXEC sp_help DIM_CANAL;
--EXEC sp_help DIM_SEGMENTO;
--EXEC sp_help DIM_SITUACION;


--SELECT
--    cu.CODIGO AS cod_cliente,
--    cu.EDAD,
--    CASE
--        WHEN cu.EDAD < 18 THEN 1
--        WHEN cu.EDAD BETWEEN 18 AND 25 THEN 2
--        WHEN cu.EDAD BETWEEN 26 AND 35 THEN 3
--        WHEN cu.EDAD BETWEEN 36 AND 50 THEN 4
--        WHEN cu.EDAD BETWEEN 51 AND 65 THEN 5
--        WHEN cu.EDAD BETWEEN 66 AND 110 THEN 6
--        ELSE 7
--    END AS id_rango_edad
--INTO #cliente_con_rango_edad
--FROM BDS_SEGUROS.dbo.CLIENTE_UNICO cu;

-- 1. Eliminar FACT_SEGURO_FINAL si ya existe
IF OBJECT_ID('dbo.FACT_SEGURO_FINAL', 'U') IS NOT NULL
    DROP TABLE dbo.FACT_SEGURO_FINAL;
GO

-- 2. Crear FACT_SEGURO_FINAL con todas las dimensiones y medidas
CREATE TABLE dbo.FACT_SEGURO_FINAL (
    id_seguro               INT PRIMARY KEY,
    cod_cliente             VARCHAR(20),         -- FK hacia DIM_CLIENTE
    id_tiempo               INT,                 -- FK hacia DIM_TIEMPO
    id_tipo_seguro          NVARCHAR(50),        -- FK hacia DIM_TIPO_SEGURO
    id_producto_financiero  INT,                 -- FK hacia DIM_PRODUCTO_FINANCIERO
    id_canal                INT,                 -- FK hacia DIM_CANAL

    -- Medidas
    im_prima                FLOAT,
    im_capital_aseg         FLOAT,
    im_comision             FLOAT
);
GO


WITH base_refactorizada AS (
    SELECT
        s.id_seguro,
        cu.cod_cliente COLLATE DATABASE_DEFAULT AS cod_cliente,
        t.id_mes AS id_tiempo,
        ts.cod_seguro COLLATE DATABASE_DEFAULT AS id_tipo_seguro,
        dpf.id_producto_fin AS id_producto_financiero,
        c.id_canal,

        s.im_prima,
        s.im_capital_aseg,
        s.im_comision,
        ROW_NUMBER() OVER (PARTITION BY s.id_seguro ORDER BY s.id_seguro) AS fila

    FROM BDS_SEGUROS.dbo.TB_SEGUROS_LIMPIO s

    -- Cliente único (DIM_CLIENTE)
    LEFT JOIN DWH_SEGUROS.dbo.DIM_CLIENTE cu
        ON cu.cod_cliente COLLATE DATABASE_DEFAULT = s.CODIGO COLLATE DATABASE_DEFAULT

    -- Tiempo
    LEFT JOIN DWH_SEGUROS.dbo.DIM_TIEMPO t
        ON t.id_mes = TRY_CAST(s.MES_CORTE AS INT)

    -- Tipo de seguro
    LEFT JOIN DWH_SEGUROS.dbo.DIM_TIPO_SEGURO ts
        ON ts.cod_seguro COLLATE DATABASE_DEFAULT = LEFT(s.cd_subproducto, 4) COLLATE DATABASE_DEFAULT

    -- Canal
    LEFT JOIN DWH_SEGUROS.dbo.DIM_CANAL c
        ON c.cod_canal COLLATE DATABASE_DEFAULT = s.cd_canal_venta COLLATE DATABASE_DEFAULT

    -- Productos financieros base
    LEFT JOIN BDS_SEGUROS.dbo.TB_PRODUCTOS_FINANCIEROS_LMP pf
        ON pf.CODIGO COLLATE DATABASE_DEFAULT = s.CODIGO COLLATE DATABASE_DEFAULT
       AND pf.MES_CORTE COLLATE DATABASE_DEFAULT = s.MES_CORTE COLLATE DATABASE_DEFAULT

    -- Dimensión de producto financiero
    LEFT JOIN DWH_SEGUROS.dbo.DIM_PRODUCTO_FINANCIERO dpf
        ON dpf.vip = pf.FLGVIP
        AND dpf.ph = pf.FLGVPH
        AND dpf.tc = pf.FLGTC
        AND dpf.aho = pf.FLGAHO
        AND dpf.seg = pf.FLGSEG
        AND dpf.sbs = pf.FLGSBS
)

-- Insertar datos únicos en tabla de hechos
INSERT INTO dbo.FACT_SEGURO_FINAL (
    id_seguro,
    cod_cliente,
    id_tiempo,
    id_tipo_seguro,
    id_producto_financiero,
    id_canal,
    im_prima,
    im_capital_aseg,
    im_comision
)
SELECT
    id_seguro,
    cod_cliente,
    id_tiempo,
    id_tipo_seguro,
    id_producto_financiero,
    id_canal,
    im_prima,
    im_capital_aseg,
    im_comision
FROM base_refactorizada
WHERE fila = 1;
GO




select*from dbo.FACT_SEGURO_FINAL



select*from [dbo].[TB_TIPO_SEGURO]










SELECT s.id_seguro, COUNT(*) AS veces
FROM BDS_SEGUROS.dbo.TB_SEGUROS_LIMPIO s
-- todos los joins que estés usando aquí...
GROUP BY s.id_seguro
HAVING COUNT(*) > 1;

SELECT id_seguro, COUNT(*) AS cantidad
FROM BDS_SEGUROS.dbo.TB_SEGUROS_LIMPIO
GROUP BY id_seguro
HAVING COUNT(*) > 1;



SELECT TOP 10 * FROM dbo.FACT_SEGURO_FINAL;

-- Verificar registros huérfanos (sin cliente)
SELECT s.CODIGO
FROM BDS_SEGUROS.dbo.TB_SEGUROS_LIMPIO s
LEFT JOIN DWH_SEGUROS.dbo.DIM_CLIENTE c
    ON c.cod_cliente COLLATE DATABASE_DEFAULT = s.CODIGO COLLATE DATABASE_DEFAULT
WHERE c.cod_cliente IS NULL;



SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('FACT_SEGURO_FINAL', 'DIM_TIPO_SEGURO')
  AND COLUMN_NAME IN ('id_tipo_seguro', 'cod_seguro');

  EXEC sp_help 'DWH_SEGUROS.dbo.FACT_SEGURO_FINAL';




-- 2. Crear estructura
CREATE TABLE dbo.DIM_CLIENTE (
    cod_cliente    VARCHAR(20) PRIMARY KEY,
    edad           INT,
    id_rango_edad  INT,
    id_rango_ingreso INT,
    id_ubigeo      NVARCHAR(10),
    id_segmento    NVARCHAR(255),
    id_situacion   VARCHAR(10),
    id_sexo        CHAR(1)
);
GO

INSERT INTO dbo.DIM_CLIENTE (
    cod_cliente,
    edad,
    id_rango_edad,
    id_rango_ingreso,
    id_ubigeo,
    id_segmento,
    id_situacion,
    id_sexo
)
SELECT 
    cu.CODIGO,
    cu.EDAD,
    CASE
        WHEN cu.EDAD IS NULL THEN 7
        WHEN cu.EDAD < 18 THEN 1
        WHEN cu.EDAD BETWEEN 18 AND 25 THEN 2
        WHEN cu.EDAD BETWEEN 26 AND 35 THEN 3
        WHEN cu.EDAD BETWEEN 36 AND 45 THEN 4
        WHEN cu.EDAD BETWEEN 46 AND 60 THEN 5
        WHEN cu.EDAD BETWEEN 61 AND 110 THEN 6
        ELSE 7
    END AS id_rango_edad,
    CASE 
        WHEN cu.INGRESO IS NULL THEN 0
        WHEN cu.INGRESO < 500 THEN 1
        WHEN cu.INGRESO < 1000 THEN 2
        WHEN cu.INGRESO < 2000 THEN 3
        WHEN cu.INGRESO < 3000 THEN 4
        WHEN cu.INGRESO < 5000 THEN 5
        WHEN cu.INGRESO < 10000 THEN 6
        ELSE 7
    END AS id_rango_ingreso,
    cu.UBIGEO,
    cu.SEGMENTO,
    cu.SITUACION,
    cu.SEXO
FROM BDS_SEGUROS.dbo.CLIENTE_UNICO cu;
GO

SELECT TOP 10 * FROM dbo.DIM_CLIENTE;

-- Variables con las relaciones deseadas
DECLARE @relaciones TABLE (
    tabla_fact NVARCHAR(128),
    columna_fact NVARCHAR(128),
    tabla_dim NVARCHAR(128),
    columna_dim NVARCHAR(128)
);


INSERT INTO @relaciones (tabla_fact, columna_fact, tabla_dim, columna_dim)
VALUES 
('FACT_SEGURO_FINAL', 'id_tiempo',              'DIM_TIEMPO',              'id_mes'),
('FACT_SEGURO_FINAL', 'id_tipo_seguro',         'DIM_TIPO_SEGURO',        'cod_seguro'),
('FACT_SEGURO_FINAL', 'id_producto_financiero', 'DIM_PRODUCTO_FINANCIERO','id_producto_fin'),
('FACT_SEGURO_FINAL', 'id_canal',               'DIM_CANAL',               'id_canal'),
('FACT_SEGURO_FINAL', 'id_segmento',            'DIM_SEGMENTO',            'cod_segmento'),
('FACT_SEGURO_FINAL', 'id_situacion',           'DIM_SITUACION',           'id_situacion'),
('FACT_SEGURO_FINAL', 'id_ubigeo',              'DIM_UBIGEO',              'cod_ubigeo'),
('FACT_SEGURO_FINAL', 'id_sexo',                'DIM_SEXO',                'cod_sexo'),
('FACT_SEGURO_FINAL', 'rango_edad',             'DIM_RANGO_EDAD',          'id_rango_edad'),
('FACT_SEGURO_FINAL', 'rango_ingreso',          'DIM_RANGO_INGRESO',       'id_rango_ingreso');

-- Consulta de verificación
SELECT 
    r.tabla_fact,
    r.columna_fact,
    f.DATA_TYPE     AS tipo_fact,
    f.CHARACTER_MAXIMUM_LENGTH AS largo_fact,
    
    r.tabla_dim,
    r.columna_dim,
    d.DATA_TYPE     AS tipo_dim,
    d.CHARACTER_MAXIMUM_LENGTH AS largo_dim,

    CASE 
        WHEN f.DATA_TYPE = d.DATA_TYPE AND ISNULL(f.CHARACTER_MAXIMUM_LENGTH, -1) = ISNULL(d.CHARACTER_MAXIMUM_LENGTH, -1)
        THEN '✅ OK'
        ELSE '❌ INCOMPATIBLE'
    END AS resultado

FROM @relaciones r
JOIN INFORMATION_SCHEMA.COLUMNS f
    ON f.TABLE_NAME = r.tabla_fact AND f.COLUMN_NAME = r.columna_fact
JOIN INFORMATION_SCHEMA.COLUMNS d
    ON d.TABLE_NAME = r.tabla_dim AND d.COLUMN_NAME = r.columna_dim
ORDER BY resultado DESC, r.tabla_fact, r.columna_fact;


-- 🔒 Relación con DIM_CANAL
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_CANAL
FOREIGN KEY (id_canal)
REFERENCES dbo.DIM_CANAL(id_canal);

-- 🔒 Relación con DIM_PRODUCTO_FINANCIERO
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_PROD_FIN
FOREIGN KEY (id_producto_financiero)
REFERENCES dbo.DIM_PRODUCTO_FINANCIERO(id_producto_fin);

-- 🔒 Relación con DIM_TIEMPO
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_TIEMPO
FOREIGN KEY (id_tiempo)
REFERENCES dbo.DIM_TIEMPO(id_mes);

-- 🔒 Relación con DIM_TIPO_SEGURO
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_TIPO_SEGURO
FOREIGN KEY (id_tipo_seguro)
REFERENCES dbo.DIM_TIPO_SEGURO(cod_seguro);

-- 🔒 Relación con DIM_SEGMENTO
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SEGMENTO
FOREIGN KEY (id_segmento)
REFERENCES dbo.DIM_SEGMENTO(cod_segmento);

-- 🔒 Relación con DIM_SITUACION
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SITUACION
FOREIGN KEY (id_situacion)
REFERENCES dbo.DIM_SITUACION(id_situacion);

-- 🔒 Relación con DIM_UBIGEO
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_UBIGEO
FOREIGN KEY (id_ubigeo)
REFERENCES dbo.DIM_UBIGEO(cod_ubigeo);

-- 🔒 Relación con DIM_SEXO
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SEXO
FOREIGN KEY (id_sexo)
REFERENCES dbo.DIM_SEXO(cod_sexo);

-- 🔒 Relación con DIM_RANGO_EDAD
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_RANGO_EDAD
FOREIGN KEY (rango_edad)
REFERENCES dbo.DIM_RANGO_EDAD(id_rango_edad);

-- 🔒 Relación con DIM_RANGO_INGRESO
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_RANGO_INGRESO
FOREIGN KEY (rango_ingreso)
REFERENCES dbo.DIM_RANGO_INGRESO(id_rango_ingreso);


SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FACT_SEGURO_FINAL';


UPDATE F
SET 
    F.id_segmento = CU.SEGMENTO,
    F.id_situacion = CU.SITUACION,
    F.id_ubigeo = CU.UBIGEO,
    F.id_sexo = CU.SEXO,
    F.id_rango_edad = 
        CASE 
            WHEN CU.EDAD IS NULL THEN 7
            WHEN CU.EDAD < 18 THEN 1
            WHEN CU.EDAD BETWEEN 18 AND 25 THEN 2
            WHEN CU.EDAD BETWEEN 26 AND 35 THEN 3
            WHEN CU.EDAD BETWEEN 36 AND 45 THEN 4
            WHEN CU.EDAD BETWEEN 46 AND 60 THEN 5
            WHEN CU.EDAD BETWEEN 61 AND 110 THEN 6
            ELSE 7
        END,
    F.id_rango_ingreso = 
        CASE 
            WHEN CU.INGRESO IS NULL THEN 0
            WHEN CU.INGRESO < 500 THEN 1
            WHEN CU.INGRESO < 1000 THEN 2
            WHEN CU.INGRESO < 2000 THEN 3
            WHEN CU.INGRESO < 3000 THEN 4
            WHEN CU.INGRESO < 5000 THEN 5
            WHEN CU.INGRESO < 10000 THEN 6
            ELSE 7
        END
FROM FACT_SEGURO_FINAL F
JOIN BDS_SEGUROS.dbo.CLIENTE_UNICO CU
    ON F.cod_cliente = CU.CODIGO;

-- PARA VERIFICAR SI EN SEGMENTO HAY 0
	SELECT id_segmento
FROM FACT_SEGURO_FINAL
WHERE id_segmento NOT IN (SELECT cod_segmento FROM DWH_SEGUROS.dbo.DIM_SEGMENTO);


-- Segmento
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SEGMENTO
FOREIGN KEY (id_segmento)
REFERENCES DWH_SEGUROS.dbo.DIM_SEGMENTO(cod_segmento);

-- Situación
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SITUACION
FOREIGN KEY (id_situacion)
REFERENCES DWH_SEGUROS.dbo.DIM_SITUACION(cod_situacion);

-- Ubigeo
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_UBIGEO
FOREIGN KEY (id_ubigeo)
REFERENCES DWH_SEGUROS.dbo.DIM_UBIGEO(cod_ubigeo);

-- Sexo
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SEXO
FOREIGN KEY (id_sexo)
REFERENCES DWH_SEGUROS.dbo.DIM_SEXO(cod_sexo);

-- Rango Edad
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_RANGO_EDAD
FOREIGN KEY (id_rango_edad)
REFERENCES DWH_SEGUROS.dbo.DIM_RANGO_EDAD(id_rango_edad);

-- Rango Ingreso
ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_RANGO_INGRESO
FOREIGN KEY (id_rango_ingreso)
REFERENCES DWH_SEGUROS.dbo.DIM_RANGO_INGRESO(id_rango_ingreso);

SELECT*FROM [dbo].[FACT_SEGURO_FINAL]

SELECT id_situacion
FROM FACT_SEGURO_FINAL
WHERE id_situacion NOT IN (SELECT id_situacion FROM DIM_SITUACION);

SELECT id_ubigeo
FROM FACT_SEGURO_FINAL
WHERE id_ubigeo NOT IN (SELECT cod_ubigeo FROM DIM_UBIGEO);

-- Verificar id_sexo no existente en DIM_SEXO
SELECT id_sexo
FROM FACT_SEGURO_FINAL
WHERE id_sexo NOT IN (SELECT id_sexo FROM DIM_SEXO);

-- Verificar id_rango_edad no existente en DIM_RANGO_EDAD
SELECT id_rango_edad
FROM FACT_SEGURO_FINAL
WHERE id_rango_edad NOT IN (SELECT id_rango_edad FROM DIM_RANGO_EDAD);

-- Verificar id_rango_ingreso no existente en DIM_RANGO_INGRESO
SELECT id_rango_ingreso
FROM FACT_SEGURO_FINAL
WHERE id_rango_ingreso NOT IN (SELECT id_rango_ingreso FROM DIM_RANGO_INGRESO);


SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FACT_SEGURO_FINAL' AND COLUMN_NAME = 'id_situacion'

UNION ALL

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DIM_SITUACION' AND COLUMN_NAME = 'id_situacion';

DROP INDEX PK_DIM_SITU_1EE89D7AD8CE0C20 ON DIM_SITUACION;



select*from DIM_SITUACION
SELECT name
FROM sys.key_constraints
WHERE parent_object_id = OBJECT_ID('DIM_SITUACION')
  AND type = 'PK';

ALTER TABLE DIM_SITUACION
ALTER COLUMN id_situacion NVARCHAR(10);


SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FACT_SEGURO_FINAL' AND COLUMN_NAME = 'id_situacion';


ALTER TABLE FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SITUACION
FOREIGN KEY (id_situacion)
REFERENCES DIM_SITUACION(cod_situacion);

ALTER TABLE DIM_SITUACION
ALTER COLUMN cod_situacion NVARCHAR(10);

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FACT_SEGURO_FINAL' AND COLUMN_NAME = 'id_situacion'
UNION ALL
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DIM_SITUACION' AND COLUMN_NAME = 'cod_situacion';


ALTER TABLE DIM_SITUACION
ADD CONSTRAINT PK_DIM_SITUACION PRIMARY KEY (cod_situacion);

ALTER TABLE DIM_SITUACION
ADD CONSTRAINT PK_DIM_SITUACION PRIMARY KEY (cod_situacion);


ALTER TABLE FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SITUACION
FOREIGN KEY (id_situacion)
REFERENCES DIM_SITUACION(cod_situacion);

select*from FACT_SEGURO_FINAL


-- UBIGEO
SELECT DISTINCT id_ubigeo
FROM FACT_SEGURO_FINAL
WHERE id_ubigeo NOT IN (SELECT cod_ubigeo FROM DIM_UBIGEO);
SELECT* FROM[dbo].[DIM_UBIGEO] 

SELECT DISTINCT id_sexo
FROM FACT_SEGURO_FINAL
WHERE id_sexo NOT IN (SELECT cod_sexo FROM DIM_SEXO);

ALTER TABLE FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SEXO
FOREIGN KEY (id_sexo)
REFERENCES DIM_SEXO(cod_sexo);

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('FACT_SEGURO_FINAL', 'DIM_SEXO')
AND COLUMN_NAME IN ('id_sexo', 'cod_sexo');

ALTER TABLE FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_SEXO
FOREIGN KEY (id_sexo)
REFERENCES DIM_SEXO(id_sexo);


SELECT DISTINCT cod_cliente
FROM FACT_SEGURO_FINAL
WHERE cod_cliente NOT IN (
    SELECT cod_cliente FROM DIM_CLIENTE
);
ALTER TABLE FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_CLIENTE
FOREIGN KEY (cod_cliente)
REFERENCES DIM_CLIENTE(cod_cliente);


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DIM_CLIENTE';

SELECT DISTINCT c.cod_agencia
FROM FACT_SEGURO_FINAL f
JOIN DIM_CLIENTE c ON f.cod_cliente = c.cod_cliente
WHERE c.cod_agencia NOT IN (
    SELECT cod_agencia FROM DIM_AGENCIA
);
SELECT TOP 10 * FROM FACT_SEGURO_FINAL;
SELECT TOP 10 * FROM [ods].[vw_seguro];

SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_SCHEMA, TABLE_NAME, ORDINAL_POSITION;

SELECT 
    t.name AS tabla,
    kc.name AS constraint_name,
    c.name AS columna,
    kc.type_desc AS tipo_constraint
FROM sys.key_constraints kc
INNER JOIN sys.tables t ON kc.parent_object_id = t.object_id
INNER JOIN sys.index_columns ic ON ic.object_id = t.object_id AND ic.index_id = kc.unique_index_id
INNER JOIN sys.columns c ON c.object_id = t.object_id AND c.column_id = ic.column_id
WHERE kc.type = 'PK'
ORDER BY t.name, kc.name;

USE DWH_SEGUROS;
GO

SELECT 
    fk.name AS nombre_constraint,
    OBJECT_NAME(fk.parent_object_id) AS tabla_hija,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS columna_hija,
    OBJECT_NAME(fk.referenced_object_id) AS tabla_padre,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS columna_padre
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
ORDER BY tabla_hija, nombre_constraint;

SELECT id_ubigeo
FROM dbo.FACT_SEGURO_FINAL
WHERE id_ubigeo NOT IN (SELECT cod_ubigeo FROM dbo.DIM_UBIGEO);

-- Revisa los datos faltantes primero
SELECT DISTINCT id_ubigeo
FROM dbo.FACT_SEGURO_FINAL
WHERE id_ubigeo NOT IN (SELECT cod_ubigeo FROM dbo.DIM_UBIGEO);


INSERT INTO DWH_SEGUROS.dbo.DIM_UBIGEO (cod_ubigeo, distrito, provincia, departamento)
SELECT DISTINCT
    B.COD_UBIGEO COLLATE Modern_Spanish_CI_AS,
    B.DISTRITO COLLATE Modern_Spanish_CI_AS,
    B.PROVINCIA COLLATE Modern_Spanish_CI_AS,
    B.DEPARTAMENTO COLLATE Modern_Spanish_CI_AS
FROM DWH_SEGUROS.dbo.FACT_SEGURO_FINAL AS F
LEFT JOIN DWH_SEGUROS.dbo.DIM_UBIGEO AS D 
    ON F.id_ubigeo = D.cod_ubigeo
INNER JOIN BDS_SEGUROS.dbo.BD_UBIGEO_limpio AS B 
    ON F.id_ubigeo = B.COD_UBIGEO COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE D.cod_ubigeo IS NULL;

SELECT DISTINCT F.id_ubigeo
FROM DWH_SEGUROS.dbo.FACT_SEGURO_FINAL F
LEFT JOIN DWH_SEGUROS.dbo.DIM_UBIGEO D ON F.id_ubigeo = D.cod_ubigeo
WHERE D.cod_ubigeo IS NULL;


-- Para DIM_UBIGEO (en DWH_SEGUROS)
EXEC sp_help 'dbo.DIM_UBIGEO';

-- Para BD_UBIGEO_limpio (en BDS_SEGUROS)
EXEC sp_help 'BDS_SEGUROS.dbo.BD_UBIGEO_limpio';

SELECT TOP 5 * FROM DWH_SEGUROS.dbo.DIM_UBIGEO;
SELECT TOP 5 * FROM BDS_SEGUROS.dbo.BD_UBIGEO_limpio;

INSERT INTO DWH_SEGUROS.dbo.DIM_UBIGEO (cod_ubigeo, distrito, provincia, departamento)
SELECT DISTINCT 
    F.id_ubigeo,
    'DESCONOCIDO',
    'DESCONOCIDO',
    'DESCONOCIDO'
FROM DWH_SEGUROS.dbo.FACT_SEGURO_FINAL F
LEFT JOIN DWH_SEGUROS.dbo.DIM_UBIGEO D ON F.id_ubigeo = D.cod_ubigeo
LEFT JOIN BDS_SEGUROS.dbo.BD_UBIGEO_limpio B 
  ON F.id_ubigeo = B.COD_UBIGEO COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE D.cod_ubigeo IS NULL AND B.COD_UBIGEO IS NULL;


SELECT COUNT(*)
FROM DWH_SEGUROS.dbo.FACT_SEGURO_FINAL F
LEFT JOIN DWH_SEGUROS.dbo.DIM_UBIGEO D ON F.id_ubigeo = D.cod_ubigeo
WHERE D.cod_ubigeo IS NULL;

ALTER TABLE DWH_SEGUROS.dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_UBIGEO
FOREIGN KEY (id_ubigeo) 
REFERENCES DWH_SEGUROS.dbo.DIM_UBIGEO(cod_ubigeo);

ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD id_agencia varchar(4) NULL;
UPDATE F
SET id_agencia = CU.AGENCIA
FROM dbo.FACT_SEGURO_FINAL F
INNER JOIN BDS_SEGUROS.dbo.CLIENTE_UNICO CU 
    ON F.cod_cliente = CU.CODIGO;



select*from[dbo].[CLIENTE_UNICO]
select*from[dbo].[FACT_SEGURO_FINAL]

SELECT id_agencia
FROM dbo.FACT_SEGURO_FINAL
WHERE id_agencia NOT IN (SELECT cod_agencia FROM dbo.DIM_AGENCIA);

INSERT INTO dbo.DIM_AGENCIA (cod_agencia, banca, zona, agencia)
SELECT DISTINCT 
    A.COD_AGENCIA,
    A.BANCA,
    A.ZONA,
    A.AGENCIA
FROM dbo.FACT_SEGURO_FINAL F
INNER JOIN BDS_SEGUROS.dbo.BD_AGENCIAS_LMP A 
    ON F.id_agencia = A.COD_AGENCIA
LEFT JOIN dbo.DIM_AGENCIA D 
    ON A.COD_AGENCIA = D.cod_agencia
WHERE D.cod_agencia IS NULL;

SELECT DISTINCT TOP 10 id_agencia
FROM dbo.FACT_SEGURO_FINAL
ORDER BY id_agencia;

select*from [dbo].[DIM_SEGMENTO]
SELECT DISTINCT TOP 10 COD_AGENCIA
FROM BDS_SEGUROS.dbo.BD_AGENCIAS_LMP
ORDER BY COD_AGENCIA;

SELECT id_agencia
FROM dbo.FACT_SEGURO_FINAL
WHERE id_agencia COLLATE Modern_Spanish_CI_AS 
      NOT IN (
         SELECT cod_agencia FROM dbo.DIM_AGENCIA
      );

INSERT INTO dbo.DIM_AGENCIA (cod_agencia, banca, zona, agencia)
SELECT DISTINCT 
    A.COD_AGENCIA COLLATE Modern_Spanish_CI_AS,
    A.BANCA COLLATE Modern_Spanish_CI_AS,
    A.ZONA COLLATE Modern_Spanish_CI_AS,
    A.AGENCIA COLLATE Modern_Spanish_CI_AS
FROM dbo.FACT_SEGURO_FINAL F
LEFT JOIN dbo.DIM_AGENCIA D 
    ON F.id_agencia COLLATE Modern_Spanish_CI_AS = D.cod_agencia
INNER JOIN BDS_SEGUROS.dbo.BD_AGENCIAS_LMP A 
    ON F.id_agencia COLLATE SQL_Latin1_General_CP1_CI_AS = A.COD_AGENCIA COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE D.cod_agencia IS NULL;


-- Asegúrate primero que es VARCHAR, no INT
UPDATE dbo.FACT_SEGURO_FINAL
SET id_agencia = RIGHT('0000' + id_agencia, 4)
WHERE LEN(id_agencia) < 4;

SELECT id_agencia
FROM dbo.FACT_SEGURO_FINAL
WHERE id_agencia NOT IN (SELECT cod_agencia FROM dbo.DIM_AGENCIA);

ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD CONSTRAINT FK_FACT_AGENCIA
FOREIGN KEY (id_agencia) REFERENCES dbo.DIM_AGENCIA(cod_agencia);

select*from[dbo].[DIM_PRODUCTO_FINANCIERO]

ALTER TABLE dbo.FACT_SEGURO_FINAL
ADD es_vip BIT,
    es_tc BIT,
    es_ph BIT,
    es_ahorro BIT,
    es_seg BIT,
    es_sbs BIT;



	UPDATE f
SET 
    f.es_vip    = ISNULL(pf.vip, 0),
    f.es_tc     = ISNULL(pf.tc, 0),
    f.es_ph     = ISNULL(pf.ph, 0),
    f.es_ahorro = ISNULL(pf.aho, 0),
    f.es_seg    = ISNULL(pf.seg, 0),
    f.es_sbs    = ISNULL(pf.sbs, 0)
FROM FACT_SEGURO_FINAL f
JOIN DIM_PRODUCTO_FINANCIERO pf
  ON f.id_producto_financiero = pf.id_producto_fin;


select*from dbo.FACT_SEGURO_FINAL


USE DWH_SEGUROS;
GO
CREATE LOGIN [DESKTOP-A55PRUO\ssas_user] FROM WINDOWS; -- CREAR EL LOGIN DEL USUARIO 
GO


EXECUTE AS LOGIN = 'DESKTOP-A55PRUO\ssas_user';
SELECT TOP 10 * FROM DWH_SEGUROS.dbo.DIM_RANGO_INGRESO;
REVERT;

CREATE USER [DESKTOP-A55PRUO\ssas_user] FOR LOGIN [DESKTOP-A55PRUO\ssas_user];

EXEC sp_addrolemember 'db_datareader', 'DESKTOP-A55PRUO\ssas_user';  -- CONTRASEÑA SSAS2025!


EXECUTE AS LOGIN = 'DESKTOP-A55PRUO\ssas_user';
SELECT TOP 10 * FROM DWH_SEGUROS.dbo.DIM_RANGO_INGRESO;
REVERT;


CREATE OR ALTER VIEW BI_Segmentacion_Clientes_Categorizada
AS
WITH base AS (
    SELECT
        f.cod_cliente,
        DATEDIFF(DAY, MAX(s.fecha_apertura), GETDATE()) AS dias_desde_ultima_compra,
        COUNT(DISTINCT f.id_tipo_seguro) AS total_seguros,
        AVG(f.im_prima) AS prima_promedio,

        -- Indicadores binarios con cast a INT para evitar error
        MAX(CAST(f.es_vip AS INT))    AS es_vip,
        MAX(CAST(f.es_tc AS INT))     AS es_tc,
        MAX(CAST(f.es_ph AS INT))     AS es_ph,
        MAX(CAST(f.es_ahorro AS INT)) AS es_ahorro,
        MAX(CAST(f.es_seg AS INT))    AS es_seg,
        MAX(CAST(f.es_sbs AS INT))    AS es_sbs,

        -- Datos de contexto
        c.id_segmento,
        c.id_situacion,
        c.id_sexo,
        c.id_rango_ingreso,
        c.id_rango_edad

    FROM FACT_SEGURO_FINAL f
    JOIN DIM_TIEMPO t ON f.id_tiempo = t.id_mes
    JOIN DIM_CLIENTE c ON f.cod_cliente = c.cod_cliente
    JOIN ods_seguro.ods.vw_seguro s 
         ON f.cod_cliente = s.cod_cliente 
        AND f.id_tiempo = s.mes_corte

    GROUP BY 
        f.cod_cliente,
        c.id_segmento, 
        c.id_situacion, 
        c.id_sexo, 
        c.id_rango_ingreso, 
        c.id_rango_edad
)

, con_rank AS (
    SELECT *,
        PERCENT_RANK() OVER (
            ORDER BY total_seguros * 0.6 + prima_promedio * 0.4
        ) AS score_percentil
    FROM base
)

SELECT *,
    CASE
        WHEN score_percentil >= 0.935 THEN 'ALTO'
        WHEN score_percentil BETWEEN 0.55 AND 0.934 THEN 'MEDIO'
        ELSE 'BAJO'
    END AS categoria_cliente
FROM con_rank;

select*from BI_Segmentacion_Clientes_Categorizada

	SELECT TOP 10 * FROM DIM_CLIENTE;


SELECT categoria_cliente, COUNT(*) AS total_clientes
FROM BI_Segmentacion_Clientes_Categorizada
GROUP BY categoria_cliente;




SELECT DISTINCT categoria_cliente FROM BI_Segmentacion_Clientes_Categorizada

CREATE OR ALTER VIEW BI_Resumen_Categorias_Clientes
AS
WITH resumen AS (
    SELECT
      categoria_cliente,
      COUNT(*) AS total_clientes,
      AVG(dias_desde_ultima_compra * 1.0) AS prom_dias_ultima_compra,
      AVG(total_seguros * 1.0) AS prom_total_seguros,
      -- Reemplaza esto:
      -- AVG(prima_promedio) AS prom_prima
      -- Por esto:
      SUM(prima_promedio * total_seguros) / SUM(total_seguros * 1.0) AS prom_prima_real
    FROM BI_Segmentacion_Clientes_Categorizada
    GROUP BY categoria_cliente
)

SELECT 
  r.categoria_cliente,
  r.prom_dias_ultima_compra,
  r.prom_total_seguros,
  r.prom_prima_real AS prom_prima,
  r.total_clientes,
  CAST(100.0 * r.total_clientes / SUM(r.total_clientes) OVER () AS DECIMAL(5,2)) AS porcentaje_clientes
FROM resumen r;

SELECT 
    cod_cliente, 
    MAX(s.fecha_apertura) AS ultima_fecha,
    DATEDIFF(DAY, MAX(s.fecha_apertura), GETDATE()) AS dias_desde_ultima_compra
FROM ods_seguro.ods.vw_seguro s
GROUP BY cod_cliente
ORDER BY dias_desde_ultima_compra DESC;

select*from BI_Resumen_Categorias_Clientes


WITH clientes_unicos AS (
  SELECT 
    cod_cliente,
    MAX(es_vip) AS es_vip,
    categoria_cliente
  FROM BI_Segmentacion_Clientes_Categorizada
  GROUP BY cod_cliente, categoria_cliente
)
select*from [dbo].[CLIENTE_UNICO]
SELECT 
  categoria_cliente,
  ROUND(AVG(CAST(es_vip AS FLOAT)) * 100, 2) AS porcentaje_clientes_vip
FROM clientes_unicos
GROUP BY categoria_cliente
ORDER BY 
  CASE categoria_cliente
    WHEN 'ALTO' THEN 1
    WHEN 'MEDIO' THEN 2
    WHEN 'BAJO' THEN 3
    ELSE 4
  END;

select*from [dbo].[CLIENTE_UNICO]

  SELECT 
    categoria_cliente,
    ROUND(AVG(total_seguros), 2) AS prom_tipo_seguros,       -- diversidad
    ROUND(AVG(total_politicas), 2) AS prom_total_politicas   -- intensidad
FROM (
    SELECT 
        f.cod_cliente,
        COUNT(DISTINCT f.id_tipo_seguro) AS total_seguros,
        COUNT(*) AS total_politicas,
        cat.categoria_cliente
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada cat
      ON f.cod_cliente = cat.cod_cliente
    GROUP BY f.cod_cliente, cat.categoria_cliente
) AS sub
GROUP BY categoria_cliente;


SELECT cod_cliente, id_tipo_seguro, COUNT(*) AS n_politicas
FROM FACT_SEGURO_FINAL
WHERE cod_cliente = 'cliente_vip_ejemplo'
GROUP BY cod_cliente, id_tipo_seguro;


SELECT id_tipo_seguro, COUNT(*) AS total, COUNT(DISTINCT id_producto_financiero) AS tipos_dentro
FROM FACT_SEGURO_FINAL
GROUP BY id_tipo_seguro;


SELECT categoria_cliente, COUNT(*) AS total_clientes, 
       SUM(CASE WHEN total_seguros = 1 THEN 1 ELSE 0 END) AS con_un_solo_seguro
FROM (
    SELECT f.cod_cliente, COUNT(*) AS total_seguros, cat.categoria_cliente
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada cat ON f.cod_cliente = cat.cod_cliente
    GROUP BY f.cod_cliente, cat.categoria_cliente

) AS base
GROUP BY categoria_cliente;


SELECT 
    categoria_cliente,
    COUNT(*) AS total_clientes,
    ROUND(AVG(total_seguros), 2) AS promedio_seguros_por_cliente
FROM (
    SELECT 
        f.cod_cliente, 
        COUNT(*) AS total_seguros, 
        cat.categoria_cliente
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada cat 
      ON f.cod_cliente = cat.cod_cliente
    GROUP BY f.cod_cliente, cat.categoria_cliente
) AS base
GROUP BY categoria_cliente
ORDER BY 
    CASE 
        WHEN categoria_cliente = 'ALTO' THEN 1
        WHEN categoria_cliente = 'MEDIO' THEN 2
        WHEN categoria_cliente = 'BAJO' THEN 3
        ELSE 4
    END;

SELECT categoria_cliente,
       ROUND(AVG(im_prima), 2) AS promedio_prima
FROM BI_Segmentacion_Clientes_Categorizada cat
JOIN FACT_SEGURO_FINAL f ON cat.cod_cliente = f.cod_cliente
GROUP BY categoria_cliente;


SELECT categoria_cliente,
       total_seguros,
       COUNT(*) AS cantidad_clientes
FROM (
    SELECT cat.categoria_cliente,
           f.cod_cliente,
           COUNT(*) AS total_seguros
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada cat ON cat.cod_cliente = f.cod_cliente
    GROUP BY f.cod_cliente, cat.categoria_cliente
) sub
GROUP BY categoria_cliente, total_seguros
ORDER BY categoria_cliente, total_seguros;


SELECT categoria_cliente,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_seguros) OVER (PARTITION BY categoria_cliente) AS mediana_seguros
FROM (
    SELECT cat.categoria_cliente,
           f.cod_cliente,
           COUNT(*) AS total_seguros
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada cat ON cat.cod_cliente = f.cod_cliente
    GROUP BY f.cod_cliente, cat.categoria_cliente
) sub;

select* from [dbo].[DIM_TIPO_SEGURO]


WITH seguros_por_cliente AS (
    SELECT 
        f.cod_cliente,
        cat.categoria_cliente,
        COUNT(DISTINCT f.id_seguro) AS total_seguros
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada cat 
        ON f.cod_cliente = cat.cod_cliente
    GROUP BY f.cod_cliente, cat.categoria_cliente
)

-- Promedio por categoría
SELECT 
    categoria_cliente,
    COUNT(*) AS total_clientes,
    ROUND(AVG(CAST(total_seguros AS FLOAT)), 2) AS promedio_seguros
FROM seguros_por_cliente
GROUP BY categoria_cliente
ORDER BY 
    CASE categoria_cliente 
        WHEN 'ALTO' THEN 1
        WHEN 'MEDIO' THEN 2
        WHEN 'BAJO' THEN 3
        ELSE 4
    END;



--______________________________________________________________________
/*=============================PROYECCION=============================*/
--=====================================================================

	-- PRIMA

SELECT 
    LOWER(LEFT(t.mes_nombre, 3)) + '''' + RIGHT(CAST(t.anio AS VARCHAR), 2) AS Mes,
    ISNULL(SUM(f.m_prima), 0) AS Ventas
FROM DIM_TIEMPO t
LEFT JOIN FACT_SEGURO_FINAL f ON f.id_tiempo = t.id_tiempo
GROUP BY 
    t.anio,
    t.mes,
    t.mes_nombre
ORDER BY 
    t.anio, t.mes;

SELECT*FROM DIM_CLIENTE

SELECT*FROM[dbo].[FACT_SEGURO_FINAL]

SELECT 
    LOWER(LEFT(t.nombre_mes, 3)) + '''' + RIGHT(CAST(t.anio AS VARCHAR), 2) AS Mes,
    SUM(f.im_prima) AS Ventas
FROM FACT_SEGURO_FINAL f
JOIN DIM_TIEMPO t ON f.id_tiempo = t.id_mes
WHERE t.id_mes != -1  -- excluye "Sin dato"
GROUP BY 
    t.anio,
    t.mes,
    t.nombre_mes
ORDER BY 
    t.anio, t.mes;



SELECT 
    LOWER(LEFT(t.nombre_mes, 3)) + '''' + RIGHT(CAST(t.anio AS VARCHAR), 2) AS Mes,
    ROUND(SUM(f.im_prima), 2) AS Ventas
FROM FACT_SEGURO_FINAL f
JOIN DIM_TIEMPO t ON f.id_tiempo = t.id_mes
WHERE t.id_mes != -1
GROUP BY 
    t.anio,
    t.mes,
    t.nombre_mes
ORDER BY 
    t.anio, t.mes;


	SELECT 
    LOWER(LEFT(t.nombre_mes, 3)) + '''' + RIGHT(CAST(t.anio AS VARCHAR), 2) AS Mes,
    ROUND(AVG(f.im_prima), 2) AS Promedio_Prima
FROM FACT_SEGURO_FINAL f
JOIN DIM_TIEMPO t ON f.id_tiempo = t.id_mes
WHERE t.id_mes != -1
GROUP BY 
    t.anio,
    t.mes,
    t.nombre_mes
ORDER BY 
    t.anio, t.mes;