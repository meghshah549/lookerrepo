view: orders {
  sql_table_name: `sample_superstore.orders`    ;;


  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Order_ID ;;
  }

  #test 5


  # dimension: category {
  #   type: string
  #   sql: ${TABLE}.Category ;;
  #   skip_drill_filter: yes
  #   link: {
  #     url: "http://www.google.com"

  #   }
  # }

  # dimension: category {
  #   type: string
  #   sql: ${TABLE}.Category ;;
  #   skip_drill_filter: yes
  #   link: {
  #     url: "http://www.google.com/search?q={{ value | url_encode  }}"
  #   }
  # }

  # dimension: category {
  #   link: {
  #     label: "Google"
  #     url: "http://www.google.com/search?q={{ value }}"
  #     icon_url: "http://google.com/favicon.ico"
  #   }
  # }

  # dimension: category {
  #   type: string
  #   sql: ${TABLE}.category ;;
  #   #skip_drill_filter: yes
  #   link: {
  #     url:"http://www.google.com/search?q={{ value }}"
  #   }
  # }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
#skip_drill_filter: yes
    link: {
      label:"Google"
      url:"http://www.google.com/search?q={{ value }}"
    }
  }

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
    group_label: "Demographic Info"
    link: {
      label: "Orders Explore"
      url: "https://mediaagility.looker.com/dashboards/263"
    }

  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
    group_label: "Demographic Info"
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.Customer_ID ;;
    link: {
      url: "https://mediaagility.looker.com/dashboards/263"
    }
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.Customer_Name ;;
  }

  measure: discount {
    type: sum
    sql: ${TABLE}.Discount ;;
  }


  dimension_group: order {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      time
    ]
    #convert_tz: no
   #datatype: timestamp
    sql: ${TABLE}.Order_Date;;
    datatype: datetime
  }

  filter: timeframe_a {
    type: date_time
  }

  dimension: group_a_yesno {
    type: yesno
    sql: {% condition timeframe_a %} ${order_raw} {%  endcondition %} ;;
  }

  measure: count_a {
    type: count
    filters: [group_a_yesno: "yes"]
  }

  filter: timeframe_b {
    type: date_time
  }

  dimension: group_b_yesno {
    type: yesno
    sql: {% condition timeframe_b %} ${order_raw} {%  endcondition %} ;;
  }

  measure: count_b {
    type: count
    filters: [group_b_yesno: "yes"]
  }

  dimension: is_in_time_a_or_b {
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
      {% condition timeframe_a %} ${order_raw} {% endcondition %} OR
      {% condition timeframe_b %} ${order_raw} {% endcondition %} ;;
  }


  dimension: postal_code {
    type: number
    sql: ${TABLE}.Postal_Code ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.Product_ID ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.Product_Name ;;
  }

  measure: profit {
    type: sum
    sql: ${TABLE}.Profit ;;
  }


  measure: total_profit {
    type: sum
    sql:${TABLE}.Profit ;;
  }

  measure: average_profit {
    type: average
    sql: ${TABLE}.Profit ;;
  }

  measure: quantity {
    type: sum
    sql: ${TABLE}.Quantity ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: row_id {
    type: number
    sql: ${TABLE}.Row_ID ;;
  }

  measure: sales {
    type: sum
    sql: ${TABLE}.Sales ;;
    value_format_name: usd_0
  }

  measure: user_count {
    type: count_distinct
    sql: ${customer_name} ;;
  }

measure: avg_rev_per_user {
  type: number
  sql: ${sales}/${count} ;;
}

  dimension: segment {
    type: string
    sql: ${TABLE}.Segment ;;
  }

  dimension_group: ship {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: datetime
    sql: ${TABLE}.Ship_Date ;;
  }

  dimension_group: month_year_duration {
    type: duration
    intervals: [month,year,day]
    sql_start: ${order_raw} ;;
    sql_end: ${ship_raw} ;;
    convert_tz: no
   }

  dimension: ship_mode {
    type: string
    sql: ${TABLE}.Ship_Mode ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.Sub_Category ;;
  }

  dimension: ship_order_diff {
    type: number
    sql: date_diff(${ship_date},${order_date},day) ;;
    hidden: yes
  }

  measure: avg_time_to_deliver {
    type: average
    sql: ${ship_order_diff} ;;
    value_format: "0 \" days\""
  }

  measure: avg_discount {
    type: average
    sql: ${TABLE}.Discount ;;
    value_format: "0.00%"
  }

  measure: avg_order_quantity {
    type: average
    sql: ${TABLE}.Quantity ;;
    value_format_name: id
  }


  measure: count {
    type: count
    drill_fields: [customer_name]
    #sql: ${customer_name};;
    value_format_name: id
  }

  #Practicing various scenarios  logic

  measure: avg_revenue_per_user1 {
    type: number
    sql: ${sales} / ${user_count};;
  }

  measure: avg_revenue_per_user3 {
    type: number
    sql: ${sales} / ${TABLE}.Customer_ID;;
  }

  # measure: order_count {
  #   type: count
  #   sql: ${order_id} ;;
  # }

  dimension: sales_dim {
    type: number
    sql: ${TABLE}.Sales ;;
    value_format_name: usd_0
  }

  dimension: sales_dim_measure {
    type: number
    sql:${sales_dim} * 0.8;;
  }

  ######Trying Period over Period
  dimension: current_vs_previous_period_bigquery {
    description: "Use this dimension along with \"Select Timeframe\" Filter"
    type: string
    sql:
    CASE
      WHEN DATE_TRUNC(${order_date},  {% parameter parameters.select_timeframe %}) = DATE_TRUNC({% if parameters.select_reference_date._is_filtered %}{% parameter parameters.select_reference_date %} {% else %} ${parameters.current_timestamp_raw}{% endif %}, {% parameter parameters.select_timeframe %})
        THEN '{% if parameters.select_reference_date._is_filtered %}Reference {% else %}Current {% endif %} {% parameter parameters.select_timeframe %}'
      WHEN DATE_TRUNC(${order_date},  {% parameter parameters.select_timeframe %}) = DATE_TRUNC(DATE_SUB({% if parameters.select_reference_date._is_filtered %}{% parameter parameters.select_reference_date %} {% else %} ${parameters.current_timestamp_raw}{% endif %}, INTERVAL 1 {% parameter parameters.select_timeframe %}), {% parameter parameters.select_timeframe %})
        THEN "Previous {% parameter parameters.select_timeframe %}"
      ELSE NULL
    END
    ;;
  }

  filter: current_date_range {
    type: date
    view_label: "_PoP"
    label: "1. Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Event Date covers this period, or is removed."
    sql: ${order_date} IS NOT NULL ;;
  }

  parameter: compare_to {
    view_label: "_PoP"
    description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
    label: "2. Compare To:"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
  }

  dimension: days_in_period {
    hidden:  yes
    view_label: "_PoP"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: DATEDIFF(DAY, DATE({% date_start current_date_range %}), DATE({% date_end current_date_range %})) ;;
  }

  dimension: period_2_start {
    hidden:  yes
    view_label: "_PoP"
    description: "Calculates the start of the previous period"
    type: date
    sql:
        {% if compare_to._parameter_value == "Period" %}
        DATE_ADD(DAY, -${days_in_period}, DATE({% date_start current_date_range %}))
        {% else %}
        DATE_ADD({% parameter compare_to %}, -1, DATE({% date_start current_date_range %}))
        {% endif %};;
  }

  dimension: period_2_end {
    hidden:  yes
    view_label: "_PoP"
    description: "Calculates the end of the previous period"
    type: date
    sql:
        {% if compare_to._parameter_value == "Period" %}
        DATE_ADD(DAY, -1, DATE({% date_start current_date_range %}))
        {% else %}
        DATE_ADD({% parameter compare_to %}, -1, DATEADD(DAY, -1, DATE({% date_end current_date_range %})))
        {% endif %};;
  }

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
    {% if current_date_range._is_filtered %}
        CASE
        WHEN {% condition current_date_range %} ${order_raw} {% endcondition %}
        THEN DATEDIFF(DAY, DATE({% date_start current_date_range %}), ${order_date}) + 1
        WHEN ${order_date} between ${period_2_start} and ${period_2_end}
        THEN DATEDIFF(DAY, ${period_2_start}, ${order_date}) + 1
        END
    {% else %} NULL
    {% endif %}
    ;;
  }

  dimension: order_for_period {
    hidden: yes
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${order_raw} {% endcondition %}
            THEN 1
            WHEN ${order_date} between ${period_2_start} and ${period_2_end}
            THEN 2
            END
        {% else %}
            NULL
        {% endif %}
        ;;
  }


  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: DATE_ADD(DAY, ${day_in_period} - 1, DATE({% date_start current_date_range %})) ;;
    view_label: "_PoP"
    timeframes: [
      date,
      hour_of_day,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week_of_year,
      month,
      month_name,
      month_num,
      year]
  }


  dimension: period {
    view_label: "_PoP"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    order_by_field: order_for_period
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${order_raw} {% endcondition %}
            THEN 'This {% parameter compare_to %}'
            WHEN ${order_date} between ${period_2_start} and ${period_2_end}
            THEN 'Last {% parameter compare_to %}'
            END
        {% else %}
            NULL
        {% endif %}
        ;;
  }

  dimension: period_filtered_measures {
    hidden: yes
    description: "We just use this for the filtered measures"
    type: string
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${order_raw} {% endcondition %} THEN 'this'
            WHEN ${order_date} between ${period_2_start} and ${period_2_end} THEN 'last' END
        {% else %} NULL {% endif %} ;;
  }

  measure: current_period_sales {
    view_label: "_PoP"
    type: sum
    sql:${TABLE}.Sales ;;
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_sales {
    view_label: "_PoP"
    type: sum
    sql: ${TABLE}.Sales ;;
    filters: [period_filtered_measures: "last"]
  }

  measure: sales_pop_change {
    view_label: "_PoP"
    label: "Total Sales period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_sales} = 0
            THEN NULL
            ELSE (1.0 * ${current_period_sales} / NULLIF(${previous_period_sales} ,0)) - 1 END ;;
    value_format_name: percent_2
  }



  #################################

  ### TRY POP 2 ############

  dimension: yyyyqq {
    type: string
    sql: concat(CAST(EXTRACT(year from ${order_date}) as string),'Q',CAST(EXTRACT(quarter from ${order_date}) as string)) ;;
   }

  parameter: yyyyqq_param {
    type: string
    suggest_dimension: yyyyqq
  }

  dimension: condition_param {
    type: yesno
    sql: {% parameter yyyyqq_param %}= concat(CAST(EXTRACT(year from ${order_date}) as string),'Q',CAST(EXTRACT(quarter from ${order_date}) as string))
      OR

     {% parameter yyyyqq_param %}= concat(CAST(EXTRACT(year from DATE_ADD(${order_date}, interval 1 quarter)) as string),'Q',CAST(EXTRACT(quarter from DATE_ADD(${order_date}, interval 1 quarter)) as string));;
  }

  filter: previous_filter {
    type: yesno
    sql: {% parameter yyyyqq_param %}= concat(CAST(EXTRACT(year from DATE_ADD(${order_date}, interval 1 quarter)) as string),'Q',CAST(EXTRACT(quarter from DATE_ADD(${order_date}, interval 1 quarter)) as string)) ;;
  }

  filter: current_filter {
    type: yesno
    sql: {% parameter yyyyqq_param %}= concat(CAST(EXTRACT(year from ${order_date}) as string),'Q',CAST(EXTRACT(quarter from ${order_date}) as string)) ;;
  }

  measure: current_sales {
    type: sum
    sql:${TABLE}.Sales ;;
    filters: [current_filter: "yes"]
    value_format_name: usd_0
  }

  measure: previous_sales {
    type: sum
    sql: ${TABLE}.Sales ;;
    filters: [previous_filter: "yes"]
    value_format_name: usd_0

  }


  ##########################


  ######## Measure Type Test ########

  measure: order_count {
    type: count
    drill_fields: [order_id]
    #sql: ${customer_name};;
    value_format_name: id
    link: {
      url: "https://mediaagility.looker.com/explore/demo_ecom_ms/events"
    }
  }

  measure: net_sales {
    type: sum
    sql: ${TABLE}.Sales ;;
    value_format_name: usd_0
  }

   measure: measure_value {
    type:number
    sql: CASE WHEN ${order_measure_type_view.measure_category}="Count" then ${order_count}
    else ROUND(${net_sales},2) end;;
  }


  #Parameters
  parameter: item_to_add_up {
    type: unquoted
    allowed_value: {
      label: "Net Sales"
      value: "sales"
    }
    allowed_value: {
      label: "Discount"
      value: "discount"
    }
    allowed_value: {
      label: "Total Profit"
      value: "profit"
    }
  }

  measure: dynamic_measure {
    type: sum
    sql: ${TABLE}.{% parameter item_to_add_up %} ;;
    value_format_name: "usd"
  }


dimension: row_tier {
  type: tier
  tiers: [0,1000,2000,3000,4000,5000,6000]
  sql: ${row_id}
;;
style: integer
}


measure: runnning_total_test {
  type: running_total
  sql: ${net_sales} ;;
}





































}
