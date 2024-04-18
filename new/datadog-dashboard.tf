terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_key = "e67bde80f47065abb59c347d00d25b26"
  app_key = "14c5ffc2c17e24310fe8a22bd9919b8eb2385c83"
}

resource "datadog_dashboard" "dashboard-app" {
  title = "Organization-Level"

  description = ""

  widget {
    id = 6361941746896450

    definition = {
      type       = "free_text"
      text       = "APP1 OVERVIEW"
      color      = "#FF780A"
      font_size  = "auto"
      text_align = "center"
    }

    layout = {
      x      = 0
      y      = 0
      width  = 12
      height = 1
    }
  }

  widget {
    id = 4443220072601812

    title = "APP1 Hosts Overview"
    background_color = "vivid_orange"
    show_title       = true
    type             = "group"
    layout_type      = "ordered"

    widget {
      id = 6792595178567682

      title       = "App1 Host Map"
      title_size  = "16"
      title_align = "left"
      type        = "hostmap"

      request {
        q = "avg:system.net.tcp.active_opens{app:staging} by {host}"
      }

      node_type       = "host"
      no_metric_hosts = true
      no_group_hosts  = true
      scope           = ["app:staging"]

      style {
        palette      = "green_to_orange"
        palette_flip = true
        fill_min     = "auto"
        fill_max     = "auto"
      }

      layout {
        x = 0
        y = 0
        width  = 2
        height = 4
      }
    }

    widget {
      id = 6763601062329580

      title     = "System uptime"
      type      = "query_value"
      autoscale = true
      precision = 1

      request {
        response_format = "scalar"

        query {
          data_source = "metrics"
          name        = "query1"
          query       = "avg:system.uptime{app:staging}"
          aggregator  = "avg"
        }

        formulas {
          formula = "query1"
        }
      }

      layout {
        x = 2
        y = 0
        width  = 1
        height = 2
      }
    }

    widgets {

        id = 6792595178567682

        definition {
          title           = "App1 Host Map"
          title_size      = "16"
          title_align     = "left"
          type            = "hostmap"
          requests {
            fill = "avg:system.net.tcp.active_opens{app:staging} by {host}"
          }
          node_type       = "host"
          no_metric_hosts = true
          no_group_hosts  = true
          scope           = ["app:staging"]
          style {
            palette      = "green_to_orange"
            palette_flip = true
            fill_min     = "auto"
            fill_max     = "auto"
          }
        }

        layout {
          x      = 0
          y      = 0
          width  = 2
          height = 4
        }
    }
      
    widgets {
      id = 3694945162348432

      definition {
        title             = "CPU usage breakdown (%)"
        show_legend       = false
        legend_layout     = "auto"
        legend_columns    = ["avg", "min", "max", "value", "sum"]
        
        time {
          live_span = "1d"
        }

        type = "timeseries"

        requests {
          formulas {
            alias   = "% time the CPU spent in an idle state"
            formula = "query1"
          }

          formulas {
            alias   = "% time the CPU spent running the kernel"
            formula = "query2"
          }

          formulas {
            alias   = "% time the CPU spent waiting for IO operations to complete"
            formula = "query3"
          }

          formulas {
            alias   = "% time the CPU spent running user space processes"
            formula = "query4"
          }

          formulas {
            alias   = "% time the virtual CPU spent waiting for the hypervisor to service another virtual CPU"
            formula = "query5"
          }

          formulas {
            alias   = "% time the CPU spent running the virtual processor"
            formula = "query6"
          }

          queries {
            query        = "sum:system.cpu.idle{app:staging} by {host}"
            data_source  = "metrics"
            name         = "query1"
          }

          queries {
            query        = "sum:system.cpu.system{app:staging} by {host}"
            data_source  = "metrics"
            name         = "query2"
          }

          queries {
            query        = "sum:system.cpu.iowait{app:staging} by {host}"
            data_source  = "metrics"
            name         = "query3"
          }

          queries {
            query        = "sum:system.cpu.user{app:staging} by {host}"
            data_source  = "metrics"
            name         = "query4"
          }

          queries {
            query        = "sum:system.cpu.stolen{app:staging} by {host}"
            data_source  = "metrics"
            name         = "query5"
          }

          queries {
            query        = "sum:system.cpu.guest{app:staging} by {host}"
            data_source  = "metrics"
            name         = "query6"
          }

          response_format = "timeseries"

          style {
            palette    = "cool"
            line_type  = "solid"
            line_width = "normal"
          }

          display_type = "area"
        }

        yaxis {
          include_zero = true
          scale        = "linear"
          label        = ""
          min          = "auto"
          max          = "auto"
        }
      }

      layout {
        x      = 3
        y      = 0
        width  = 3
        height = 2
      }
    }

    widgets {
      id = 3050292239994896

      definition {
        title         = "CPU usage per node"
        title_size    = "16"
        title_align   = "left"
        show_legend   = true
        legend_layout = "auto"
        legend_columns = ["avg", "min", "max", "value", "sum"]
        type          = "timeseries"

        requests {
          formulas {
            formula = "query1"
          }

          queries {
            data_source = "metrics"
            name        = "query1"
            query       = "sum:kubernetes.cpu.usage.total{app:staging} by {host}"
          }

          response_format = "timeseries"

          style {
            palette    = "cool"
            line_type  = "solid"
            line_width = "normal"
          }

          display_type = "line"
        }

        yaxis {
          label        = ""
          scale        = "linear"
          include_zero = true
          min          = "auto"
          max          = "auto"
        }

        custom_links = []
      }

      layout {
        x      = 6
        y      = 0
        width  = 2
        height = 2
      }
    }

    widgets {
      id = 3968202803376266

      definition {
        title         = "RAM  breakdown"
        show_legend   = false
        legend_layout = "auto"
        legend_columns = ["avg", "min", "max", "value", "sum"]

        time {
          live_span = "1d"
        }

        type = "timeseries"

        requests {
          formulas {
            formula = "query2"
            alias   = "RAM total"
          }

          response_format = "timeseries"
          on_right_yaxis  = false

          queries {
            query       = "sum:system.mem.total{*}"
            data_source = "metrics"
            name        = "query2"
          }

          style {
            palette    = "cool"
            line_type  = "solid"
            line_width = "normal"
          }

          display_type = "area"
        }

        requests {
          formulas {
            formula = "query0"
            alias   = "RAM used"
          }

          response_format = "timeseries"
          on_right_yaxis  = false

          queries {
            query       = "sum:system.mem.used{*}"
            data_source = "metrics"
            name        = "query0"
          }

          style {
            palette    = "cool"
            line_type  = "solid"
            line_width = "normal"
          }

          display_type = "area"
        }

        yaxis {
          include_zero = true
          scale        = "linear"
          label        = ""
          min          = "auto"
          max          = "auto"
        }

        markers = []
      }

      layout {
        x      = 8
        y      = 0
        width  = 2
        height = 2
      }
    }

    widgets {
      id = 4192392801174552

      definition {
        title          = "Network traffic (bytes per sec)"
        show_legend    = false
        legend_layout  = "auto"
        legend_columns = ["avg", "min", "max", "value", "sum"]
        type           = "timeseries"

        requests {
          formulas {
            alias   = "Network bytes received"
            formula = "query1"
          }
          response_format = "timeseries"

          queries {
            query       = "sum:system.net.bytes_rcvd{*,*}"
            data_source = "metrics"
            name        = "query1"
          }

          style {
            palette    = "dog_classic"
            line_type  = "solid"
            line_width = "normal"
          }

          display_type = "bars"
        }

        requests {
          formulas {
            alias   = "Network bytes sent"
            formula = "0 - query1"
          }
          response_format = "timeseries"

          queries {
            query       = "sum:system.net.bytes_sent{*,*}"
            data_source = "metrics"
            name        = "query1"
          }

          style {
            palette    = "cool"
            line_type  = "solid"
            line_width = "normal"
          }

          display_type = "bars"
        }

        yaxis {
          include_zero = true
          scale        = "linear"
          label        = ""
          min          = "auto"
          max          = "auto"
        }
      }

      layout {
        x      = 10
        y      = 0
        width  = 2
        height = 2
      }
    }

    widget {
      id = 7983830562622318
      definition {
        title = "Amount of free and used disk space per device"
        time  = { live_span = "1d" }
        type  = "query_table"
        requests = [
          {
            response_format = "scalar"
            formulas = [
              {
                alias                 = "Free disk space"
                conditional_formats   = []
                cell_display_mode     = "bar"
                formula               = "query1"
              },
              {
                alias                 = "Used disk space"
                conditional_formats   = []
                cell_display_mode     = "bar"
                formula               = "query2"
              },
              {
                alias                 = "Total disk"
                conditional_formats   = []
                cell_display_mode     = "bar"
                formula               = "query3"
              },
              {
                alias                 = "Percentage"
                formula               = "(query2 / query3) * 100"
                limit                 = { count = 500, order = "desc" }
                conditional_formats = [
                  {
                    comparator = ">="
                    palette    = "white_on_green"
                    value      = 10
                  },
                  {
                    comparator = "<"
                    palette    = "white_on_red"
                    value      = 10
                  },
                ]
              },
            ]
            queries = [
              {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:system.disk.free{app:staging} by {host}"
                aggregator  = "avg"
              },
              {
                data_source = "metrics"
                name        = "query2"
                query       = "sum:system.disk.used{app:staging} by {host}"
                aggregator  = "avg"
              },
              {
                data_source = "metrics"
                name        = "query3"
                query       = "sum:system.disk.total{app:staging} by {host}"
                aggregator  = "avg"
              },
            ]
          }
        ]
        layout {
          x      = 2
          y      = 2
          width  = 4
          height = 2
        }
      }
    }

    widgets {
      id = 2715823568216230

      definition {
        title            = "Disk usage by device (%)"
        show_legend      = true
        legend_layout    = "auto"
        legend_columns   = ["avg", "min", "max", "value", "sum"]
        type             = "timeseries"

        requests {
          formulas {
            formula = "query1 * 100"
          }

          queries {
            data_source = "metrics"
            name        = "query1"
            query       = "sum:system.disk.in_use{app:staging} by {host}"
          }

          response_format = "timeseries"

          style {
            palette    = "cool"
            line_type  = "solid"
            line_width = "normal"
          }

          display_type = "line"
        }

        markers {
          label         = "full"
          value         = "y = 100"
          display_type  = "error dashed"
        }
      }

      layout {
        x      = 6
        y      = 2
        width  = 3
        height = 2
      }
    }

    widgets {
      id = 951253959272704

      definition {
        title = "Available Swap"
        show_legend = false
        legend_layout = "auto"
        legend_columns = ["avg", "min", "max", "value", "sum"]
        type = "timeseries"

        requests {
          query1 = {
            query = "avg:system.swap.pct_free{*}"
            data_source = "metrics"
          }

          formulas {
            alias = "% of swap free"
            formula = "query1 * 100"
          }

          response_format = "timeseries"

          style {
            palette = "cool"
            line_type = "solid"
            line_width = "normal"
          }

          display_type = "area"
        }

        yaxis {
          include_zero = true
          scale = "linear"
          label = ""
          min = "auto"
          max = "auto"
        }
      }

      layout {
        x = 9
        y = 2
        width = 3
        height = 2
      }
    }
  

    layout {
      x = 0
      y = 1
      width = 12
      height = 5
      is_column_break = true
    }
  } 

  template_variables = []

  layout_type = "ordered"

  notify_list = []

  reflow_type = "fixed"

  id = "v8f-qp8-c7y"

}