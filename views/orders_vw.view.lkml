# The name of this view in Looker is "Orders Vw"
view: orders_vw {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `poc-analytics-ai.sample_superstore.orders_vw`
    ;;
  drill_fields: [order_item_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: order_item_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Delivered At" in Explore.

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

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  dimension: shipped_at {
    type: string
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [order_item_id]
  }
  #######
  dimension: customer_lifetime_orders {
    type: tier
    tiers: [1, 2, 3, 5, 6, 9, 10]
    style: integer
    sql: ${order_id} ;; #order #total_life_time_orders
  }

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
    sql: DATE_DIFF(CURRENT_DATE(),DATE(${latest_order_date}),DAY)<=100 ;;
  }

  measure: repeat_customer{
    type: yesno
    sql: COUNT(CASE WHEN ${order_id} > 1 THEN 2 ELSE 1 END) ;;
    # COUNT(${order_id} > 1) ;;

  }
}
