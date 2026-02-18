package kubernetes.requiredlabels

violation contains result if {

    provided := {label |
        input.resource.metadata.labels[label]
    }

    required := {label |
        label := data.parameters.labels[_]
    }

    missing := required - provided

    count(missing) > 0

    result := {
        "msg": sprintf("missing labels: %v", [missing]),
        "missing_labels": missing
    }
}
