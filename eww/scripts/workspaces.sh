#!/bin/sh
generate_workspaces() {
    workspaces=$(hyprctl workspaces -j)
    active_workspace_id=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')

    echo "$workspaces" | jq -c --argjson active_id "$active_workspace_id" 'map({id: .id, occupied: (.windows > 0), active: (.id == $active_id)}) | sort_by(.id)'
}

generate_workspaces

socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r event; do
    case ${event%%>>*} in
        workspace|focusedmon|createworkspace|destroyworkspace|openwindow|closewindow)
            generate_workspaces
            ;;
    esac
done
