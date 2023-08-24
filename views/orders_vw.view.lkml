include: users_vw.view

# The name of this view in Looker is "Orders Vw"
view: orders_vw {
  extends: [users_vw]
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `poc-analytics-ai.sample_superstore.orders_vw`
    ;;
  drill_fields: [order_item_id,count,first_order_date]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: order_item_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    datatype: date
  }

  dimension: delivered_at {
    type: string
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: returned_at {
    type: string
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: shipped_at {
    type: string
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
#-----------------------------------------------------
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    drill_fields: [order_item_id,status]
  }

  measure: count {
    type: count
    drill_fields: [order_item_id,status]
  }

  ###########################################333
  parameter: item_to_add_up {
    type: unquoted
    allowed_value: {
      label: "Total Sale Price"
      value: "sale_price"
    }
    allowed_value: {
      label: "Total Cost"
      value: "total_cost"
    }
  }
  parameter: number_of_results {
    type: string
    allowed_value: {
      label: "Less than 500"
      value: "< 500"
    }
    allowed_value: {
      label: "Less than 10,000"
      value: "< 10000"
    }
    allowed_value: {
      label: "All Results"
      value: "> 0"
    }
  }
  # dimension: range {
  #   sql:
  #   {% if number_of_results._parameter_value < '500' %}
  #     ${}
  #   {% elsif number_of_results._parameter_value < '10000' %}
  #     ${}
  #   {% else %}
  #     ${}
  #   {% endif %};;
  # }

  measure: dyanmic_sum {
    type: sum
    sql: ${TABLE}.{% parameter item_to_add_up %} ;;
    value_format_name: "usd"
  }

  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Day"
      value: "day"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
  }

  dimension: date {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      ${created_date}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${created_month}
      {% elsif date_granularity._parameter_value == 'year' %}
      ${created_year}
    {% else %}
      ${created_date}
    {% endif %};;
    html:
    {% if date_granularity._parameter_value == 'day' %}
    <font color="green">{{ rendered_value }}</font>
    {% elsif date_granularity._parameter_value == 'month' %}
    <font color="red">{{ rendered_value }}</font>
    {% elsif date_granularity._parameter_value == 'year' %}
    <font color="blue">{{ rendered_value }}</font>
    {% else %}
    <font color="black">{{ rendered_value }}</font>
    {% endif %};;
  }
  parameter: date_selector {
    type: date_time
    description: "Use this field to select a date to filter results by."
  }
  #############################"MTD&YTD"#####################################################
  dimension: before_mtd {
    type: yesno
    sql: EXTRACT(Month from ${date}) < EXTRACT(Month from CURRENT_DATE);;
  }
  dimension: is_before_mtd {
    type: number
    # sql: EXTRACT(Month from ${date}) < EXTRACT(Month from ${date});;
    # sql: current_date-1 ;;
    #sql:EXTRACT(Year from CURRENT_DATE);;
    #sql: ${created_date} >= CURRENT_DATE ;;
    sql: ;;
    }
#   measure: net_sales_current_month {
#     type: sum
#     sql: case
#         when date(${created_date}) >= Cast(Concat({% parameter ${created_year} %},'-',{% parameter fiscal_month_filter %}, '-01') as date)
#         AND date(${created_date}) < date_add(Cast(Concat ({% parameter fiscal_year_filter %},'-',{% parameter fiscal _month _filter %},'-01') as date),
#         INTERVAL 1 Month)
#         THEN ${TABLE}.net_sales
#         end;;
# }
  dimension_group: current_c {
    type: time
    sql: GETDATE() ;;
  }

  dimension: before_ytd {
    type: yesno
    sql: EXTRACT(year from ${date}) < EXTRACT(year from CURRENT_DATE);;
  }
######################sets#################################
  set: my_first_set {
    fields: [
      order_id,
      sale_price,
      count
    ]
  }
  set: my_second_set {
    fields: [
      delivered_at,
      average_cost
    ]
  }
  set: my_third_set {
    fields: [
      my_first_set*,
      my_second_set*
    ]
  }
##########################################################
  measure : total_life_time_orders{
    type :sum
    sql: ${order_item_id} ;;
  }
  measure: total_lifetime_revenue {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;

  }
  measure: first_order_date{
    type: date
    sql: MIN(${created_date}) ;;

  }
  measure: latest_order_date{
    type: date
    sql: MAX(${created_date}) ;;
  }
  measure: is_active{
    type: yesno
    sql: DATE_DIFF(CURRENT_DATE(),DATE(${latest_order_date}),DAY)<=320 ;;
  }
  measure: days_since_latest_order{
    type: number
    sql: DATE_DIFF(CURRENT_DATE(),DATE(${latest_order_date}),DAY);;
  }
  measure: order_count {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: repeat_customer{
    type: yesno
    sql: ${order_count}>1 ;;
    # COUNT(${order_id} > 1) ;;

  }

  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.sale_price;;
    #  sql: ${sale_price};;gggg
  }




  measure: avg_sale_price { # the new name
  # alias: [count, average_sale_price]  # the old names
    type: average
    value_format_name: usd
    sql: ${sale_price} ;;
  }


  measure: cumulative_total_revenue {
    type: running_total
    sql: ${total_sale_price} ;;
  }


  measure: total_gross_revenue {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    filters: [status: "-Cancelled,-Returned"]
  }

  measure: total_cost {
    type: sum
    sql: ${inventory_vw.cost} ;;
  }

  measure: average_cost{
    type: average
    sql: ${inventory_vw.cost} ;;
    value_format_name: usd

  }

  measure: total_gross_margin_amount {
    type: number
    value_format_name: usd
    sql: ${total_gross_revenue}-${inventory_vw.total_cost}  ;;

  }


  measure: gross_margin_percentage {
    type: number
    sql: ${total_gross_margin_amount}/${total_gross_revenue} ;;
    value_format_name: percent_2
  }


  measure: average_gross_margin {
    type: number
    sql: ${total_gross_revenue} - ${inventory_vw.total_cost}  ;;
    value_format_name:  usd
  }


  measure: number_of_items_returned {
    type: count
    filters: [status: "Returned"]

  }


  measure:total_items_sold {
    type: count
    filters: [status: "Complete"]
  }

  measure:  item_return_rate {
    type: number
    sql: ${number_of_items_returned}/${total_items_sold}  ;;
    value_format_name:  usd
  }


  measure: count_users {
    type: count_distinct
    sql: ${user_id}   ;;
  }
  measure: average_spend_per_customer {
    type: number
    value_format_name: usd
    sql:  ${total_sale_price}/ ${count_users}   ;;
  }


  measure: number_of_Customers_returning_items {
    type: count_distinct
    sql:CASE WHEN order_items.status = 'Returned' THEN order_items.user_id  ELSE NULL END  ;;
  }


  # SELECT
  # COUNT(DISTINCT CASE WHEN order_items.status = 'Returned' THEN order_items.user_id  ELSE NULL END) AS filtered_order_items_count_users
  # FROM `cloud-training-demos.looker_ecomm.order_items`
  # AS order_items
  # LIMIT 500


  measure: percentage_of_user_with_returns {
    type: number
    sql: ${number_of_Customers_returning_items}/${count_users} ;;
    value_format_name: percent_2
  }

  measure: test {
    type: number
    sql: ${total_lifetime_revenue}-${inventory_vw.total_cost} ;;

  }

}
