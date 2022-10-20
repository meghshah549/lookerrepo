view: order_fact_ndt {
  derived_table: {
    explore_source: orders {
      column: net_sales {}
      column: user_count {}
      column: order_id {}
      column: order_date {}
      derived_column: product_rank {
        sql: row_number() over (order by net_sales desc) ;;
      }
      #filters: [orders.order_date: "365 days"]
    bind_filters: {
      from_field: orders.order_date
      to_field: orders.order_date
    }
    #bind_all_filters: yes
    }
  }
  dimension: net_sales {
    description: ""
    value_format: "$#,##0"
    type: number
  }
  dimension: user_count {
    description: ""
    type: number
  }
  dimension: order_id {
    description: ""
  }


  dimension: is_top_5 {
    type: yesno
    sql: ${TABLE}.product_rank<5 ;;
  }

  dimension: ranked_brands {
    type: string
    sql: case when ${is_top_5} then ${TABLE}.product_rank || ')' || ${order_id} else 'Other' end ;;
  }
}
