view: returns {

  sql_table_name: `sample_superstore.returns`    ;;

  dimension: order_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.Order_ID ;;
  }

  dimension: returned {
    type: yesno
    sql: ${TABLE}.Returned ;;
  }

  measure: count {
    type: count
    drill_fields: [orders.order_id, orders.customer_name, orders.product_name]
  }
}

#Comment added in returns


#New retruns

#Reviewer Added
