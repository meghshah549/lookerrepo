view: sql_derived_order {
    derived_table: {
      sql:
      SELECT
    user_id,
    COALESCE(SUM(orders_vw.sale_price ), 0) AS orders_vw_total_lifetime_revenue,
    DATE_DIFF(CURRENT_DATE(),DATE(( (DATE(MAX(orders_vw.created_at) )) )),DAY) AS orders_vw_days_since_latest_order,
    COUNT(*) AS orders_vw_count
      FROM
        orders_vw
        WHERE {% condition select_date %} orders_vw.created_at {% endcondition %}
      GROUP BY
        user_id ;;
    }
  filter: select_date {
    type: date
    suggest_explore: orders_vw
    suggest_dimension: orders_vw.created_date
  }
  dimension: user_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: orders_vw_total_lifetime_revenue {
    type: average
    sql: ${TABLE}.orders_vw_total_lifetime_revenue ;;
  }
 measure: orders_vw_days_since_latest_order {
    type: average
    sql: ${TABLE}.orders_vw_days_since_latest_order ;;
  }
  measure: orders_vw_count {
    type: average
    sql: ${TABLE}.orders_vw_count ;;
  }
  dimension: customer_lifetime_revenue {
    type: tier
    tiers: [0.00, 5.00, 20.00, 50.00, 100.00, 500.00, 1000.00]
    style: relational
    value_format_name: usd
    sql: ${TABLE}.orders_vw_total_lifetime_revenue ;;
  }
  dimension: customer_lifetime_orders {
    type: tier
    tiers: [1, 2, 3, 6, 10]
    style: integer
    #sql: ${order_id};;
    sql: ${TABLE}.orders_vw_count ;;
  }
}
