
view: orders_fact {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:SELECT
       order_id AS order_id
      ,order_date
       ,COUNT(distinct order_id) AS lifetime_order_count
       ,SUM(sales) AS lifetime_revenue
       ,MIN(order_date) AS first_order_date
       ,MAX(order_date) AS latest_order_date
       FROM sample_superstore.orders
       WHERE {% condition order_date %} orders.order_date {% endcondition %}
       GROUP BY order_id,order_date
            ;;
  }


  dimension_group: order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.order_date ;;
    datatype: date
  }

  # Define your order_id and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: lifetime_revenue {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }

  measure: total_lifetime_orders {
    description: "Use this for counting lifetime orders across many users"
    type: sum
    sql: ${lifetime_revenue} ;;
  }
}
