{{ config(materialized='table') }}

with ocr as (
    select
        year_started as years,
        gender,
        region,
        age_group,
        sum(nb_etudiants) as nb_etudiants_ocr
    from {{ ref('int_orders') }}
    where gender in ('M', 'F')
    group by year_started, gender, region, age_group
),

insee as (
    select
        years,
        gender,
        region,
        age_group,
        population
    from {{ ref('int_insee') }}
)

select
    coalesce(ocr.years, insee.years)            as years,
    coalesce(ocr.gender, insee.gender)          as gender,
    coalesce(ocr.region, insee.region)          as region,
    coalesce(ocr.age_group, insee.age_group)    as age_group,
    coalesce(ocr.nb_etudiants_ocr, 0)           as nb_etudiants_ocr,
    coalesce(insee.population, 0)               as population_insee

from ocr
full outer join insee
    on  ocr.years     = insee.years
    and ocr.gender    = insee.gender
    and ocr.region    = insee.region
    and ocr.age_group = insee.age_group
    
order by years, region, gender, age_group