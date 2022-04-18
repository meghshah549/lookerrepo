view: order_measure_type_view {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
        order_id as order_id,
        "Count" as measure_category
      FROM sample_superstore.orders
      UNION ALL
      SELECT
        order_id as order_id,
        "Sales" as measure_category
      FROM sample_superstore.orders    ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
    hidden: yes
  }


  dimension: measure_category {
    type: string
    sql: ${TABLE}.measure_category ;;
    view_label: "Orders"
  }
}
