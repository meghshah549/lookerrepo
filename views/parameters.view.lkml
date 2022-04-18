view: parameters {

  parameter: select_timeframe {
    type: unquoted
    default_value: "month"
    allowed_value: {
      value: "year"
      label: "Years"
    }
    allowed_value: {
      value: "month"
      label: "Months"
    }
    allowed_value: {
      value: "week"
      label: "Weeks"
    }
    allowed_value: {
      value: "day"
      label: "Days"
    }
  }

  parameter: select_reference_date {
    type: date
    #convert_tz: no
  }

  dimension_group: current_timestamp {
    hidden: yes
    type: time
    timeframes: [raw,date,hour_of_day,day_of_week_index,day_of_month,day_of_year]
    convert_tz: yes
    sql: CURRENT_DATE() ;;
    datatype: date

  }
}
