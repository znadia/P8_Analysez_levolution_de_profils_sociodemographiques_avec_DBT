{{ config(materialized='table') }}

select
    year_started,
    age_group,
    sum(nb_etudiants) as nb_etudiants

from {{ ref('int_orders') }}

group by year_started, age_group