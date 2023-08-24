connection: "superstore"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.

#persist_with: new_sample_superstore_caching
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

label: "online super store"

datagroup: new_sample_superstore_caching {
  max_cache_age: "3 hours"
  sql_trigger: select max(id) from order_id;;
}

persist_with: new_sample_superstore_caching

explore: orders_vw {
  #extension: required
######################## practice------------------------------
  #sql_always_where: ${created_date} >= '2019-01-01';;
#always_join: [inventory_vw,users_vw,products_vw]
  # always_filter: {
  #   filters: [user_id: "123"]
  # }
  # conditionally_filter: {
  #   filters: [id: "456", users_vw.id: "678,789"]
  #   unless: [date]
  # }
  #############################________________________________
  # access_filter: {
  #   field: users_vw.age
  #   user_attribute:
  # }

  description: "Start here for Event analysis"
  fields: [ALL_FIELDS*]
  from: orders_vw
  view_name: orders_vw
  extends: [orders_native]

#description: "this is orders explore"
group_label: "learn super store"

  join: users_vw {
    type: left_outer
    sql_on: ${orders_vw.user_id} = ${users_vw.id} ;;
    relationship: many_to_one
  }

  join: inventory_vw {
    type: left_outer
    sql_on: ${orders_vw.inventory_item_id} = ${inventory_vw.id} ;;
    relationship: many_to_one
  }

  join: products_vw {
    type: left_outer
    sql_on: ${inventory_vw.product_id} = ${products_vw.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers_vw {
    type: left_outer
    sql_on: ${products_vw.distribution_center_id} = ${distribution_centers_vw.id} ;;
    relationship: many_to_one
  }
  join: derivedn_order {
  type: left_outer
  sql_on: ${orders_vw.user_id} = ${derivedn_order.user_id} ;;
  relationship: many_to_one
  }
  join:sql_derived_order{
    type: left_outer
    sql_on: ${orders_vw.user_id} = ${sql_derived_order.user_id} ;;
  relationship: many_to_one
  }
  # join: templated_filter {
  #   type: left_outer
  #   sql_on: ${order_vw.user_id} = ${templated_filter.user_id};;
  #   relationship: many_to_one
  # }

  # join: dd_order_vw {
  #   type: left_outer
  #   sql_on: ${orders_vw.user_id} = ${dd_order_vw.user_id} ;;
  #   relationship: many_to_one
  # }


}
#explore: orders_derived_table_vw {}

# join: testn_derived {
#   type: left_outer
#   sql_on: ${orders_vw.user_id} = ${testn_derived.user_id} ;;
#   relationship: many_to_one
# }

explore: orders_native {
  # join: inventory_vw {
  #   type: left_outer
  #   sql_on: ${orders_native.id} = ${inventory_vw.id} ;;
  #   relationship: many_to_one
  # }
}
#hidden: yes
