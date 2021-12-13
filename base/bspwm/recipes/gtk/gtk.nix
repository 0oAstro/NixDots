{config, ...}:
{
    gtk = {
        enable = true;
        gtk3.extraConfig = {
            gtk-theme-name="Kizus-Phocus";
            gtk-icon-theme-name="Zafiro-icons-master";
            gtk-font-name="Iosevka Term 10";
            gtk-cursor-theme-name="volantes_light_cursors";
            gtk-cursor-theme-size=0;
            gtk-toolbar-style="GTK_TOOLBAR_BOTH_HORIZ";
            gtk-toolbar-icon-size="GTK_ICON_SIZE_LARGE_TOOLBAR";
            gtk-button-images=0;
            gtk-menu-images=0;
            gtk-enable-event-sounds=1;
            gtk-enable-input-feedback-sounds=1;
            gtk-xft-antialias=1;
            gtk-xft-hinting=1;
            gtk-xft-hintstyle="hintfull";
            gtk-xft-rgba="rgb";
        };
    };
}
