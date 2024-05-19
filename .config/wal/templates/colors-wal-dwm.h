static char norm_fg[] = "{color15}";
static char norm_bg[] = "{color0}";
static char norm_border[] = "{color8}";

static char sel_fg[] = "{color15}";
static char sel_bg[] = "{color2}";
static char sel_border[] = "{color15}";

static char urg_fg[] = "{color15}";
static char urg_bg[] = "{color1}";
static char urg_border[] = "{color1}";

static const char *colors[][3]      = {{
    /*               fg           bg         border                         */
    [SchemeNorm] = {{ norm_fg,     norm_bg,   norm_border }}, // unfocused wins
    [SchemeSel]  = {{ sel_fg,      sel_bg,    sel_border }},  // the focused win
    [SchemeUrg] =  {{ urg_fg,      urg_bg,    urg_border }},
}};
