SELECT DISTINCT categoria_cliente,
       PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_seguros) OVER (PARTITION BY categoria_cliente) AS p25,
       PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY total_seguros) OVER (PARTITION BY categoria_cliente) AS mediana,
       PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_seguros) OVER (PARTITION BY categoria_cliente) AS p75,
       PERCENTILE_CONT(0.9)  WITHIN GROUP (ORDER BY total_seguros) OVER (PARTITION BY categoria_cliente) AS p90
FROM (
    SELECT cat.categoria_cliente,
           f.cod_cliente,
           COUNT(*) AS total_seguros
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada cat ON cat.cod_cliente = f.cod_cliente
    GROUP BY f.cod_cliente, cat.categoria_cliente
) sub;

--------

WITH base AS (
    SELECT
        f.cod_cliente,
        DATEDIFF(DAY, MAX(s.fecha_apertura), GETDATE()) AS dias_desde_ultima_compra,
        COUNT(DISTINCT f.id_seguro) AS total_seguros,
        AVG(f.im_prima) AS prima_promedio,
        MAX(CAST(f.es_vip AS INT)) AS es_vip,  -- ✅ conversión aquí
        c.categoria_cliente
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada c ON f.cod_cliente = c.cod_cliente
    JOIN ods_seguro.ods.vw_seguro s 
        ON f.cod_cliente = s.cod_cliente AND f.id_tiempo = s.mes_corte
    GROUP BY f.cod_cliente, c.categoria_cliente
),

agregados AS (
    SELECT
        categoria_cliente,
        COUNT(*) AS total_clientes,
        ROUND(AVG(dias_desde_ultima_compra), 2) AS promedio_dias_ultima_compra,
        ROUND(AVG(total_seguros), 2) AS promedio_n_seguros,
        ROUND(AVG(prima_promedio), 2) AS promedio_prima,
        ROUND(AVG(CAST(es_vip AS FLOAT)) * 100, 2) AS porcentaje_clientes_vip
    FROM base
    GROUP BY categoria_cliente
)

SELECT
    categoria_cliente,
    promedio_dias_ultima_compra,
    promedio_n_seguros,
    promedio_prima,
    porcentaje_clientes_vip
FROM agregados
ORDER BY 
    CASE categoria_cliente
        WHEN 'BAJO' THEN 1
        WHEN 'MEDIO' THEN 2
        WHEN 'ALTO' THEN 3
        ELSE 4
    END;
	----PROMEDIO 


	WITH base AS (
    SELECT
        f.cod_cliente,
        c.categoria_cliente,
        DATEDIFF(DAY, MAX(s.fecha_apertura), GETDATE()) AS dias_desde_ultima_compra,
        COUNT(DISTINCT f.id_seguro) AS total_seguros,
        AVG(f.im_prima) AS prima_promedio,
        MAX(CAST(f.es_vip AS INT)) AS es_vip
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada c ON f.cod_cliente = c.cod_cliente
    JOIN ods_seguro.ods.vw_seguro s ON f.cod_cliente = s.cod_cliente AND f.id_tiempo = s.mes_corte
    GROUP BY f.cod_cliente, c.categoria_cliente
)

SELECT 
    categoria_cliente,
    COUNT(*) AS total_clientes,
    ROUND(AVG(dias_desde_ultima_compra), 2) AS promedio_dias_ultima_compra,
    ROUND(AVG(CAST(total_seguros AS FLOAT)), 2) AS promedio_n_seguros,
    ROUND(AVG(prima_promedio), 2) AS promedio_prima,
    ROUND(AVG(CAST(es_vip AS FLOAT)), 4) AS promedio_clientes_vip,         -- ✅ Promedio en decimal (0.4201)
    ROUND(AVG(CAST(es_vip AS FLOAT)) * 100, 2) AS porcentaje_clientes_vip  -- ✅ Porcentaje (42.01%)
FROM base
GROUP BY categoria_cliente
ORDER BY
    CASE categoria_cliente
        WHEN 'ALTO' THEN 1
        WHEN 'MEDIO' THEN 2
        WHEN 'BAJO' THEN 3
        ELSE 4
    END;

-- PARTE 3 
WITH base AS (
    SELECT
        f.cod_cliente,
        c.categoria_cliente,
        MAX(CAST(f.es_vip AS FLOAT)) AS es_vip
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada c 
        ON f.cod_cliente = c.cod_cliente
    GROUP BY f.cod_cliente, c.categoria_cliente
),
agregados AS (
    SELECT 
        categoria_cliente,
        COUNT(*) AS total_clientes,
        SUM(es_vip) AS total_clientes_vip
    FROM base
    GROUP BY categoria_cliente
),
totales AS (
    SELECT 
        SUM(total_clientes) AS total_general,
        SUM(total_clientes_vip) AS total_vip_general
    FROM agregados
)
SELECT 
    a.categoria_cliente,
    a.total_clientes,
    a.total_clientes_vip,
    ROUND((a.total_clientes_vip * 100.0) / t.total_general, 2) AS porcentaje_vip_general
FROM agregados a
CROSS JOIN totales t
ORDER BY 
    CASE 
        WHEN a.categoria_cliente = 'ALTO' THEN 1
        WHEN a.categoria_cliente = 'MEDIO' THEN 2
        WHEN a.categoria_cliente = 'BAJO' THEN 3
        ELSE 4
    END;

--

WITH base AS (
    SELECT
        f.cod_cliente,
        c.categoria_cliente,
        DATEDIFF(DAY, MAX(s.fecha_apertura), GETDATE()) AS dias_desde_ultima_compra,
        COUNT(DISTINCT f.id_seguro) AS total_seguros,
        AVG(f.im_prima) AS prima_promedio,
        MAX(CAST(f.es_vip AS INT)) AS es_vip
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada c ON f.cod_cliente = c.cod_cliente
    JOIN ods_seguro.ods.vw_seguro s 
        ON f.cod_cliente = s.cod_cliente AND f.id_tiempo = s.mes_corte
    GROUP BY f.cod_cliente, c.categoria_cliente
),
resumen AS (
    SELECT
        categoria_cliente,
        COUNT(*) AS total_clientes,
        ROUND(AVG(CAST(dias_desde_ultima_compra AS FLOAT)), 0) AS promedio_dias_ultima_compra,
        ROUND(AVG(CAST(total_seguros AS FLOAT)), 2) AS promedio_n_seguros,
        ROUND(AVG(prima_promedio), 2) AS promedio_prima,
        SUM(CAST(es_vip AS INT)) AS total_vip
    FROM base
    GROUP BY categoria_cliente
)
SELECT 
    categoria_cliente,
    promedio_dias_ultima_compra,
    promedio_n_seguros,
    promedio_prima,
    ROUND(CAST(total_vip AS FLOAT) / NULLIF(total_clientes, 0), 4) AS promedio_clientes_vip,  -- En decimal
    CONCAT(ROUND(CAST(total_vip AS FLOAT) * 100.0 / NULLIF(total_clientes, 0), 2), '%') AS porcentaje_clientes_vip
FROM resumen
ORDER BY 
    CASE 
        WHEN categoria_cliente = 'BAJO' THEN 1
        WHEN categoria_cliente = 'MEDIO' THEN 2
        WHEN categoria_cliente = 'ALTO' THEN 3
        ELSE 4
    END;


---------------------ASDFASDFASASFASF

;WITH base AS (
    SELECT
        f.cod_cliente,
        c.categoria_cliente,
        DATEDIFF(DAY, MAX(s.fecha_apertura), GETDATE()) AS dias_desde_ultima_compra,
        COUNT(DISTINCT f.id_seguro) AS total_seguros,
        AVG(f.im_prima) AS prima_promedio,
        MAX(CAST(f.es_vip AS INT)) AS es_vip
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada c 
        ON f.cod_cliente = c.cod_cliente
    JOIN ods_seguro.ods.vw_seguro s 
        ON f.cod_cliente = s.cod_cliente AND f.id_tiempo = s.mes_corte
    GROUP BY f.cod_cliente, c.categoria_cliente
),
resumen AS (
    SELECT
        categoria_cliente,
        COUNT(*) AS total_clientes,
        ROUND(AVG(CAST(dias_desde_ultima_compra AS FLOAT)), 0) AS promedio_dias_ultima_compra,
        ROUND(AVG(CAST(total_seguros AS FLOAT)), 2) AS promedio_n_seguros,
        ROUND(AVG(prima_promedio), 2) AS promedio_prima,
        SUM(CAST(es_vip AS INT)) AS total_vip
    FROM base
    GROUP BY categoria_cliente
),
base_vip AS (
    SELECT
        f.cod_cliente,
        c.categoria_cliente,
        MAX(CAST(f.es_vip AS FLOAT)) AS es_vip
    FROM FACT_SEGURO_FINAL f
    JOIN BI_Segmentacion_Clientes_Categorizada c 
        ON f.cod_cliente = c.cod_cliente
    GROUP BY f.cod_cliente, c.categoria_cliente
),
agregados AS (
    SELECT 
        categoria_cliente,
        COUNT(*) AS total_clientes,
        SUM(es_vip) AS total_clientes_vip
    FROM base_vip
    GROUP BY categoria_cliente
),
totales AS (
    SELECT 
        SUM(total_clientes) AS total_general,
        SUM(total_clientes_vip) AS total_vip_general
    FROM agregados
),
porcentaje_general AS (
    SELECT 
        a.categoria_cliente,
        ROUND((a.total_clientes_vip * 100.0) / NULLIF(t.total_general, 0), 2) AS porcentaje_vip_general
    FROM agregados a
    CROSS JOIN totales t
)

-- Consulta final
SELECT 
    r.categoria_cliente,
    r.promedio_dias_ultima_compra,
    r.promedio_n_seguros,
    r.promedio_prima,
    ROUND(CAST(r.total_vip AS FLOAT) / NULLIF(r.total_clientes, 0), 4) AS promedio_clientes_vip,
    CONCAT(pg.porcentaje_vip_general, '%') AS porcentaje_vip_general
FROM resumen r
JOIN porcentaje_general pg 
    ON r.categoria_cliente = pg.categoria_cliente
ORDER BY 
    CASE 
        WHEN r.categoria_cliente = 'BAJO' THEN 1
        WHEN r.categoria_cliente = 'MEDIO' THEN 2
        WHEN r.categoria_cliente = 'ALTO' THEN 3
        ELSE 4
    END;


