# If necessary, uncomment the line below to include explore_source.

# include: "new_superstore.model.lkml"

view: orders_native {
  derived_table: {
    explore_source: orders_vw {
      column: total_lifetime_revenue {}
      column: order_count {}
      column: id { field: users_vw.id }
    }
  }
  measure: total_lifetime_revenue {
    description: ""
    value_format: "$#,##0.00"
    type: average
  }
  measure: order_count {
    description: ""
    type: average
    value_format_name: decimal_2
  }
  dimension: id {
    description: ""
    type: number
    primary_key: yes
  }
}
