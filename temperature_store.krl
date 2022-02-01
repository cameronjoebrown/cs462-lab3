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
            collected_temperature = event:attrs{"temperature"}.klog("Temperature")
            temperature_timestamp = event:attrs{"timestamp"}.klog("Timestamp")
        }
        always {
            ent:temps := ent:temps.defaultsTo({}).put(temperature_timestamp, collected_temperature).klog("Temperatures")
        }
    }

    rule collect_threshold_violation  {
        select when wovyn threshold_violation
        pre {
            violation_temperature = event:attrs{"temperature"}.klog("Violation Temperature")
            violation_timestamp = event:attrs{"timestamp"}.klog("Violation Timestamp")
        }
        always {
            ent:violations := ent:violations.defaultsTo({}).put(violation_timestamp, violation_temperature).klog("Violations")
        }
    }

    rule clear_temperatures {
        select when sensor reading_reset
        always {
            clear ent:temps
            clear ent:violations
        }
    }
}