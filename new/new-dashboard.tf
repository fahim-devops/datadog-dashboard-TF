# define the data source for the Datadog provider
data "datadog_monitor" "org_dashboard" {
  type = "dashboard"
  id   = "6361941746896450+203571-11-29T00:48:16.450Z"
}

# define the Datadog dashboard
resource "datadog_dashboard" "org_dashboard" {
  title       = "Organization-Level"
  description = ""

  # define the first widget
  widget {
    id = "4443220072601812+142770-01-15T05:56:41.812Z"

    # configure the group widget
    group {
      title            = "APP1 Hosts Overview"
      background_color = "vivid_orange"
      show_title       = true
      layout_type      = "ordered"

      # define the widgets within the group
      widgets {
        # define the host map widget
        hostmap {
          title        = "App1 Host Map"
          title_size   = 16
          title_align  = "left"
          request_q    = "avg:system.net.tcp.active_opens{app:staging} by {host}"
          node_type    = "host"
          no_metric    = true
          no_group     = true
          scope        = ["app:staging"]
          palette      = "green_to_orange"
          palette_flip = true
          fill_min     = "auto"
          fill_max     = "auto"
          layout {
            x      = 0
            y      = 0
            width  = 2
            height = 4
          }
        }

        # define the query value widget
        query_value {
          title     = "System uptime"
          requests  = ["avg:system.uptime{app:staging}"]
          precision = 1
          autoscale = true
          layout {
            x      = 2
            y      = 0
            width  = 1
            height = 2
          }
        }