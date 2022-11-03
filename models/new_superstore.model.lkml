connection: "superstore"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
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


explore: orders_vw {

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
}
