
  view:  derivedn_order {
    derived_table: {
      explore_source: orders_vw {
        column: days_since_latest_order {}
        column: order_count {}
        column: total_lifetime_revenue {}
        column: user_id {}
      }
    }
    measure: days_since_latest_order {
      description: ""
      type: average
    }
    measure: order_count {
      description: ""
      type: average
    }
    measure: total_lifetime_revenue {
      description: ""
      value_format: "$#,##0.00"
      type: average
    }
    dimension: user_id {
      description: ""
      type: number
      primary_key: yes
    }

    dimension: customer_lifetime_revenue {
      type: tier
      tiers: [0.00, 5.00, 20.00, 50.00, 100.00, 500.00, 1000.00]
      style: relational
      value_format_name: usd
      sql: ${TABLE}.total_lifetime_revenue ;;
    }
    dimension: customer_lifetime_orders {
      type: tier
      tiers: [1, 2, 3, 6, 10]
      style: integer
      #sql: ${order_id};;
      sql: ${TABLE}.order_count ;;
    }
  }
