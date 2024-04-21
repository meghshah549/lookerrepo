# The name of this view in Looker is "Customer"

view: customer {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `analytics-ai-poc.my_dataset.customer` ;;
  drill_fields: [customer_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Customer Company Name" in Explore.

  dimension: customer_company_name {
    type: string
    sql: ${TABLE}.customer_company_name ;;
  }

  dimension: customer_type {
    type: string
    sql: ${TABLE}.customer_type ;;
  }
  measure: count {
    type: count
    drill_fields: [customer_id, customer_company_name]
  }
}
