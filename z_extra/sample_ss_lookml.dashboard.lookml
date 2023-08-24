- dashboard: sample_superstore
  title: Sample Superstore
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: "# of Orders"
    name: "# of Orders"
    model: sample_superstore
    explore: orders
    type: looker_area
    fields: [orders.order_year, orders.count]
    fill_fields: [orders.order_year]
    sorts: [orders.order_year desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    series_types: {}
    series_colors: {}
    defaults_version: 1
    row: 3
    col: 0
    width: 10
    height: 8
  - title: Sales By Segment and Category
    name: Sales By Segment and Category
    model: sample_superstore
    explore: orders
    type: looker_column
    fields: [orders.segment, orders.category, orders.sales]
    pivots: [orders.category]
    sorts: [orders.sales desc 0, orders.category]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: asc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#598017"
    y_axes: [{label: '', orientation: left, series: [{axisId: orders.sales, id: orders.sales,
            name: Sales}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    hide_legend: true
    font_size: ''
    defaults_version: 1
    row: 3
    col: 10
    width: 14
    height: 8
  - title: Avg Time
    name: Avg Time
    model: sample_superstore
    explore: orders
    type: single_value
    fields: [orders.avg_time_to_deliver]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: #ff0000
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Average Time to Deliver
    value_format: ''
    series_types: {}
    defaults_version: 1
    row: 0
    col: 0
    width: 8
    height: 3
  - title: Avg Discount
    name: Avg Discount
    model: sample_superstore
    explore: orders
    type: single_value
    fields: [orders.avg_discount]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Discount
    series_types: {}
    defaults_version: 1
    row: 0
    col: 8
    width: 8
    height: 3
  - title: Avg Ordered Quantity
    name: Avg Ordered Quantity
    model: sample_superstore
    explore: orders
    type: single_value
    fields: [orders.avg_order_quantity]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Ordered Quantity
    defaults_version: 1
    row: 0
    col: 16
    width: 8
    height: 3
  - title: Profit % By Category
    name: Profit % By Category
    model: sample_superstore
    explore: orders
    type: looker_pie
    fields: [orders.category, orders.profit]
    sorts: [orders.category]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    inner_radius: 65
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    series_colors: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    font_size: 12
    row: 11
    col: 0
    width: 8
    height: 6
  - title: "# of Orders by Region and Category"
    name: "# of Orders by Region and Category"
    model: sample_superstore
    explore: orders
    type: looker_bar
    fields: [orders.region, orders.category, orders.count]
    pivots: [orders.category]
    sorts: [orders.count desc 0, orders.region, orders.category]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 6c27c30e-5523-4080-82ae-272146e699d0
      palette_id: 87654122-8144-4720-8259-82ac9908d5f4
      options:
        steps: 5
        reverse: false
    series_types: {}
    column_group_spacing_ratio: 0.2
    defaults_version: 1
    row: 11
    col: 8
    width: 8
    height: 6
  - title: Customer Profit vs Sales
    name: Customer Profit vs Sales
    model: sample_superstore
    explore: orders
    type: looker_scatter
    fields: [orders.sales, orders.profit, orders.customer_name]
    sorts: [orders.sales desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: true
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
      options:
        steps: 5
    y_axes: [{label: '', orientation: bottom, series: [{axisId: orders.sales, id: orders.sales,
            name: Sales}], showLabels: true, showValues: true, minValue: !!null '',
        valueFormat: '', unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    series_colors: {}
    swap_axes: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: [orders.customer_name]
    row: 11
    col: 16
    width: 8
    height: 6
