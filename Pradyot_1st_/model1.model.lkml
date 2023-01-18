connection: "superstore"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: orders_vw {
  join: users_vw {
    relationship: many_to_one
    sql_on: ${orders_vw.id} = ${users_vw.id} ;;
  }

  join: inventory_vw {
    type: left_outer
    sql_on: ${orders_vw.inventory_item_id} = ${inventory_vw.id} ;;
    relationship: many_to_one
  }
}
