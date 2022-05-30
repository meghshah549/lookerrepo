
view: people {
  sql_table_name: `sample_superstore.people`
    ;;

  dimension: person {
    type: string
    sql: ${TABLE}.person ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}


#Added comment to check advance deployment mode
