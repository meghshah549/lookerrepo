view: orders {
  sql_table_name: `sample_superstore.orders`    ;;


  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Order_ID ;;
  }
measure: test{
  type:  count_distinct
  sql: ${TABLE}.order_id ;;
  filters: [state: "ca"]
}
  #test 9
  #advance deployment enabled
  # testing
  #abc
  #new test


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

  dimension: category_1 {
    type: string
    sql: ${TABLE}.category ;;
    html:  <a href="https://www.google.com/">{{ value }}</a> ;;
  }

  dimension: category_2{
    type: string
    sql: ${TABLE}.category ;;
    html:  <a href="https://www.google.com/search?q={{value}}">{{ value }}</a> ;;
  }

  dimension: category_3 {
    type: string
    sql: ${TABLE}.category ;;
    link: {
      label: "Google Search"
      url: "https://www.google.com/"
      icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
    }
  }

  dimension: category_4{
    type: string
    sql: ${TABLE}.category ;;
    link: {
      label: "Google Search"
      url: "https://www.google.com/search?q={{value}}"
      icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
    }
  }

  dimension: category_5 {
    type: string
    sql: ${TABLE}.category ;;
    html:  <a href="/dashboards/263?Category={{ value | url_encode }}">{{ value }}</a> ;;
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
    #type: location
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
    action:{
      label: "Form"
      url: "https://{{api_url}}/insert?name=fdm_manual_adjustment"
     # form_url: "https://{{api_url}}/form?name=fdm_manual_adjustment&id={{id}}"
     # url: "https://test/insert?name=fdm_manual_adjustment"
      form_param: {
        name: "name"
        type: string
        label: "Name"
        required: yes
      }
      form_param: {
        name: "email"
        type: string
        label: "Email"
        required: yes
      }
      form_param: {
        name: "age"
        type: string
        label: "Age"
        required: yes
      }

      form_param: {
        name: "gender"
        type: select
        label: "Gender"
        option: {
          name: "male"
          label: "Male"
        }
        option: {
          name: "female"
          label: "Female"
        }
      }
      form_param: {
        name: "country"
        type: select
        label: "Country"
        option: {
          name: "usa"
          label: "USA"
        }
        option: {
          name: "uk"
          label: "UK"
        }
      }
     }
  }


  dimension: category_10 {
    type: string
    sql: ${TABLE}.category ;;
    html:  <a href="https://www.google.com/search?q={{value}}">{{ value }}</a> ;;
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

  # dimension: ship_mode {
  #   type: string
  #   sql: ${TABLE}.Ship_Mode ;;
  # }

  dimension: state {
    #type: location
    sql: ${TABLE}.State ;;
    map_layer_name: us_states

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

  ###multiple drill on single measure

  measure: count_with_drills {

    type: count

    link: {

      label: "state"

      url: "{{ count_set_1._link }}"

    }

    link: {

      label: "category"

      url: "{{ count_set_2._link }}"

    }

  }

  measure: count_set_1 {

    type: count

    drill_fields: [state, sub_category]

    hidden: yes

  }

  measure: count_set_2 {

    type: count

    drill_fields: [category, region]

    hidden: yes

  }



  ####################


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

  # dimension: action {
  #   type: string
  #   sql: "Add Records";;
  #   # html: <a><button>Add Records</button></a>;;
  #   action: {
  #     label: "Insert Record"
  #     url: "https://test/insert?name=fdm_manual_adjustment"
  #     #form_url: "https://test/form?name=fdm_manual_adjustment&id"
  #     # param: {
  #     #   name:"id"
  #     #   value: "{{id}}"
  #     # }
  #     form_param: {
  #       name: "report_name"
  #       type: string
  #       label: "Report Name"
  #       # option: {
  #       #   name: "name string"
  #       #   label: "possibly-localized-string"
  #       # }
  #       required: yes
  #       #description: "possibly-localized-string"
  #       # default: "string"
  #     }
  #     form_param: {
  #       name: "description"
  #       type: string
  #       label: "Description"
  #       # option: {
  #       #   name: "name string"
  #       #   label: "possibly-localized-string"
  #       # }
  #       #required: yes
  #       #description: "possibly-localized-string"
  #       # default: "string"
  #     }
  #     form_param: {
  #       name: "subscription_schedule"
  #       type: select
  #       label: "Subscription Schedule"
  #       option: {
  #         name: "daily"
  #         label: "Daily"
  #       }
  #       option: {
  #         name: "weekly"
  #         label: "Weekly"
  #       }
  #       option: {
  #         name: "monthly"
  #         label: "Monthly"
  #       }
  #       required: yes
  #       #description: "possibly-localized-string"
  #       # default: "string"
  #     }

  #   }
  # }

  dimension: id {
    #primary_key: yes
    type: string
    sql: CAST(UNIX_SECONDS(current_timestamp) AS STRING);;

  }

  # dimension: id_update {
  #   primary_key: yes
  #   type: string
  #   sql:${TABLE}.id  ;;
  # }

  dimension: api_url {
    type: string
    sql:"looker-writeback-74uylbxxfq-ue.a.run.app";;
  }



  dimension: action {
    type: string
    sql: "Add Records";;
    # html: <a><button>Add Records</button></a>;;
    action: {
      label: "Create Subscription"
      url: "https://{{api_url}}/insert?name=fdm_manual_adjustment"
     # form_url: "https://{{api_url}}/form?name=fdm_manual_adjustment&id={{id}}"
     # url: "https://test/insert?name=fdm_manual_adjustment"
      form_param: {
        name: "report_name"
        type: select
        label: "Report Name"
        option: {
          name: "dsr"
          label: "DSR"
        }
        option: {
          name: "bin_management"
          label: "Bin Management"
        }
        option: {
          name: "tablet"
          label: "Tablet"
        }
        required: yes
      }
      form_param: {
        name: "regional_manager"
        type: select
        label: "Regional Manager"
        option: {
          name: "abc"
          label: "ABC"
        }
        option: {
          name: "xyz"
          label: "XYZ"
        }
      }
      form_param: {
        name: "district_manager"
        type: select
        label: "District Manager"
        option: {
          name: "pqr"
          label: "PQR"
        }
        option: {
          name: "mnp"
          label: "MNP"
        }
      }
      form_param: {
        name: "subscription_schedule"
        type: select
        label: "Subscription Schedule"
        option: {
          name: "daily"
          label: "Daily"
        }
        option: {
          name: "weekly"
          label: "Weekly"
        }
        option: {
          name: "monthly"
          label: "Monthly"
        }
        required: yes
      }
      form_param: {
        name: "email"
        type: string
        label: "Email Id"
        required: yes
      }

   }
  }




  dimension: action_2 {
    type: string
    sql: "Add Records";;
    # html: <a><button>Add Records</button></a>;;
    action: {
      label: "Create Subscription"
      #url: "https://{{api_url}}/insert?name=fdm_manual_adjustment"
      # form_url: "https://{{api_url}}/form?name=fdm_manual_adjustment&id={{id}}"
      url: "https://test/insert?name=fdm_manual_adjustment"
      form_param: {
        name: "report_name"
        type: select
        label: "Report Name"
        option: {
          name: "dsr"
          label: "DSR"
        }
        option: {
          name: "bin_management"
          label: "Bin Management"
        }
        option: {
          name: "tablet"
          label: "Tablet"
        }
        required: yes
      }
      form_param: {
        name: "filter_select"
        type: select
        label: "Select Filter"
        option: {
          name: "store_name"
          label: "Store Name"
        }
        option: {
          name: "regional_manager"
          label: "Regional Manager"
        }
        option: {
          name: "district_manager"
          label: "District Manager"
        }
      }
      form_param: {
        name: "filter_value"
        type: select
        label: "Filter Value"
        option: {
          name: "athens"
          label: "ATHENS_00157"
        }
        option: {
          name: "smyrna_13101"
          label: "SMYRNA_13101"
        }
      }
      form_param: {
        name: "subscription_schedule"
        type: select
        label: "Subscription Schedule"
        option: {
          name: "daily"
          label: "Daily"
        }
        option: {
          name: "weekly"
          label: "Weekly"
        }
        option: {
          name: "monthly"
          label: "Monthly"
        }
        required: yes
      }
      form_param: {
        name: "start_date"
        type: select
        label: "Start Date"
        option: {
          name: "1"
          label: "1"
        }
        option: {
          name: "2"
          label: "2"
        }
        option: {
          name: "3"
          label: "3"
        }
        required: yes
      }
      form_param: {
        name: "start_month"
        type: select
        label: "Start Month"
        option: {
          name: "jan"
          label: "JAN"
        }
        option: {
          name: "feb"
          label: "FEB"
        }
        option: {
          name: "mar"
          label: "MAR"
        }
        required: yes
      }
      form_param: {
        name: "start_year"
        type: select
        label: "Start Year"
        option: {
          name: "2020"
          label: "2020"
        }
        option: {
          name: "2021"
          label: "2021"
        }
        option: {
          name: "2022"
          label: "2022"
        }
        required: yes
      }

      form_param: {
        name: "end_date"
        type: select
        label: "End Date"
        option: {
          name: "1"
          label: "1"
        }
        option: {
          name: "2"
          label: "2"
        }
        option: {
          name: "3"
          label: "3"
        }
        required: yes
      }
      form_param: {
        name: "end_month"
        type: select
        label: "End Month"
        option: {
          name: "jan"
          label: "JAN"
        }
        option: {
          name: "feb"
          label: "FEB"
        }
        option: {
          name: "mar"
          label: "MAR"
        }
        required: yes
      }
      form_param: {
        name: "end_year"
        type: select
        label: "End Year"
        option: {
          name: "2020"
          label: "2020"
        }
        option: {
          name: "2021"
          label: "2021"
        }
        option: {
          name: "2022"
          label: "2022"
        }
        required: yes
      }

      form_param: {
        name: "email"
        type: string
        label: "Email Id"
        required: yes
      }

      form_param: {
        name: "report_type"
        type: select
        label: "Report Type"
        option: {
          name: "csv"
          label: "CSV"
        }
        option: {
          name: "pdf"
          label: "PDF"
        }
        required: yes
      }

    }
  }

  parameter: select_timeframe {
    type: unquoted
    default_value: "order_month"
    allowed_value: {
      value: "order_date"
      label: "Date"
    }
    allowed_value: {
      value: "order_week"
      label: "Week"
    }
    allowed_value: {
      value: "order_month"
      label: "Month"
    } }

  dimension: dynamic_timeframe {
    label_from_parameter: select_timeframe
    type: string
    sql:
     {% if select_timeframe._parameter_value == 'order_date' %}
     ${order_date}
     {% elsif select_timeframe._parameter_value == 'order_week' %}
     ${order_week}
     {% else %}
     ${order_month}
     {% endif %} ;;

}


parameter: order_dt_param {
  type: date
}

dimension: is_fill {
  type: yesno
  sql: ${order_date}={% parameter order_dt_param %} ;;
}

  dimension: is_prev_fill {
    type: yesno
    sql: ${order_date}={% parameter order_dt_param %} ;;
  }

measure:sales_curr  {
  type: sum
  sql: ${TABLE}.Sales ;;
  filters: [is_fill: "yes"]
}

  measure:sales_prev  {
    type: sum
    sql: ${TABLE}.Sales ;;
    filters: [is_prev_fill: "yes"]
  }

  measure:sales_ly  {
    type: sum
    sql: ${TABLE}.Sales ;;
  }

  measure: custom_net_sales {
    type: sum
    sql: ${TABLE}.Sales ;;
    html:
    {% if orders.region._value == 'West' and value < 230000 %}
    <p style="color: green; font-size:100% ; font-weight:bold ; background-color: black ">{{ rendered_value }}</p>
    {% else %}
    <p style="color: red; font-size:100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  }
