{% macro anomaly_detection_description() %}
    case
        when metric_name = 'freshness' then {{ elementary.freshness_description() }}
        when column_name is null then {{ elementary.table_metric_description() }}
        when column_name is not null then {{ elementary.column_metric_description() }}
        else null
    end as alert_description
{% endmacro %}

{% macro freshness_description() %}
    'The table ' || full_table_name || ' last update was at ' || source_value || ', ' || abs(round(latest_metric_value/60,2)) || ' hours ago. The average for this metric is ' || abs(round(training_avg/60,2)) || ' hours.'
{% endmacro %}

{% macro table_metric_description() %}
    'The table ' || full_table_name || ' last ' || metric_name || ' value is ' || round(latest_metric_value,3) ||
    '. The average for this metric is ' || round(training_avg,3) || '.'
{% endmacro %}

{% macro column_metric_description() %}
    'The column ' || column_name || ' in table ' || full_table_name || ' last ' || metric_name || ' value is ' || round(latest_metric_value,3) ||
    '. The average for this metric is ' || round(training_avg,3) || '.'
{% endmacro %}