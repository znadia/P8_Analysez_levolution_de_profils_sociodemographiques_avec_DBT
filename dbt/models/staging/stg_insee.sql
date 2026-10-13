{{ config(materialized='view') }}

with INSEE_POPULATION as (

    select *, 2022 as years
    from {{ source('insee', 'INSEE_POP_2022') }}
    where "Regions" not in (
        'France métropolitaine', 
        'France métropolitaine et DOM',
        'Guadeloupe', 'Martinique', 'Guyane', 'La Réunion', 'Mayotte'
    )

    union all

    select *, 2023 as years
    from {{ source('insee', 'INSEE_POP_2023') }}
    where "Regions" not in (
        'France métropolitaine', 
        'France métropolitaine et DOM',
        'Guadeloupe', 'Martinique', 'Guyane', 'La Réunion', 'Mayotte'
    )

    union all

    select *, 2024 as years
    from {{ source('insee', 'INSEE_POP_2024') }}
    where "Regions" not in (
        'France métropolitaine', 
        'France métropolitaine et DOM',
        'Guadeloupe', 'Martinique', 'Guyane', 'La Réunion', 'Mayotte'
    )

    union all

    select *, 2025 as years
    from {{ source('insee', 'INSEE_POP_2025') }}
    where "Regions" not in (
        'France métropolitaine', 
        'France métropolitaine et DOM',
        'Guadeloupe', 'Martinique', 'Guyane', 'La Réunion', 'Mayotte'
    )
),

clean as (
    select
        -- Harmonisation des noms de régions entre INSEE et OCR
        case
            when "Regions" = 'DOM' then 'DROM'
            when "Regions" = 'Centre-Val-de-Loire' then 'Centre-Val de Loire'
            else "Regions"
        end as region,

        GENRE as gender,
        years,

        -- Nettoyage: suppression des espaces + cast en INTEGER pour éviter les problèmes de types dans UNPIVOT
        CAST(REPLACE("20 à 24 ans", ' ', '') AS INTEGER) as age_20_24,
        CAST(REPLACE("25 à 29 ans", ' ', '') AS INTEGER) as age_25_29,
        CAST(REPLACE("30 à 34 ans", ' ', '') AS INTEGER) as age_30_34,
        CAST(REPLACE("35 à 39 ans", ' ', '') AS INTEGER) as age_35_39,
        CAST(REPLACE("40 à 44 ans", ' ', '') AS INTEGER) as age_40_44,
        CAST(REPLACE("45 à 49 ans", ' ', '') AS INTEGER) as age_45_49,
        CAST(REPLACE("50 à 54 ans", ' ', '') AS INTEGER) as age_50_54,
        CAST(REPLACE("55 à 59 ans", ' ', '') AS INTEGER) as age_55_59,

        (
            CAST(REPLACE("60 à 64 ans", ' ', '') AS INTEGER)
            + CAST(REPLACE("65 à 69 ans", ' ', '') AS INTEGER)
            + CAST(REPLACE("70 à 74 ans", ' ', '') AS INTEGER)
            + CAST(REPLACE("75 à 79 ans", ' ', '') AS INTEGER)
            + CAST(REPLACE("80 à 84 ans", ' ', '') AS INTEGER)
            + CAST(REPLACE("85 à 89 ans", ' ', '') AS INTEGER)
            + CAST(REPLACE("90 à 94 ans", ' ', '') AS INTEGER)
            + CAST(REPLACE("95 ans et plus", ' ', '') AS INTEGER)
        ) as age_60_plus

    from INSEE_POPULATION
)

select
    region,
    gender,
    years,
    age_group,
    population

from clean

unpivot(population for age_group in (
    age_20_24,
    age_25_29,
    age_30_34,
    age_35_39,
    age_40_44,
    age_45_49,
    age_50_54,
    age_55_59,
    age_60_plus
))