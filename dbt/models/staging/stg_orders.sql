{{ config(materialized='view') }}

select
    PATH_CATEGORY_NAME as category_name,
    AGE_GROUP as age_group,
    REGION as region,
    YEAR_PATH_STARTED as year_started,
    coalesce(GENDER, 'NR') as gender,
    md5(USER_ID) as user_id

from {{ source('data', 'ORDERS') }}