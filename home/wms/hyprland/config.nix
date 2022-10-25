{
  pkgs,
  colors,
  ...
}: let
  xargb = colors.xargbColors;

  emoji = "${pkgs.wofi-emoji}/bin/wofi-emoji";
  launcher = "wofi";
  term = "${pkgs.foot}/bin/foot";
  term_alt = "${pkgs.alacritty}/bin/alacritty";

  config = ''
    # should be configured per-profile
    monitor=,1366x768@60,0x0,1
    workspace=VGA-1,1
    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY HYPRLAND_INSTANCE_SIGNATURE
    exec-once=systemctl --user start hyprland-session.target
    exec-once=env XDG_CUREENT_DESKTOP="Sway" ${pkgs.flameshot}/bin/flameshot
    exec-once=swaybg -i ~/.config/wallpaper.png
    exec-once=mako
    misc {
      no_vfr=0
      disable_hyprland_logo=1
      disable_splash_rendering=1
      enable_swallow=1
      swallow_regex="foot|kitty|alacritty"
    }
    input {
      kb_layout=ro
      sensitivity=0
      follow_mouse=1
      force_no_accel=1
      touchpad {
        natural_scroll=1
      }
    }
    general {
      sensitivity=1.0
      main_mod=SUPER
      gaps_in=8
      gaps_out=15
      border_size=5
      col.active_border=0x${xargb.base08}
      col.inactive_border=0x${xargb.base02}
      damage_tracking=full
    }
    decoration {
      rounding=7
      blur=0
      blur_new_optimizations=true
      blur_size=1
      blur_passes=1
      blur_new_optimizations=1
      drop_shadow=true
      shadow_ignore_window=1
      shadow_offset=2 2
      shadow_range=10
      shadow_render_power=1
      col.shadow=0x33000000
      col.shadow_inactive=0x22000000
    }
    animations {
      enabled=1
      bezier=overshot,0.13,0.99,0.29,1.1
      animation=windows,1,4,overshot,slide
      animation=border,1,10,default
      animation=fade,1,10,default
      animation=workspaces,1,6,overshot,slidevert    
    }
    dwindle {
      pseudotile=1
      force_split=0
    }
    
    # Window rules
    windowrule=fullscreen,^(flameshot)$
    windowrule=float,title:^(Media viewer)$
    windowrule=float,title:^(Picture-in-Picture)$
    windowrule=pin,title:^(Picture-in-Picture)$
    windowrule=float,title:^(Firefox — Sharing Indicator)$
    windowrule=move 0 0,title:^(Firefox — Sharing Indicator)$
    windowrule=tile,title:Spotify
    windowrule=workspace 4,title:Spotify
    windowrule=workspace 3,title:Discord
    windowrule=workspace 5,title:Telegram
    windowrule=workspace 2,^(firefox-nightly)$
    
    bind=SUPER,Return,exec,${term}
    bind=SUPERSHIFT,Return,exec,${term_alt}
    bind=SUPER,Space,exec,pkill .${launcher}-wrapped || ${launcher}
    bind=SUPER,Escape,exec,wlogout -p layer-shell
    bind=SUPER,E,exec,pkill wofi || ${emoji}
    bind=SUPER,Q,killactive,
    bind=SUPERSHIFT,E,exec,pkill Hyprland
    
    
    bind=SUPER,G,togglegroup,
    bind=SUPERSHIFT,N,changegroupactive,f
    bind=SUPERSHIFT,P,changegroupactive,b    
    
    # window resize
    bind=SUPER,S,submap,resize
    submap=resize
      binde=,right,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,down,resizeactive,0 10
      bind=,escape,submap,reset
    submap=reset
    
    bindm=SUPER,mouse:272,movewindow #LMB
    bindm=SUPER,mouse:273,resizewindow #RMB
    
    # layout
    bind=SUPER,F,fullscreen,
    bind=SUPER,R,togglesplit,
    bind=SUPER,T,togglefloating,
    bind=SUPER,P,pseudo,
    
    # utils
    bind=SUPER,L,exec,swaylock
    bind=SUPER,O,exec,wl-ocr
    
    # Media keys
    bind=,XF86AudioPlay,exec,playerctl play-pause
    bind=,XF86AudioPrev,exec,playerctl previous
    bind=,XF86AudioNext,exec,playerctl next
    bind=,XF86AudioRaiseVolume,exec,pulsemixer --change-volume +6
    bind=,XF86AudioLowerVolume,exec,pulsemixer --change-volume -6
    bind=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind=,XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bind=,XF86MonBrightnessUp,exec,light -A 5
    bind=,XF86MonBrightnessDown,exec,light -U 5
    
    # screenshot
    bind=,Print,exec,env XDG_CURRENT_DESKTOP="Sway" ${pkgs.flameshot}/bin/flameshot gui -p ~/Pictures/Screenshots
    bind=SHIFT,Print,exec,env XDG_CURRENT_DESKTOP="Sway" ${pkgs.flameshot}/bin/flameshot gui
    
    # monitor
    bind=CTRL,Print,exec,env XDG_CURRENT_DESKTOP="Sway" ${pkgs.flameshot}/bin/flameshot full -p ~/Pictures/Screenshots
    
    # color picker
    bind=SUPERSHIFT,C,exec,hyperpicker | wl-copy
    
    # move focus
    bind=SUPER,left,movefocus,l
    bind=SUPER,right,movefocus,r
    bind=SUPER,up,movefocus,u
    bind=SUPER,down,movefocus,d

    # workspace management
    bind=SUPER,1,workspace,1
    bind=SUPER,2,workspace,2
    bind=SUPER,3,workspace,3
    bind=SUPER,4,workspace,4
    bind=SUPER,5,workspace,5

    bind=SUPERSHIFT,1,movetoworkspace,1
    bind=SUPERSHIFT,2,movetoworkspace,2
    bind=SUPERSHIFT,3,movetoworkspace,3
    bind=SUPERSHIFT,4,movetoworkspace,4
    bind=SUPERSHIFT,5,movetoworkspace,5
    
    # scratchpad
    bind=SUPERSHIFT,grave,movetoworkspace,special
    bind=SUPER,grave,togglespecialworkspace,VGA-1
    
    # cycle workspaces
    bind=SUPERSHIFT,bracketleft,workspace,m-1
    bind=SUPERSHIFT,bracketright,workspace,m+1
  '';
in
  config