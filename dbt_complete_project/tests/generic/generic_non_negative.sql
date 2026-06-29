{% test generic_non_negative(model, column_name) %}
SELECT
    *
FROM
    {{model}}
Where
    {{column_name}} < 0
{% endtest %}