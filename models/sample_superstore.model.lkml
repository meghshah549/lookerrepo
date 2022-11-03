
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
  join: order_fact_ndt {
    type: inner
    sql_on: ${order_fact_ndt.order_id}=${orders.order_id} ;;
    relationship: one_to_one
  }
}

explore: orders_fact {}

# explore: orders_new {
#   from: orders
#   fields: [orders_new.category]
# }
# explore: order_fact_ndt {
#   join: orders {
#     type: inner
#     sql_on: ${order_fact_ndt.order_id}=${orders.order_id} ;;
#     relationship: one_to_one
#   }
# }

explore: orders_facts_2 {}

explore: new_orders {}

explore: orders_new {
  join: returns_new {
    type: left_outer
    sql_on:${orders_new.order_id}=${returns_new.order_id} ;;
    relationship: many_to_one
  }
  join: people_new {
    type: left_outer
    sql_on: ${orders_new.region}=${people_new.region} ;;
    relationship: many_to_one
  }
}

explore: people_new {

  join: orders_new {
    type: left_outer
    sql_on:  ${orders_new.region}=${people_new.region} ;;
    relationship: many_to_one
  }
  join: returns_new {
    type: left_outer
    sql_on: ${people_new.region}=${returns_new.order_id} ;;
    relationship: many_to_one
  }

}
explore: orders_new_1  {
  from : orders_new
}
