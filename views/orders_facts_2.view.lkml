view: orders_facts_2 {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
        category as category
        FROM orders
  WHERE {% condition date_filter %} orders.order_date {% endcondition %}
      ;;
  }

  filter: date_filter {
    type: date
    datatype: date
  }
  # Define your dimensions and measures here, like this:
  dimension: category {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.category ;;
  }

}
