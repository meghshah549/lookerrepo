# The name of this view in Looker is "Returns New"
view: returns_new {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `poc-analytics-ai.sample_superstore.returns_new`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Order ID" in Explore.

  dimension: order_id {
    type: string
    sql: ${TABLE}.Order_ID ;;
  }

  dimension: returned {
    type: yesno
    sql: ${TABLE}.Returned ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
