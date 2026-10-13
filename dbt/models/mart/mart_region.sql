{{ config(materialized='table') }}

select
    year_started,
    region,
    sum(nb_etudiants) as nb_etudiants

from {{ ref('int_orders') }}

group by year_started, region