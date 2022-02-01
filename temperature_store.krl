ruleset temperature_store {
    meta {
        name "Temperature Store"
        description << Ruleset for Temperature Store >>
        author "Cameron Brown"
    }

    global {

    }

    rule collect_temperatures {
        select when wovyn new_temperature_reading
        pre {
            temperature = event:attrs{"temperature"}.klog("Temperature ")
            temperature_timestamp = event:attrs{"timestamp"}.klog("Timestamp ")
        }
    }

    rule collect_threshold_violation  {
        select when wovyn threshold_violation
        pre {
            violation_temperature = event:attrs{"temperature"}.klog("Violation Temperature")
            violation_timestamp = event:attrs{"timestamp"}.klog("Violation Timestamp")
        }
    }

    rule clear_temperatures {
        select when sensor reading_reset
        always {
            clear ent:temperature
            clear ent:temperature_timestamp
            clear ent:violation_temperature
            clear ent:violation_timestamp
        }
    }
}