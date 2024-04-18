resource "datadog_dashboard" "tfer--dashboard_v8f-qp8-c7y" {
  is_read_only = "false"
  layout_type  = "ordered"
  reflow_type  = "fixed"
  title        = "Organization-Level-3"
  url          = "/dashboard/v8f-qp8-c7y/organization-level"

  widget {
    free_text_definition {
      color      = "#41c464"
      font_size  = "auto"
      text       = "APP1 OVERVIEW"
      text_align = "center"
    }

    widget_layout {
      height          = "1"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "0"
    }
  }

  widget {
    free_text_definition {
      color      = "#FF780A"
      font_size  = "auto"
      text       = "APP2 OVERVIEW"
      text_align = "center"
    }

    widget_layout {
      height          = "1"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "0"
    }
  }

  widget {
    group_definition {
      background_color = "blue"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "APP1 Hosts Overview"

      widget {
        hostmap_definition {
          no_group_hosts  = "true"
          no_metric_hosts = "true"
          node_type       = "host"

          request {
            fill {
              q = "avg:system.net.tcp.active_opens{app:staging} by {host}"
            }
          }

          scope = ["app:staging"]

          style {
            fill_max     = "auto"
            fill_min     = "auto"
            palette      = "green_to_orange"
            palette_flip = "true"
          }

          title       = "App1 Host Map"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_table_definition {
          live_span = "1d"

          request {
            formula {
              alias              = "Free disk space"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            formula {
              alias = "Percentage"

              conditional_formats {
                comparator = "<"
                hide_value = "false"
                palette    = "white_on_red"
                value      = "10"
              }

              conditional_formats {
                comparator = ">="
                hide_value = "false"
                palette    = "white_on_green"
                value      = "10"
              }

              formula_expression = "(query2 / query3) * 100"

              limit {
                count = "500"
                order = "desc"
              }
            }

            formula {
              alias              = "Total disk"
              cell_display_mode  = "bar"
              formula_expression = "query3"
            }

            formula {
              alias              = "Used disk space"
              cell_display_mode  = "bar"
              formula_expression = "query2"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.disk.free{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:system.disk.used{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query3"
                query       = "sum:system.disk.total{app:staging} by {host}"
              }
            }
          }

          title = "Amount of free and used disk space per device"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "2"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "1"

          request {
            formula {
              formula_expression = "query1"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "avg:system.uptime{app:staging}"
              }
            }
          }

          title = "System uptime"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "line"

            formula {
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:kubernetes.cpu.usage.total{app:staging} by {host}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }

          show_legend = "true"
          title       = "CPU usage per node"
          title_align = "left"
          title_size  = "16"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "6"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "1d"

          request {
            display_type = "area"

            formula {
              alias              = "% time the CPU spent in an idle state"
              formula_expression = "query1"
            }

            formula {
              alias              = "% time the CPU spent running the kernel"
              formula_expression = "query2"
            }

            formula {
              alias              = "% time the CPU spent running the virtual processor"
              formula_expression = "query6"
            }

            formula {
              alias              = "% time the CPU spent running user space processes"
              formula_expression = "query4"
            }

            formula {
              alias              = "% time the CPU spent waiting for IO operations to complete"
              formula_expression = "query3"
            }

            formula {
              alias              = "% time the virtual CPU spent waiting for the hypervisor to service another virtual CPU"
              formula_expression = "query5"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.cpu.idle{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query2"
                query       = "sum:system.cpu.system{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query3"
                query       = "sum:system.cpu.iowait{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query4"
                query       = "sum:system.cpu.user{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query5"
                query       = "sum:system.cpu.stolen{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query6"
                query       = "sum:system.cpu.guest{app:staging} by {host}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }

          show_legend = "false"
          title       = "CPU usage breakdown (%)"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "3"
          x               = "3"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "1d"

          request {
            display_type = "area"

            formula {
              alias              = "RAM total"
              formula_expression = "query2"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query2"
                query       = "sum:system.mem.total{*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }

          request {
            display_type = "area"

            formula {
              alias              = "RAM used"
              formula_expression = "query0"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query0"
                query       = "sum:system.mem.used{*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }

          show_legend = "false"
          title       = "RAM  breakdown"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "8"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "bars"

            formula {
              alias              = "Network bytes received"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.net.bytes_rcvd{*,*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Network bytes sent"
              formula_expression = "0 - query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.net.bytes_sent{*,*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }

          show_legend = "false"
          title       = "Network traffic (bytes per sec)"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "10"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "area"

            formula {
              alias              = "% of swap free"
              formula_expression = "query1 * 100"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "avg:system.swap.pct_free{*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }

          show_legend = "false"
          title       = "Available Swap"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "3"
          x               = "9"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "error dashed"
            label        = "full"
            value        = "y = 100"
          }

          request {
            display_type = "line"

            formula {
              formula_expression = "query1 * 100"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.disk.in_use{app:staging} by {host}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }

          show_legend = "true"
          title       = "Disk usage by device (%)"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "3"
          x               = "6"
          y               = "2"
        }
      }
    }

    widget_layout {
      height          = "5"
      is_column_break = "true"
      width           = "12"
      x               = "0"
      y               = "1"
    }
  }

  widget {
    group_definition {
      background_color = "orange"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "APP2 Hosts Overview"

      widget {
        hostmap_definition {
          no_group_hosts  = "true"
          no_metric_hosts = "true"
          node_type       = "host"

          request {
            fill {
              q = "avg:system.net.tcp.active_opens{app:staging} by {host}"
            }
          }

          scope = ["app:staging"]

          style {
            fill_max     = "auto"
            fill_min     = "auto"
            palette      = "green_to_orange"
            palette_flip = "true"
          }

          title       = "App2 Host Map"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_table_definition {
          live_span = "1d"

          request {
            formula {
              alias              = "Free disk space"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            formula {
              alias = "Percentage"

              conditional_formats {
                comparator = "<"
                hide_value = "false"
                palette    = "white_on_red"
                value      = "10"
              }

              conditional_formats {
                comparator = ">="
                hide_value = "false"
                palette    = "white_on_green"
                value      = "10"
              }

              formula_expression = "(query2 / query3) * 100"

              limit {
                count = "500"
                order = "desc"
              }
            }

            formula {
              alias              = "Total disk"
              cell_display_mode  = "bar"
              formula_expression = "query3"
            }

            formula {
              alias              = "Used disk space"
              cell_display_mode  = "bar"
              formula_expression = "query2"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.disk.free{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:system.disk.used{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query3"
                query       = "sum:system.disk.total{app:staging} by {host}"
              }
            }
          }

          title = "Amount of free and used disk space per device"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "2"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "1"

          request {
            formula {
              formula_expression = "query1"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "avg:system.uptime{app:staging}"
              }
            }
          }

          title = "System uptime"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "bars"

            formula {
              alias              = "Network bytes received"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.net.bytes_rcvd{*,*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Network bytes sent"
              formula_expression = "0 - query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.net.bytes_sent{*,*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "warm"
            }
          }

          show_legend = "false"
          title       = "Network traffic (bytes per sec)"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "10"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "line"

            formula {
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:kubernetes.cpu.usage.total{app:staging} by {host}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "warm"
            }
          }

          show_legend = "true"
          title       = "CPU usage per node"
          title_align = "left"
          title_size  = "16"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "6"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "area"

            formula {
              alias              = "% of swap free"
              formula_expression = "query1 * 100"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "avg:system.swap.pct_free{*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "warm"
            }
          }

          show_legend = "false"
          title       = "Available Swap"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "3"
          x               = "9"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "1d"

          request {
            display_type = "area"

            formula {
              alias              = "% time the CPU spent in an idle state"
              formula_expression = "query1"
            }

            formula {
              alias              = "% time the CPU spent running the kernel"
              formula_expression = "query2"
            }

            formula {
              alias              = "% time the CPU spent running the virtual processor"
              formula_expression = "query6"
            }

            formula {
              alias              = "% time the CPU spent running user space processes"
              formula_expression = "query4"
            }

            formula {
              alias              = "% time the CPU spent waiting for IO operations to complete"
              formula_expression = "query3"
            }

            formula {
              alias              = "% time the virtual CPU spent waiting for the hypervisor to service another virtual CPU"
              formula_expression = "query5"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.cpu.idle{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query2"
                query       = "sum:system.cpu.system{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query3"
                query       = "sum:system.cpu.iowait{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query4"
                query       = "sum:system.cpu.user{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query5"
                query       = "sum:system.cpu.stolen{app:staging} by {host}"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query6"
                query       = "sum:system.cpu.guest{app:staging} by {host}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "warm"
            }
          }

          show_legend = "false"
          title       = "CPU usage breakdown (%)"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "3"
          x               = "3"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "1d"

          request {
            display_type = "area"

            formula {
              alias              = "RAM total"
              formula_expression = "query2"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query2"
                query       = "sum:system.mem.total{*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }

          request {
            display_type = "area"

            formula {
              alias              = "RAM used"
              formula_expression = "query0"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query0"
                query       = "sum:system.mem.used{*}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "warm"
            }
          }

          show_legend = "false"
          title       = "RAM  breakdown"

          yaxis {
            include_zero = "true"
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "8"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "error dashed"
            label        = "full"
            value        = "y = 100"
          }

          request {
            display_type = "line"

            formula {
              formula_expression = "query1 * 100"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.disk.in_use{app:staging} by {host}"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "warm"
            }
          }

          show_legend = "true"
          title       = "Disk usage by device (%)"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "3"
          x               = "6"
          y               = "2"
        }
      }
    }

    widget_layout {
      height          = "5"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "7"
    }
  }
}
