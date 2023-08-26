# The name of this view in Looker is "Salary"
view: salary {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `poc-analytics-ai.sample_superstore.salary` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Emp ID" in Explore.

  dimension: emp_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.emp_id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: end_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.end_dt ;;
  }

  dimension: sal {
    type: number
    sql: ${TABLE}.sal ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sal {
    type: sum
    sql: ${sal} ;;  }
  measure: average_sal {
    type: average
    sql: ${sal} ;;  }

  dimension_group: start_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_dt ;;
  }
  measure: count {
    type: count
    drill_fields: [emp.name, emp.id]
  }
}
