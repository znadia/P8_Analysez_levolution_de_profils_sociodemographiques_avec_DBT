{{ config(materialized='view') }}

select
    year_started,
    age_group,
    gender,
    region,
    count(*) as nb_etudiants

from {{ ref('stg_orders') }}

group by year_started, age_group, gender, region