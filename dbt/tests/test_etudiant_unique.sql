select
    user_id,
    year_started,
    count(*) as nb_lignes
from {{ ref('stg_orders') }}

group by user_id, year_started
having count(*) > 1