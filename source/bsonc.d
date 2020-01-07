




        import core.stdc.config;

        import core.stdc.stdarg: va_list;

        static import core.simd;

        static import std.conv;



        struct Int128 { long lower; long upper; }

        struct UInt128 { ulong lower; ulong upper; }



        struct __locale_data { int dummy; }




alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }


    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    static const(char)* bcon_ensure_const_char_ptr(const(char)*) @nogc nothrow;
    static const(char)** bcon_ensure_const_char_ptr_ptr(const(char)**) @nogc nothrow;
    static double bcon_ensure_double(double) @nogc nothrow;
    static double* bcon_ensure_double_ptr(double*) @nogc nothrow;
    static const(_bson_t)* bcon_ensure_const_bson_ptr(const(_bson_t)*) @nogc nothrow;
    static _bson_t* bcon_ensure_bson_ptr(_bson_t*) @nogc nothrow;
    static bson_subtype_t bcon_ensure_subtype(bson_subtype_t) @nogc nothrow;
    static bson_subtype_t* bcon_ensure_subtype_ptr(bson_subtype_t*) @nogc nothrow;
    static const(ubyte)* bcon_ensure_const_uint8_ptr(const(ubyte)*) @nogc nothrow;
    static const(ubyte)** bcon_ensure_const_uint8_ptr_ptr(const(ubyte)**) @nogc nothrow;
    static uint bcon_ensure_uint32(uint) @nogc nothrow;
    static uint* bcon_ensure_uint32_ptr(uint*) @nogc nothrow;
    static const(bson_oid_t)* bcon_ensure_const_oid_ptr(const(bson_oid_t)*) @nogc nothrow;
    static const(bson_oid_t)** bcon_ensure_const_oid_ptr_ptr(const(bson_oid_t)**) @nogc nothrow;
    static int bcon_ensure_int32(int) @nogc nothrow;
    static int* bcon_ensure_int32_ptr(int*) @nogc nothrow;
    static long bcon_ensure_int64(long) @nogc nothrow;
    static long* bcon_ensure_int64_ptr(long*) @nogc nothrow;
    static const(bson_decimal128_t)* bcon_ensure_const_decimal128_ptr(const(bson_decimal128_t)*) @nogc nothrow;
    static byte bcon_ensure_bool(byte) @nogc nothrow;
    static byte* bcon_ensure_bool_ptr(byte*) @nogc nothrow;
    static bson_type_t bcon_ensure_bson_type(bson_type_t) @nogc nothrow;
    static bson_iter_t* bcon_ensure_bson_iter_ptr(bson_iter_t*) @nogc nothrow;
    static const(bson_iter_t)* bcon_ensure_const_bson_iter_ptr(const(bson_iter_t)*) @nogc nothrow;
    alias bcon_type_t = _Anonymous_0;
    enum _Anonymous_0
    {
        BCON_TYPE_UTF8 = 0,
        BCON_TYPE_DOUBLE = 1,
        BCON_TYPE_DOCUMENT = 2,
        BCON_TYPE_ARRAY = 3,
        BCON_TYPE_BIN = 4,
        BCON_TYPE_UNDEFINED = 5,
        BCON_TYPE_OID = 6,
        BCON_TYPE_BOOL = 7,
        BCON_TYPE_DATE_TIME = 8,
        BCON_TYPE_NULL = 9,
        BCON_TYPE_REGEX = 10,
        BCON_TYPE_DBPOINTER = 11,
        BCON_TYPE_CODE = 12,
        BCON_TYPE_SYMBOL = 13,
        BCON_TYPE_CODEWSCOPE = 14,
        BCON_TYPE_INT32 = 15,
        BCON_TYPE_TIMESTAMP = 16,
        BCON_TYPE_INT64 = 17,
        BCON_TYPE_DECIMAL128 = 18,
        BCON_TYPE_MAXKEY = 19,
        BCON_TYPE_MINKEY = 20,
        BCON_TYPE_BCON = 21,
        BCON_TYPE_ARRAY_START = 22,
        BCON_TYPE_ARRAY_END = 23,
        BCON_TYPE_DOC_START = 24,
        BCON_TYPE_DOC_END = 25,
        BCON_TYPE_END = 26,
        BCON_TYPE_RAW = 27,
        BCON_TYPE_SKIP = 28,
        BCON_TYPE_ITER = 29,
        BCON_TYPE_ERROR = 30,
    }
    enum BCON_TYPE_UTF8 = _Anonymous_0.BCON_TYPE_UTF8;
    enum BCON_TYPE_DOUBLE = _Anonymous_0.BCON_TYPE_DOUBLE;
    enum BCON_TYPE_DOCUMENT = _Anonymous_0.BCON_TYPE_DOCUMENT;
    enum BCON_TYPE_ARRAY = _Anonymous_0.BCON_TYPE_ARRAY;
    enum BCON_TYPE_BIN = _Anonymous_0.BCON_TYPE_BIN;
    enum BCON_TYPE_UNDEFINED = _Anonymous_0.BCON_TYPE_UNDEFINED;
    enum BCON_TYPE_OID = _Anonymous_0.BCON_TYPE_OID;
    enum BCON_TYPE_BOOL = _Anonymous_0.BCON_TYPE_BOOL;
    enum BCON_TYPE_DATE_TIME = _Anonymous_0.BCON_TYPE_DATE_TIME;
    enum BCON_TYPE_NULL = _Anonymous_0.BCON_TYPE_NULL;
    enum BCON_TYPE_REGEX = _Anonymous_0.BCON_TYPE_REGEX;
    enum BCON_TYPE_DBPOINTER = _Anonymous_0.BCON_TYPE_DBPOINTER;
    enum BCON_TYPE_CODE = _Anonymous_0.BCON_TYPE_CODE;
    enum BCON_TYPE_SYMBOL = _Anonymous_0.BCON_TYPE_SYMBOL;
    enum BCON_TYPE_CODEWSCOPE = _Anonymous_0.BCON_TYPE_CODEWSCOPE;
    enum BCON_TYPE_INT32 = _Anonymous_0.BCON_TYPE_INT32;
    enum BCON_TYPE_TIMESTAMP = _Anonymous_0.BCON_TYPE_TIMESTAMP;
    enum BCON_TYPE_INT64 = _Anonymous_0.BCON_TYPE_INT64;
    enum BCON_TYPE_DECIMAL128 = _Anonymous_0.BCON_TYPE_DECIMAL128;
    enum BCON_TYPE_MAXKEY = _Anonymous_0.BCON_TYPE_MAXKEY;
    enum BCON_TYPE_MINKEY = _Anonymous_0.BCON_TYPE_MINKEY;
    enum BCON_TYPE_BCON = _Anonymous_0.BCON_TYPE_BCON;
    enum BCON_TYPE_ARRAY_START = _Anonymous_0.BCON_TYPE_ARRAY_START;
    enum BCON_TYPE_ARRAY_END = _Anonymous_0.BCON_TYPE_ARRAY_END;
    enum BCON_TYPE_DOC_START = _Anonymous_0.BCON_TYPE_DOC_START;
    enum BCON_TYPE_DOC_END = _Anonymous_0.BCON_TYPE_DOC_END;
    enum BCON_TYPE_END = _Anonymous_0.BCON_TYPE_END;
    enum BCON_TYPE_RAW = _Anonymous_0.BCON_TYPE_RAW;
    enum BCON_TYPE_SKIP = _Anonymous_0.BCON_TYPE_SKIP;
    enum BCON_TYPE_ITER = _Anonymous_0.BCON_TYPE_ITER;
    enum BCON_TYPE_ERROR = _Anonymous_0.BCON_TYPE_ERROR;
    alias bcon_append_ctx_frame_t = bcon_append_ctx_frame;
    struct bcon_append_ctx_frame
    {
        int i;
        byte is_array;
        _bson_t bson;
    }
    alias bcon_extract_ctx_frame_t = bcon_extract_ctx_frame;
    struct bcon_extract_ctx_frame
    {
        int i;
        byte is_array;
        bson_iter_t iter;
    }
    alias bcon_append_ctx_t = _bcon_append_ctx_t;
    struct _bcon_append_ctx_t
    {
        bcon_append_ctx_frame[100] stack;
        int n;
    }
    alias bcon_extract_ctx_t = _bcon_extract_ctx_t;
    struct _bcon_extract_ctx_t
    {
        bcon_extract_ctx_frame[100] stack;
        int n;
    }
    void bcon_append(_bson_t*, ...) @nogc nothrow;
    void bcon_append_ctx(_bson_t*, _bcon_append_ctx_t*, ...) @nogc nothrow;
    void bcon_append_ctx_va(_bson_t*, _bcon_append_ctx_t*, char**) @nogc nothrow;
    void bcon_append_ctx_init(_bcon_append_ctx_t*) @nogc nothrow;
    void bcon_extract_ctx_init(_bcon_extract_ctx_t*) @nogc nothrow;
    void bcon_extract_ctx(_bson_t*, _bcon_extract_ctx_t*, ...) @nogc nothrow;
    byte bcon_extract_ctx_va(_bson_t*, _bcon_extract_ctx_t*, char**) @nogc nothrow;
    byte bcon_extract(_bson_t*, ...) @nogc nothrow;
    byte bcon_extract_va(_bson_t*, _bcon_extract_ctx_t*, ...) @nogc nothrow;
    _bson_t* bcon_new(void*, ...) @nogc nothrow;
    const(char)* bson_bcon_magic() @nogc nothrow;
    const(char)* bson_bcone_magic() @nogc nothrow;
    long bson_get_monotonic_time() @nogc nothrow;
    int bson_gettimeofday(timeval*) @nogc nothrow;
    alias ssize_t = long;
    alias bool_ = byte;
    _bson_context_t* bson_context_new(bson_context_flags_t) @nogc nothrow;
    void bson_context_destroy(_bson_context_t*) @nogc nothrow;
    _bson_context_t* bson_context_get_default() @nogc nothrow;
    void bson_decimal128_to_string(const(bson_decimal128_t)*, char*) @nogc nothrow;
    byte bson_decimal128_from_string(const(char)*, bson_decimal128_t*) @nogc nothrow;
    byte bson_decimal128_from_string_w_len(const(char)*, int, bson_decimal128_t*) @nogc nothrow;
    static ushort __bson_uint16_swap_slow(ushort) @nogc nothrow;
    static uint __bson_uint32_swap_slow(uint) @nogc nothrow;
    static ulong __bson_uint64_swap_slow(ulong) @nogc nothrow;
    alias static_assert_test_210sizeof_uint64_t = char[1];
    static double __bson_double_swap_slow(double) @nogc nothrow;
    void bson_set_error(_bson_error_t*, uint, uint, const(char)*, ...) @nogc nothrow;
    char* bson_strerror_r(int, char*, ulong) @nogc nothrow;
    const(_bson_value_t)* bson_iter_value(bson_iter_t*) @nogc nothrow;
    static uint bson_iter_utf8_len_unsafe(const(bson_iter_t)*) @nogc nothrow;
    void bson_iter_array(const(bson_iter_t)*, uint*, const(ubyte)**) @nogc nothrow;
    void bson_iter_binary(const(bson_iter_t)*, bson_subtype_t*, uint*, const(ubyte)**) @nogc nothrow;
    const(char)* bson_iter_code(const(bson_iter_t)*, uint*) @nogc nothrow;
    static const(char)* bson_iter_code_unsafe(const(bson_iter_t)*, uint*) @nogc nothrow;
    const(char)* bson_iter_codewscope(const(bson_iter_t)*, uint*, uint*, const(ubyte)**) @nogc nothrow;
    void bson_iter_dbpointer(const(bson_iter_t)*, uint*, const(char)**, const(bson_oid_t)**) @nogc nothrow;
    void bson_iter_document(const(bson_iter_t)*, uint*, const(ubyte)**) @nogc nothrow;
    double bson_iter_double(const(bson_iter_t)*) @nogc nothrow;
    double bson_iter_as_double(const(bson_iter_t)*) @nogc nothrow;
    static double bson_iter_double_unsafe(const(bson_iter_t)*) @nogc nothrow;
    byte bson_iter_init(bson_iter_t*, const(_bson_t)*) @nogc nothrow;
    byte bson_iter_init_from_data(bson_iter_t*, const(ubyte)*, ulong) @nogc nothrow;
    byte bson_iter_init_find(bson_iter_t*, const(_bson_t)*, const(char)*) @nogc nothrow;
    byte bson_iter_init_find_w_len(bson_iter_t*, const(_bson_t)*, const(char)*, int) @nogc nothrow;
    byte bson_iter_init_find_case(bson_iter_t*, const(_bson_t)*, const(char)*) @nogc nothrow;
    byte bson_iter_init_from_data_at_offset(bson_iter_t*, const(ubyte)*, ulong, uint, uint) @nogc nothrow;
    int bson_iter_int32(const(bson_iter_t)*) @nogc nothrow;
    static int bson_iter_int32_unsafe(const(bson_iter_t)*) @nogc nothrow;
    long bson_iter_int64(const(bson_iter_t)*) @nogc nothrow;
    long bson_iter_as_int64(const(bson_iter_t)*) @nogc nothrow;
    static long bson_iter_int64_unsafe(const(bson_iter_t)*) @nogc nothrow;
    byte bson_iter_find(bson_iter_t*, const(char)*) @nogc nothrow;
    byte bson_iter_find_w_len(bson_iter_t*, const(char)*, int) @nogc nothrow;
    byte bson_iter_find_case(bson_iter_t*, const(char)*) @nogc nothrow;
    byte bson_iter_find_descendant(bson_iter_t*, const(char)*, bson_iter_t*) @nogc nothrow;
    byte bson_iter_next(bson_iter_t*) @nogc nothrow;
    const(bson_oid_t)* bson_iter_oid(const(bson_iter_t)*) @nogc nothrow;
    static const(bson_oid_t)* bson_iter_oid_unsafe(const(bson_iter_t)*) @nogc nothrow;
    byte bson_iter_decimal128(const(bson_iter_t)*, bson_decimal128_t*) @nogc nothrow;
    static void bson_iter_decimal128_unsafe(const(bson_iter_t)*, bson_decimal128_t*) @nogc nothrow;
    const(char)* bson_iter_key(const(bson_iter_t)*) @nogc nothrow;
    uint bson_iter_key_len(const(bson_iter_t)*) @nogc nothrow;
    static const(char)* bson_iter_key_unsafe(const(bson_iter_t)*) @nogc nothrow;
    const(char)* bson_iter_utf8(const(bson_iter_t)*, uint*) @nogc nothrow;
    static const(char)* bson_iter_utf8_unsafe(const(bson_iter_t)*, ulong*) @nogc nothrow;
    char* bson_iter_dup_utf8(const(bson_iter_t)*, uint*) @nogc nothrow;
    long bson_iter_date_time(const(bson_iter_t)*) @nogc nothrow;
    long bson_iter_time_t(const(bson_iter_t)*) @nogc nothrow;
    static long bson_iter_time_t_unsafe(const(bson_iter_t)*) @nogc nothrow;
    void bson_iter_timeval(const(bson_iter_t)*, timeval*) @nogc nothrow;
    static void bson_iter_timeval_unsafe(const(bson_iter_t)*, timeval*) @nogc nothrow;
    void bson_iter_timestamp(const(bson_iter_t)*, uint*, uint*) @nogc nothrow;
    byte bson_iter_bool(const(bson_iter_t)*) @nogc nothrow;
    static byte bson_iter_bool_unsafe(const(bson_iter_t)*) @nogc nothrow;
    byte bson_iter_as_bool(const(bson_iter_t)*) @nogc nothrow;
    const(char)* bson_iter_regex(const(bson_iter_t)*, const(char)**) @nogc nothrow;
    const(char)* bson_iter_symbol(const(bson_iter_t)*, uint*) @nogc nothrow;
    bson_type_t bson_iter_type(const(bson_iter_t)*) @nogc nothrow;
    static bson_type_t bson_iter_type_unsafe(const(bson_iter_t)*) @nogc nothrow;
    byte bson_iter_recurse(const(bson_iter_t)*, bson_iter_t*) @nogc nothrow;
    void bson_iter_overwrite_int32(bson_iter_t*, int) @nogc nothrow;
    void bson_iter_overwrite_int64(bson_iter_t*, long) @nogc nothrow;
    void bson_iter_overwrite_double(bson_iter_t*, double) @nogc nothrow;
    void bson_iter_overwrite_decimal128(bson_iter_t*, const(bson_decimal128_t)*) @nogc nothrow;
    void bson_iter_overwrite_bool(bson_iter_t*, byte) @nogc nothrow;
    void bson_iter_overwrite_oid(bson_iter_t*, const(bson_oid_t)*) @nogc nothrow;
    void bson_iter_overwrite_timestamp(bson_iter_t*, uint, uint) @nogc nothrow;
    void bson_iter_overwrite_date_time(bson_iter_t*, long) @nogc nothrow;
    byte bson_iter_visit_all(bson_iter_t*, const(bson_visitor_t)*, void*) @nogc nothrow;
    uint bson_iter_offset(bson_iter_t*) @nogc nothrow;
    alias bson_json_reader_t = _bson_json_reader_t;
    struct _bson_json_reader_t;
    alias bson_json_error_code_t = _Anonymous_1;
    enum _Anonymous_1
    {
        BSON_JSON_ERROR_READ_CORRUPT_JS = 1,
        BSON_JSON_ERROR_READ_INVALID_PARAM = 2,
        BSON_JSON_ERROR_READ_CB_FAILURE = 3,
    }
    enum BSON_JSON_ERROR_READ_CORRUPT_JS = _Anonymous_1.BSON_JSON_ERROR_READ_CORRUPT_JS;
    enum BSON_JSON_ERROR_READ_INVALID_PARAM = _Anonymous_1.BSON_JSON_ERROR_READ_INVALID_PARAM;
    enum BSON_JSON_ERROR_READ_CB_FAILURE = _Anonymous_1.BSON_JSON_ERROR_READ_CB_FAILURE;
    alias bson_json_reader_cb = long function(void*, ubyte*, ulong);
    alias bson_json_destroy_cb = void function(void*);
    _bson_json_reader_t* bson_json_reader_new(void*, long function(void*, ubyte*, ulong), void function(void*), byte, ulong) @nogc nothrow;
    _bson_json_reader_t* bson_json_reader_new_from_fd(int, byte) @nogc nothrow;
    _bson_json_reader_t* bson_json_reader_new_from_file(const(char)*, _bson_error_t*) @nogc nothrow;
    void bson_json_reader_destroy(_bson_json_reader_t*) @nogc nothrow;
    int bson_json_reader_read(_bson_json_reader_t*, _bson_t*, _bson_error_t*) @nogc nothrow;
    _bson_json_reader_t* bson_json_data_reader_new(byte, ulong) @nogc nothrow;
    void bson_json_data_reader_ingest(_bson_json_reader_t*, const(ubyte)*, ulong) @nogc nothrow;
    ulong bson_uint32_to_string(uint, const(char)**, char*, ulong) @nogc nothrow;
    struct bson_md5_t
    {
        uint[2] count;
        uint[4] abcd;
        ubyte[64] buf;
    }
    void bson_md5_init(bson_md5_t*) @nogc nothrow;
    void bson_md5_append(bson_md5_t*, const(ubyte)*, uint) @nogc nothrow;
    void bson_md5_finish(bson_md5_t*, ubyte*) @nogc nothrow;
    alias bson_realloc_func = void* function(void*, ulong, void*);
    alias bson_mem_vtable_t = _bson_mem_vtable_t;
    struct _bson_mem_vtable_t
    {
        void* function(ulong) malloc;
        void* function(ulong, ulong) calloc;
        void* function(void*, ulong) realloc;
        void function(void*) free;
        void*[4] padding;
    }
    void bson_mem_set_vtable(const(_bson_mem_vtable_t)*) @nogc nothrow;
    void bson_mem_restore_vtable() @nogc nothrow;
    void* bson_malloc(ulong) @nogc nothrow;
    void* bson_malloc0(ulong) @nogc nothrow;
    void* bson_realloc(void*, ulong) @nogc nothrow;
    void* bson_realloc_ctx(void*, ulong, void*) @nogc nothrow;
    void bson_free(void*) @nogc nothrow;
    void bson_zero_free(void*, ulong) @nogc nothrow;
    int bson_oid_compare(const(bson_oid_t)*, const(bson_oid_t)*) @nogc nothrow;
    void bson_oid_copy(const(bson_oid_t)*, bson_oid_t*) @nogc nothrow;
    byte bson_oid_equal(const(bson_oid_t)*, const(bson_oid_t)*) @nogc nothrow;
    byte bson_oid_is_valid(const(char)*, ulong) @nogc nothrow;
    long bson_oid_get_time_t(const(bson_oid_t)*) @nogc nothrow;
    uint bson_oid_hash(const(bson_oid_t)*) @nogc nothrow;
    void bson_oid_init(bson_oid_t*, _bson_context_t*) @nogc nothrow;
    void bson_oid_init_from_data(bson_oid_t*, const(ubyte)*) @nogc nothrow;
    void bson_oid_init_from_string(bson_oid_t*, const(char)*) @nogc nothrow;
    void bson_oid_init_sequence(bson_oid_t*, _bson_context_t*) @nogc nothrow;
    void bson_oid_to_string(const(bson_oid_t)*, char*) @nogc nothrow;
    static int bson_oid_compare_unsafe(const(bson_oid_t)*, const(bson_oid_t)*) @nogc nothrow;
    static byte bson_oid_equal_unsafe(const(bson_oid_t)*, const(bson_oid_t)*) @nogc nothrow;
    static uint bson_oid_hash_unsafe(const(bson_oid_t)*) @nogc nothrow;
    static void bson_oid_copy_unsafe(const(bson_oid_t)*, bson_oid_t*) @nogc nothrow;
    static ubyte bson_oid_parse_hex_char(char) @nogc nothrow;
    static void bson_oid_init_from_string_unsafe(bson_oid_t*, const(char)*) @nogc nothrow;
    static long bson_oid_get_time_t_unsafe(const(bson_oid_t)*) @nogc nothrow;
    alias bson_reader_read_func_t = long function(void*, void*, ulong);
    alias bson_reader_destroy_func_t = void function(void*);
    bson_reader_t* bson_reader_new_from_handle(void*, long function(void*, void*, ulong), void function(void*)) @nogc nothrow;
    bson_reader_t* bson_reader_new_from_fd(int, byte) @nogc nothrow;
    bson_reader_t* bson_reader_new_from_file(const(char)*, _bson_error_t*) @nogc nothrow;
    bson_reader_t* bson_reader_new_from_data(const(ubyte)*, ulong) @nogc nothrow;
    void bson_reader_destroy(bson_reader_t*) @nogc nothrow;
    void bson_reader_set_read_func(bson_reader_t*, long function(void*, void*, ulong)) @nogc nothrow;
    void bson_reader_set_destroy_func(bson_reader_t*, void function(void*)) @nogc nothrow;
    const(_bson_t)* bson_reader_read(bson_reader_t*, byte*) @nogc nothrow;
    c_long bson_reader_tell(bson_reader_t*) @nogc nothrow;
    void bson_reader_reset(bson_reader_t*) @nogc nothrow;
    struct bson_string_t
    {
        char* str;
        uint len;
        uint alloc;
    }
    bson_string_t* bson_string_new(const(char)*) @nogc nothrow;
    char* bson_string_free(bson_string_t*, byte) @nogc nothrow;
    void bson_string_append(bson_string_t*, const(char)*) @nogc nothrow;
    void bson_string_append_c(bson_string_t*, char) @nogc nothrow;
    void bson_string_append_unichar(bson_string_t*, uint) @nogc nothrow;
    void bson_string_append_printf(bson_string_t*, const(char)*, ...) @nogc nothrow;
    void bson_string_truncate(bson_string_t*, uint) @nogc nothrow;
    char* bson_strdup(const(char)*) @nogc nothrow;
    char* bson_strdup_printf(const(char)*, ...) @nogc nothrow;
    char* bson_strdupv_printf(const(char)*, char*) @nogc nothrow;
    char* bson_strndup(const(char)*, ulong) @nogc nothrow;
    void bson_strncpy(char*, const(char)*, ulong) @nogc nothrow;
    int bson_vsnprintf(char*, ulong, const(char)*, char*) @nogc nothrow;
    int bson_snprintf(char*, ulong, const(char)*, ...) @nogc nothrow;
    void bson_strfreev(char**) @nogc nothrow;
    ulong bson_strnlen(const(char)*, ulong) @nogc nothrow;
    long bson_ascii_strtoll(const(char)*, char**, int) @nogc nothrow;
    int bson_strcasecmp(const(char)*, const(char)*) @nogc nothrow;
    alias bson_unichar_t = uint;
    alias bson_context_flags_t = _Anonymous_2;
    enum _Anonymous_2
    {
        BSON_CONTEXT_NONE = 0,
        BSON_CONTEXT_THREAD_SAFE = 1,
        BSON_CONTEXT_DISABLE_HOST_CACHE = 2,
        BSON_CONTEXT_DISABLE_PID_CACHE = 4,
    }
    enum BSON_CONTEXT_NONE = _Anonymous_2.BSON_CONTEXT_NONE;
    enum BSON_CONTEXT_THREAD_SAFE = _Anonymous_2.BSON_CONTEXT_THREAD_SAFE;
    enum BSON_CONTEXT_DISABLE_HOST_CACHE = _Anonymous_2.BSON_CONTEXT_DISABLE_HOST_CACHE;
    enum BSON_CONTEXT_DISABLE_PID_CACHE = _Anonymous_2.BSON_CONTEXT_DISABLE_PID_CACHE;
    alias bson_context_t = _bson_context_t;
    struct _bson_context_t;
    alias bson_t = _bson_t;
    struct _bson_t
    {
        uint flags;
        uint len;
        ubyte[120] padding;
    }
    alias static_assert_test_167bson_t = char[1];
    struct bson_oid_t
    {
        ubyte[12] bytes;
    }
    alias static_assert_test_181oid_t = char[1];
    struct bson_decimal128_t
    {
        ulong low;
        ulong high;
    }
    alias bson_validate_flags_t = _Anonymous_3;
    enum _Anonymous_3
    {
        BSON_VALIDATE_NONE = 0,
        BSON_VALIDATE_UTF8 = 1,
        BSON_VALIDATE_DOLLAR_KEYS = 2,
        BSON_VALIDATE_DOT_KEYS = 4,
        BSON_VALIDATE_UTF8_ALLOW_NULL = 8,
        BSON_VALIDATE_EMPTY_KEYS = 16,
    }
    enum BSON_VALIDATE_NONE = _Anonymous_3.BSON_VALIDATE_NONE;
    enum BSON_VALIDATE_UTF8 = _Anonymous_3.BSON_VALIDATE_UTF8;
    enum BSON_VALIDATE_DOLLAR_KEYS = _Anonymous_3.BSON_VALIDATE_DOLLAR_KEYS;
    enum BSON_VALIDATE_DOT_KEYS = _Anonymous_3.BSON_VALIDATE_DOT_KEYS;
    enum BSON_VALIDATE_UTF8_ALLOW_NULL = _Anonymous_3.BSON_VALIDATE_UTF8_ALLOW_NULL;
    enum BSON_VALIDATE_EMPTY_KEYS = _Anonymous_3.BSON_VALIDATE_EMPTY_KEYS;
    alias bson_type_t = _Anonymous_4;
    enum _Anonymous_4
    {
        BSON_TYPE_EOD = 0,
        BSON_TYPE_DOUBLE = 1,
        BSON_TYPE_UTF8 = 2,
        BSON_TYPE_DOCUMENT = 3,
        BSON_TYPE_ARRAY = 4,
        BSON_TYPE_BINARY = 5,
        BSON_TYPE_UNDEFINED = 6,
        BSON_TYPE_OID = 7,
        BSON_TYPE_BOOL = 8,
        BSON_TYPE_DATE_TIME = 9,
        BSON_TYPE_NULL = 10,
        BSON_TYPE_REGEX = 11,
        BSON_TYPE_DBPOINTER = 12,
        BSON_TYPE_CODE = 13,
        BSON_TYPE_SYMBOL = 14,
        BSON_TYPE_CODEWSCOPE = 15,
        BSON_TYPE_INT32 = 16,
        BSON_TYPE_TIMESTAMP = 17,
        BSON_TYPE_INT64 = 18,
        BSON_TYPE_DECIMAL128 = 19,
        BSON_TYPE_MAXKEY = 127,
        BSON_TYPE_MINKEY = 255,
    }
    enum BSON_TYPE_EOD = _Anonymous_4.BSON_TYPE_EOD;
    enum BSON_TYPE_DOUBLE = _Anonymous_4.BSON_TYPE_DOUBLE;
    enum BSON_TYPE_UTF8 = _Anonymous_4.BSON_TYPE_UTF8;
    enum BSON_TYPE_DOCUMENT = _Anonymous_4.BSON_TYPE_DOCUMENT;
    enum BSON_TYPE_ARRAY = _Anonymous_4.BSON_TYPE_ARRAY;
    enum BSON_TYPE_BINARY = _Anonymous_4.BSON_TYPE_BINARY;
    enum BSON_TYPE_UNDEFINED = _Anonymous_4.BSON_TYPE_UNDEFINED;
    enum BSON_TYPE_OID = _Anonymous_4.BSON_TYPE_OID;
    enum BSON_TYPE_BOOL = _Anonymous_4.BSON_TYPE_BOOL;
    enum BSON_TYPE_DATE_TIME = _Anonymous_4.BSON_TYPE_DATE_TIME;
    enum BSON_TYPE_NULL = _Anonymous_4.BSON_TYPE_NULL;
    enum BSON_TYPE_REGEX = _Anonymous_4.BSON_TYPE_REGEX;
    enum BSON_TYPE_DBPOINTER = _Anonymous_4.BSON_TYPE_DBPOINTER;
    enum BSON_TYPE_CODE = _Anonymous_4.BSON_TYPE_CODE;
    enum BSON_TYPE_SYMBOL = _Anonymous_4.BSON_TYPE_SYMBOL;
    enum BSON_TYPE_CODEWSCOPE = _Anonymous_4.BSON_TYPE_CODEWSCOPE;
    enum BSON_TYPE_INT32 = _Anonymous_4.BSON_TYPE_INT32;
    enum BSON_TYPE_TIMESTAMP = _Anonymous_4.BSON_TYPE_TIMESTAMP;
    enum BSON_TYPE_INT64 = _Anonymous_4.BSON_TYPE_INT64;
    enum BSON_TYPE_DECIMAL128 = _Anonymous_4.BSON_TYPE_DECIMAL128;
    enum BSON_TYPE_MAXKEY = _Anonymous_4.BSON_TYPE_MAXKEY;
    enum BSON_TYPE_MINKEY = _Anonymous_4.BSON_TYPE_MINKEY;
    alias bson_subtype_t = _Anonymous_5;
    enum _Anonymous_5
    {
        BSON_SUBTYPE_BINARY = 0,
        BSON_SUBTYPE_FUNCTION = 1,
        BSON_SUBTYPE_BINARY_DEPRECATED = 2,
        BSON_SUBTYPE_UUID_DEPRECATED = 3,
        BSON_SUBTYPE_UUID = 4,
        BSON_SUBTYPE_MD5 = 5,
        BSON_SUBTYPE_USER = 128,
    }
    enum BSON_SUBTYPE_BINARY = _Anonymous_5.BSON_SUBTYPE_BINARY;
    enum BSON_SUBTYPE_FUNCTION = _Anonymous_5.BSON_SUBTYPE_FUNCTION;
    enum BSON_SUBTYPE_BINARY_DEPRECATED = _Anonymous_5.BSON_SUBTYPE_BINARY_DEPRECATED;
    enum BSON_SUBTYPE_UUID_DEPRECATED = _Anonymous_5.BSON_SUBTYPE_UUID_DEPRECATED;
    enum BSON_SUBTYPE_UUID = _Anonymous_5.BSON_SUBTYPE_UUID;
    enum BSON_SUBTYPE_MD5 = _Anonymous_5.BSON_SUBTYPE_MD5;
    enum BSON_SUBTYPE_USER = _Anonymous_5.BSON_SUBTYPE_USER;
    alias bson_value_t = _bson_value_t;
    struct _bson_value_t
    {
        bson_type_t value_type;
        int padding;
        static union _Anonymous_6
        {
            bson_oid_t v_oid;
            long v_int64;
            int v_int32;
            byte v_int8;
            double v_double;
            byte v_bool;
            long v_datetime;
            static struct _Anonymous_7
            {
                uint timestamp;
                uint increment;
            }
            _Anonymous_7 v_timestamp;
            static struct _Anonymous_8
            {
                char* str;
                uint len;
            }
            _Anonymous_8 v_utf8;
            static struct _Anonymous_9
            {
                ubyte* data;
                uint data_len;
            }
            _Anonymous_9 v_doc;
            static struct _Anonymous_10
            {
                ubyte* data;
                uint data_len;
                bson_subtype_t subtype;
            }
            _Anonymous_10 v_binary;
            static struct _Anonymous_11
            {
                char* regex;
                char* options;
            }
            _Anonymous_11 v_regex;
            static struct _Anonymous_12
            {
                char* collection;
                uint collection_len;
                bson_oid_t oid;
            }
            _Anonymous_12 v_dbpointer;
            static struct _Anonymous_13
            {
                char* code;
                uint code_len;
            }
            _Anonymous_13 v_code;
            static struct _Anonymous_14
            {
                char* code;
                ubyte* scope_data;
                uint code_len;
                uint scope_len;
            }
            _Anonymous_14 v_codewscope;
            static struct _Anonymous_15
            {
                char* symbol;
                uint len;
            }
            _Anonymous_15 v_symbol;
            bson_decimal128_t v_decimal128;
        }
        _Anonymous_6 value;
    }
    struct bson_iter_t
    {
        const(ubyte)* raw;
        uint len;
        uint off;
        uint type;
        uint key;
        uint d1;
        uint d2;
        uint d3;
        uint d4;
        uint next_off;
        uint err_off;
        _bson_value_t value;
    }
    struct bson_reader_t
    {
        uint type;
    }
    struct bson_visitor_t
    {
        byte function(const(bson_iter_t)*, const(char)*, void*) visit_before;
        byte function(const(bson_iter_t)*, const(char)*, void*) visit_after;
        void function(const(bson_iter_t)*, void*) visit_corrupt;
        byte function(const(bson_iter_t)*, const(char)*, double, void*) visit_double;
        byte function(const(bson_iter_t)*, const(char)*, ulong, const(char)*, void*) visit_utf8;
        byte function(const(bson_iter_t)*, const(char)*, const(_bson_t)*, void*) visit_document;
        byte function(const(bson_iter_t)*, const(char)*, const(_bson_t)*, void*) visit_array;
        byte function(const(bson_iter_t)*, const(char)*, bson_subtype_t, ulong, const(ubyte)*, void*) visit_binary;
        byte function(const(bson_iter_t)*, const(char)*, void*) visit_undefined;
        byte function(const(bson_iter_t)*, const(char)*, const(bson_oid_t)*, void*) visit_oid;
        byte function(const(bson_iter_t)*, const(char)*, byte, void*) visit_bool;
        byte function(const(bson_iter_t)*, const(char)*, long, void*) visit_date_time;
        byte function(const(bson_iter_t)*, const(char)*, void*) visit_null;
        byte function(const(bson_iter_t)*, const(char)*, const(char)*, const(char)*, void*) visit_regex;
        byte function(const(bson_iter_t)*, const(char)*, ulong, const(char)*, const(bson_oid_t)*, void*) visit_dbpointer;
        byte function(const(bson_iter_t)*, const(char)*, ulong, const(char)*, void*) visit_code;
        byte function(const(bson_iter_t)*, const(char)*, ulong, const(char)*, void*) visit_symbol;
        byte function(const(bson_iter_t)*, const(char)*, ulong, const(char)*, const(_bson_t)*, void*) visit_codewscope;
        byte function(const(bson_iter_t)*, const(char)*, int, void*) visit_int32;
        byte function(const(bson_iter_t)*, const(char)*, uint, uint, void*) visit_timestamp;
        byte function(const(bson_iter_t)*, const(char)*, long, void*) visit_int64;
        byte function(const(bson_iter_t)*, const(char)*, void*) visit_maxkey;
        byte function(const(bson_iter_t)*, const(char)*, void*) visit_minkey;
        void function(const(bson_iter_t)*, const(char)*, uint, void*) visit_unsupported_type;
        byte function(const(bson_iter_t)*, const(char)*, const(bson_decimal128_t)*, void*) visit_decimal128;
        void*[7] padding;
    }
    alias bson_error_t = _bson_error_t;
    struct _bson_error_t
    {
        uint domain;
        uint code;
        char[504] message;
    }
    alias static_assert_test_522error_t = char[1];
    static ulong bson_next_power_of_two(ulong) @nogc nothrow;
    static byte bson_is_power_of_two(uint) @nogc nothrow;
    byte bson_utf8_validate(const(char)*, ulong, byte) @nogc nothrow;
    char* bson_utf8_escape_for_json(const(char)*, long) @nogc nothrow;
    uint bson_utf8_get_char(const(char)*) @nogc nothrow;
    const(char)* bson_utf8_next_char(const(char)*) @nogc nothrow;
    void bson_utf8_from_unichar(uint, char*, uint*) @nogc nothrow;
    void bson_value_copy(const(_bson_value_t)*, _bson_value_t*) @nogc nothrow;
    void bson_value_destroy(_bson_value_t*) @nogc nothrow;
    int bson_get_major_version() @nogc nothrow;
    int bson_get_minor_version() @nogc nothrow;
    int bson_get_micro_version() @nogc nothrow;
    const(char)* bson_get_version() @nogc nothrow;
    byte bson_check_version(int, int, int) @nogc nothrow;
    alias bson_writer_t = _bson_writer_t;
    struct _bson_writer_t;
    _bson_writer_t* bson_writer_new(ubyte**, ulong*, ulong, void* function(void*, ulong, void*), void*) @nogc nothrow;
    void bson_writer_destroy(_bson_writer_t*) @nogc nothrow;
    ulong bson_writer_get_length(_bson_writer_t*) @nogc nothrow;
    byte bson_writer_begin(_bson_writer_t*, _bson_t**) @nogc nothrow;
    void bson_writer_end(_bson_writer_t*) @nogc nothrow;
    void bson_writer_rollback(_bson_writer_t*) @nogc nothrow;
    _bson_t* bson_new() @nogc nothrow;
    _bson_t* bson_new_from_json(const(ubyte)*, long, _bson_error_t*) @nogc nothrow;
    byte bson_init_from_json(_bson_t*, const(char)*, long, _bson_error_t*) @nogc nothrow;
    byte bson_init_static(_bson_t*, const(ubyte)*, ulong) @nogc nothrow;
    void bson_init(_bson_t*) @nogc nothrow;
    void bson_reinit(_bson_t*) @nogc nothrow;
    _bson_t* bson_new_from_data(const(ubyte)*, ulong) @nogc nothrow;
    _bson_t* bson_new_from_buffer(ubyte**, ulong*, void* function(void*, ulong, void*), void*) @nogc nothrow;
    _bson_t* bson_sized_new(ulong) @nogc nothrow;
    _bson_t* bson_copy(const(_bson_t)*) @nogc nothrow;
    void bson_copy_to(const(_bson_t)*, _bson_t*) @nogc nothrow;
    void bson_copy_to_excluding(const(_bson_t)*, _bson_t*, const(char)*, ...) @nogc nothrow;
    void bson_copy_to_excluding_noinit(const(_bson_t)*, _bson_t*, const(char)*, ...) @nogc nothrow;
    void bson_copy_to_excluding_noinit_va(const(_bson_t)*, _bson_t*, const(char)*, char*) @nogc nothrow;
    void bson_destroy(_bson_t*) @nogc nothrow;
    ubyte* bson_reserve_buffer(_bson_t*, uint) @nogc nothrow;
    byte bson_steal(_bson_t*, _bson_t*) @nogc nothrow;
    ubyte* bson_destroy_with_steal(_bson_t*, byte, uint*) @nogc nothrow;
    const(ubyte)* bson_get_data(const(_bson_t)*) @nogc nothrow;
    uint bson_count_keys(const(_bson_t)*) @nogc nothrow;
    byte bson_has_field(const(_bson_t)*, const(char)*) @nogc nothrow;
    int bson_compare(const(_bson_t)*, const(_bson_t)*) @nogc nothrow;
    byte bson_equal(const(_bson_t)*, const(_bson_t)*) @nogc nothrow;
    byte bson_validate(const(_bson_t)*, bson_validate_flags_t, ulong*) @nogc nothrow;
    byte bson_validate_with_error(const(_bson_t)*, bson_validate_flags_t, _bson_error_t*) @nogc nothrow;
    char* bson_as_canonical_extended_json(const(_bson_t)*, ulong*) @nogc nothrow;
    char* bson_as_json(const(_bson_t)*, ulong*) @nogc nothrow;
    char* bson_as_relaxed_extended_json(const(_bson_t)*, ulong*) @nogc nothrow;
    char* bson_array_as_json(const(_bson_t)*, ulong*) @nogc nothrow;
    byte bson_append_value(_bson_t*, const(char)*, int, const(_bson_value_t)*) @nogc nothrow;
    byte bson_append_array(_bson_t*, const(char)*, int, const(_bson_t)*) @nogc nothrow;
    byte bson_append_binary(_bson_t*, const(char)*, int, bson_subtype_t, const(ubyte)*, uint) @nogc nothrow;
    byte bson_append_bool(_bson_t*, const(char)*, int, byte) @nogc nothrow;
    byte bson_append_code(_bson_t*, const(char)*, int, const(char)*) @nogc nothrow;
    byte bson_append_code_with_scope(_bson_t*, const(char)*, int, const(char)*, const(_bson_t)*) @nogc nothrow;
    byte bson_append_dbpointer(_bson_t*, const(char)*, int, const(char)*, const(bson_oid_t)*) @nogc nothrow;
    byte bson_append_double(_bson_t*, const(char)*, int, double) @nogc nothrow;
    byte bson_append_document(_bson_t*, const(char)*, int, const(_bson_t)*) @nogc nothrow;
    byte bson_append_document_begin(_bson_t*, const(char)*, int, _bson_t*) @nogc nothrow;
    byte bson_append_document_end(_bson_t*, _bson_t*) @nogc nothrow;
    byte bson_append_array_begin(_bson_t*, const(char)*, int, _bson_t*) @nogc nothrow;
    byte bson_append_array_end(_bson_t*, _bson_t*) @nogc nothrow;
    byte bson_append_int32(_bson_t*, const(char)*, int, int) @nogc nothrow;
    byte bson_append_int64(_bson_t*, const(char)*, int, long) @nogc nothrow;
    byte bson_append_decimal128(_bson_t*, const(char)*, int, const(bson_decimal128_t)*) @nogc nothrow;
    byte bson_append_iter(_bson_t*, const(char)*, int, const(bson_iter_t)*) @nogc nothrow;
    byte bson_append_minkey(_bson_t*, const(char)*, int) @nogc nothrow;
    byte bson_append_maxkey(_bson_t*, const(char)*, int) @nogc nothrow;
    byte bson_append_null(_bson_t*, const(char)*, int) @nogc nothrow;
    byte bson_append_oid(_bson_t*, const(char)*, int, const(bson_oid_t)*) @nogc nothrow;
    byte bson_append_regex(_bson_t*, const(char)*, int, const(char)*, const(char)*) @nogc nothrow;
    byte bson_append_regex_w_len(_bson_t*, const(char)*, int, const(char)*, int, const(char)*) @nogc nothrow;
    byte bson_append_utf8(_bson_t*, const(char)*, int, const(char)*, int) @nogc nothrow;
    byte bson_append_symbol(_bson_t*, const(char)*, int, const(char)*, int) @nogc nothrow;
    byte bson_append_time_t(_bson_t*, const(char)*, int, long) @nogc nothrow;
    byte bson_append_timeval(_bson_t*, const(char)*, int, timeval*) @nogc nothrow;
    byte bson_append_date_time(_bson_t*, const(char)*, int, long) @nogc nothrow;
    byte bson_append_now_utc(_bson_t*, const(char)*, int) @nogc nothrow;
    byte bson_append_timestamp(_bson_t*, const(char)*, int, uint, uint) @nogc nothrow;
    byte bson_append_undefined(_bson_t*, const(char)*, int) @nogc nothrow;
    byte bson_concat(_bson_t*, const(_bson_t)*) @nogc nothrow;
    static if(!is(typeof(BSON_VERSION_S))) {
        enum BSON_VERSION_S = "1.15.1";
    }
    static if(!is(typeof(BSON_ERROR_BUFFER_SIZE))) {
        enum BSON_ERROR_BUFFER_SIZE = 504;
    }
    static if(!is(typeof(BSON_ERROR_READER_BADFD))) {
        enum BSON_ERROR_READER_BADFD = 1;
    }
    static if(!is(typeof(BSON_WORD_SIZE))) {
        enum BSON_WORD_SIZE = 32;
    }
    static if(!is(typeof(BSON_ALIGN_OF_PTR))) {
        enum BSON_ALIGN_OF_PTR = 8;
    }
    static if(!is(typeof(BSON_ERROR_INVALID))) {
        enum BSON_ERROR_INVALID = 3;
    }




    static if(!is(typeof(BSON_ERROR_READER))) {
        enum BSON_ERROR_READER = 2;
    }




    static if(!is(typeof(BSON_ERROR_JSON))) {
        enum BSON_ERROR_JSON = 1;
    }
    static if(!is(typeof(BSON_LITTLE_ENDIAN))) {
        enum BSON_LITTLE_ENDIAN = 1234;
    }




    static if(!is(typeof(BSON_BIG_ENDIAN))) {
        enum BSON_BIG_ENDIAN = 4321;
    }






    static if(!is(typeof(BSON_DECIMAL128_NAN))) {
        enum BSON_DECIMAL128_NAN = "NaN";
    }




    static if(!is(typeof(BSON_DECIMAL128_INF))) {
        enum BSON_DECIMAL128_INF = "Infinity";
    }




    static if(!is(typeof(BSON_DECIMAL128_STRING))) {
        enum BSON_DECIMAL128_STRING = 43;
    }
    static if(!is(typeof(BSON_HAVE_RAND_R))) {
        enum BSON_HAVE_RAND_R = 0;
    }




    static if(!is(typeof(BSON_HAVE_SYSCALL_TID))) {
        enum BSON_HAVE_SYSCALL_TID = 0;
    }




    static if(!is(typeof(BSON_EXTRA_ALIGN))) {
        enum BSON_EXTRA_ALIGN = 1;
    }




    static if(!is(typeof(BSON_HAVE_TIMESPEC))) {
        enum BSON_HAVE_TIMESPEC = 0;
    }




    static if(!is(typeof(BSON_HAVE_REALLOCF))) {
        enum BSON_HAVE_REALLOCF = 0;
    }




    static if(!is(typeof(BSON_HAVE_GMTIME_R))) {
        enum BSON_HAVE_GMTIME_R = 0;
    }




    static if(!is(typeof(BSON_HAVE_SNPRINTF))) {
        enum BSON_HAVE_SNPRINTF = 0;
    }




    static if(!is(typeof(BSON_HAVE_STRNLEN))) {
        enum BSON_HAVE_STRNLEN = 0;
    }




    static if(!is(typeof(BSON_HAVE_STRINGS_H))) {
        enum BSON_HAVE_STRINGS_H = 0;
    }




    static if(!is(typeof(BSON_HAVE_CLOCK_GETTIME))) {
        enum BSON_HAVE_CLOCK_GETTIME = 0;
    }




    static if(!is(typeof(BSON_HAVE_ATOMIC_64_ADD_AND_FETCH))) {
        enum BSON_HAVE_ATOMIC_64_ADD_AND_FETCH = 0;
    }




    static if(!is(typeof(BSON_HAVE_ATOMIC_32_ADD_AND_FETCH))) {
        enum BSON_HAVE_ATOMIC_32_ADD_AND_FETCH = 0;
    }




    static if(!is(typeof(BSON_OS))) {
        enum BSON_OS = 2;
    }




    static if(!is(typeof(BSON_HAVE_STDBOOL_H))) {
        enum BSON_HAVE_STDBOOL_H = 0;
    }




    static if(!is(typeof(BSON_BYTE_ORDER))) {
        enum BSON_BYTE_ORDER = 1234;
    }
    static if(!is(typeof(__bool_true_false_are_defined))) {
        enum __bool_true_false_are_defined = 1;
    }




    static if(!is(typeof(true_))) {
        enum true_ = 1;
    }




    static if(!is(typeof(false_))) {
        enum false_ = 0;
    }
    static if(!is(typeof(_WIN32_WINNT))) {
        enum _WIN32_WINNT = 0x0600;
    }
    static if(!is(typeof(BCON_STACK_MAX))) {
        enum BCON_STACK_MAX = 100;
    }


}


struct timeval;
