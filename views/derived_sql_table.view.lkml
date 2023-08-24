 view: templated_filter {
  derived_table: {
    sql: SELECT
           order_vw.user_id AS user_id
          ,COUNT(distinct order_vw.order_id) AS lifetime_order_count
          ,SUM(order_vw.sale_price) AS lifetime_revenue
          ,MIN(order_vw.created_at) AS first_order_date
          ,MAX(order_vw.created_at) AS latest_order_date
          FROM order_vw
          WHERE {% condition select_date %} order_vw.created_at {% endcondition %}
          GROUP BY user_id;;
  }
  filter: select_date {
    type: date
    suggest_explore: order_vw
    suggest_dimension: order_vw.created_date
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_order_count {
    type: number
    sql: ${TABLE}.lifetime_order_count ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension_group: first_order_date {
    type: time
    sql: ${TABLE}.first_order_date ;;
  }

  dimension_group: latest_order_date {
    type: time
    sql: ${TABLE}.latest_order_date ;;
  }

  measure: average_lifetime_revenue {
    type: average
    sql: ${TABLE}.lifetime_revenue ;;
  }
  measure: average_lifetime_order_count {
    type: average
    sql: ${TABLE}.lifetime_order_count ;;
  }
}
