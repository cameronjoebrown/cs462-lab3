ruleset temperature_store {
    meta {
        name "Temperature Store"
        description << Ruleset for Temperature Store >>
        author "Cameron Brown"
    }

    rule collect_temperatures {
        select when wovyn new_temperature_reading
        pre {
            temperature = event:attrs{"temperature"}.klog("Temperature ")
            timestamp = event:attrs{"timestamp"}.klog("Timestamp ")
        }
    }

    rule collect_threshold_violation  {
        
    }

    rule clear_temperatures {

    }
}