view: orders_derived_table_vw  {
  derived_table: {
    explore_source: orders_vw {
      column: user_id {
        field: orders_vw.user_id
      }
      column: total_lifetime_revenue {
        field: orders_vw.total_lifetime_revenue
      }
      column: days_since_latest_order {
        field: orders_vw.days_since_latest_order
      }
      column: order_id {}
      column: order_count {}
    }
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    primary_key: yes
  }
     dimension: order_id {
      description: ""
      type: number
    }
    measure: number_of_orders {
      type: count_distinct
      sql: ${order_id} ;;
    }

  measure: total_lifetime_revenue {
    description: ""
    value_format: "$#,##0.00"
    type: average
  }
  dimension: customer_lifetime_revenue {
    type: tier
    tiers: [0.00, 4.99, 5.00, 19.99, 20.00, 49.99, 50.00, 99.99, 100.00, 499.99, 500.00, 999.99, 1000.00]
    style: relational
    value_format_name: usd
    sql: ${TABLE}.total_lifetime_revenue ;;
  }

  measure: order_count {
    type: count_distinct
    sql: ${order_id} ;;
    # description: ""
    # type: average
    # value_format_name: decimal_2
  }

  measure: days_since_latest_order {
    type: number
   sql: DATE_DIFF(CURRENT_DATE(),DATE(${orders_vw.latest_order_date}),DAY);;
  }


  measure: avg_lifetime_of_orders {
    type: average
    sql: ${TABLE}.number_of_orders ;;
  }

  measure: average_lifetime_revenue {
    type: average
    sql: ${TABLE}.total_lifetime_revenue;;
  }


}
