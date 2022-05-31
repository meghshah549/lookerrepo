
connection: "superstore"



include: "/views/**/*.view"
include: "/views/**/*.dashboard.lookml"


datagroup: sample_superstore_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM orders;;
  max_cache_age: "1 minute"
}

persist_with: sample_superstore_default_datagroup



explore: orders {
    join: returns {
    type: left_outer
    sql_on: ${orders.order_id}=${returns.order_id} ;;
    relationship: many_to_one
  }
  join: people {
    type: left_outer
    sql_on: ${orders.region}=${people.region} ;;
    relationship: many_to_one
    fields: [people.person]
  }
  join: order_measure_type_view {
    type: inner
    sql_on: ${order_measure_type_view.order_id}=${orders.order_id} ;;
    relationship: one_to_one
  }
  join: parameters {}

}

explore: orders_fact {}

explore: orders_new {
  from: orders
  fields: [orders_new.category]
}
