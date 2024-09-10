# Generate plugin list

PLUGINS="vi-mode"
plugin_list=""
for plugin in $PLUGINS; do
    if [ "$(echo "$plugin" | grep -E '^http.*')" != "" ]; then
        plugin_name=$(basename "$plugin")
        echo $plugin
        git clone "$plugin" "$HOME"/.oh-my-zsh/custom/plugins/"$plugin_name"
    else
        plugin_name=$plugin
    fi
    plugin_list="${plugin_list}$plugin_name "
done

echo "fsdfsf";
