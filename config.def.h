static const char *host      = "localhost";
static const char *port      = "80";
static const char *servedir  = ".";
static const char *docindex  = "index.html";
static const char *user      = "nobody";
static const char *group     = "nogroup";

static int         listdirs  = 1;
static int         vhosts    = 0;

static const int   maxnprocs = 512;
#define HEADER_MAX 4096
#define FIELD_MAX  200

/* virtual hosts */
static struct {
	const char *name;
	const char *regex;
	const char *dir;
	const char *prefix;
	regex_t re;
} vhost[] = {
	/* canonical host    host regex                     directory         prefix */
	{ "example.org",     "^(www\\.)?example\\.org$",    "/example.org",   NULL   },
	{ "example.org",     "^old\\.example\\.org$",       "/",              "/old" },
};

/* target prefix mapping */
static const struct {
	const char *vhost;
	const char *from;
	const char *to;
} map[] = {
	/* canonical host    from                   to                 */
	{ "example.org",     "/old/path/to/dir",    "/new/path/to/dir" },
};

/* mime-types */
static const struct {
	char *ext;
	char *type;
} mimes[] = {
	{ "xml",   "application/xml" },
	{ "xhtml", "application/xhtml+xml" },
	{ "html",  "text/html; charset=UTF-8" },
	{ "htm",   "text/html; charset=UTF-8" },
	{ "css",   "text/css" },
	{ "txt",   "text/plain" },
	{ "md",    "text/plain" },
	{ "c",     "text/plain" },
	{ "h",     "text/plain" },
	{ "gz",    "application/x-gtar" },
	{ "tar",   "application/tar" },
	{ "pdf",   "application/x-pdf" },
	{ "png",   "image/png" },
	{ "gif",   "image/gif" },
	{ "jpeg",  "image/jpg" },
	{ "jpg",   "image/jpg" },
	{ "iso",   "application/x-iso9660-image" },
	{ "webp",  "image/webp" },
	{ "svg",   "image/svg+xml" },
	{ "flac",  "audio/flac" },
	{ "mp3",   "audio/mpeg" },
	{ "ogg",   "audio/ogg" },
	{ "mp4",   "video/mp4" },
	{ "ogv",   "video/ogg" },
	{ "webm",  "video/webm" },
};
