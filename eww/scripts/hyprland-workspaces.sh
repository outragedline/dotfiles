#!/bin/sh
generate_workspaces() {
    workspaces=$(hyprctl workspaces -j)
    active_workspace_id=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')

    echo "$workspaces" | jq -c --argjson active_id "$active_workspace_id" 'map({id: .id, occupied: (.windows > 0), active: (.id == $active_id)}) | sort_by(.id)'
}

# Generate the initial workspace state.
generate_workspaces

# Use socat to listen for Hyprland events and regenerate the state when it changes.
socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r event; do
    # We only care about events that affect workspace state.
    case ${event%%>>*} in
        workspace|focusedmon|createworkspace|destroyworkspace|openwindow|closewindow)
            generate_workspaces
            ;;
    esac
done
