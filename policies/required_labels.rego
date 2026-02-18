package kubernetes.requiredlabels

# Import your parameters so OPA knows what "parameters" is
import data.parameters

violation contains result if {
    # 1. Get provided labels
    provided := {label | input.resource.metadata.labels[label]}

    # 2. Get required labels (FIXED)
    # We iterate over the list `parameters.data.labels`
    # and assign each item to `label`
    required := {label | label := parameters.labels[_]}

    # 3. Calculate missing
    missing := required - provided

    # 4. Check if any are missing
    count(missing) > 0

    result := {
        "msg": sprintf("missing labels: %v", [missing]),
        "missing_labels": missing
    }
}