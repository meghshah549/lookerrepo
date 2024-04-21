# The name of this view in Looker is "Office"
view: office {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `analytics-ai-poc.my_dataset.office` ;;
  drill_fields: [office_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: office_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.office_id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Head Salesperson ID" in Explore.

  dimension: head_salesperson_id {
    type: number
    sql: ${TABLE}.head_salesperson_id ;;
  }

  dimension: office_name {
    type: string
    sql: ${TABLE}.office_name ;;
  }

  dimension: office_zipcode {
    type: number
    sql: ${TABLE}.office_zipcode ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_office_zipcode {
    type: sum
    sql: ${office_zipcode} ;;  }
  measure: average_office_zipcode {
    type: average
    sql: ${office_zipcode} ;;  }
  measure: count {
    type: count
    drill_fields: [office_id, office_name]
  }
}
