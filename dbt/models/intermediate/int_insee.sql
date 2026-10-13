{{ config(materialized='view') }}

select
    years,
    case age_group
        when 'AGE_20_24'   then '20-24 ans'
        when 'AGE_25_29'   then '25-29 ans'
        when 'AGE_30_34'   then '30-34 ans'
        when 'AGE_35_39'   then '35-39 ans'
        when 'AGE_40_44'   then '40-44 ans'
        when 'AGE_45_49'   then '45-49 ans'
        when 'AGE_50_54'   then '50-54 ans'
        when 'AGE_55_59'   then '55-59 ans'
        when 'AGE_60_PLUS' then '60 ans ou plus'
    end as age_group,
    gender,
    region,
    population

from {{ ref('stg_insee') }}