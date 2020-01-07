




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
    alias mongoc_apm_callbacks_t = _mongoc_apm_callbacks_t;
    struct _mongoc_apm_callbacks_t;
    alias mongoc_apm_command_started_t = _mongoc_apm_command_started_t;
    struct _mongoc_apm_command_started_t;
    alias mongoc_apm_command_succeeded_t = _mongoc_apm_command_succeeded_t;
    struct _mongoc_apm_command_succeeded_t;
    alias mongoc_apm_command_failed_t = _mongoc_apm_command_failed_t;
    struct _mongoc_apm_command_failed_t;
    alias mongoc_apm_server_changed_t = _mongoc_apm_server_changed_t;
    struct _mongoc_apm_server_changed_t;
    alias mongoc_apm_server_opening_t = _mongoc_apm_server_opening_t;
    struct _mongoc_apm_server_opening_t;
    alias mongoc_apm_server_closed_t = _mongoc_apm_server_closed_t;
    struct _mongoc_apm_server_closed_t;
    alias mongoc_apm_topology_changed_t = _mongoc_apm_topology_changed_t;
    struct _mongoc_apm_topology_changed_t;
    alias mongoc_apm_topology_opening_t = _mongoc_apm_topology_opening_t;
    struct _mongoc_apm_topology_opening_t;
    alias mongoc_apm_topology_closed_t = _mongoc_apm_topology_closed_t;
    struct _mongoc_apm_topology_closed_t;
    alias mongoc_apm_server_heartbeat_started_t = _mongoc_apm_server_heartbeat_started_t;
    struct _mongoc_apm_server_heartbeat_started_t;
    alias mongoc_apm_server_heartbeat_succeeded_t = _mongoc_apm_server_heartbeat_succeeded_t;
    struct _mongoc_apm_server_heartbeat_succeeded_t;
    alias mongoc_apm_server_heartbeat_failed_t = _mongoc_apm_server_heartbeat_failed_t;
    struct _mongoc_apm_server_heartbeat_failed_t;
    const(_bson_t)* mongoc_apm_command_started_get_command(const(_mongoc_apm_command_started_t)*) @nogc nothrow;
    const(char)* mongoc_apm_command_started_get_database_name(const(_mongoc_apm_command_started_t)*) @nogc nothrow;
    const(char)* mongoc_apm_command_started_get_command_name(const(_mongoc_apm_command_started_t)*) @nogc nothrow;
    long mongoc_apm_command_started_get_request_id(const(_mongoc_apm_command_started_t)*) @nogc nothrow;
    long mongoc_apm_command_started_get_operation_id(const(_mongoc_apm_command_started_t)*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_command_started_get_host(const(_mongoc_apm_command_started_t)*) @nogc nothrow;
    uint mongoc_apm_command_started_get_server_id(const(_mongoc_apm_command_started_t)*) @nogc nothrow;
    void* mongoc_apm_command_started_get_context(const(_mongoc_apm_command_started_t)*) @nogc nothrow;
    long mongoc_apm_command_succeeded_get_duration(const(_mongoc_apm_command_succeeded_t)*) @nogc nothrow;
    const(_bson_t)* mongoc_apm_command_succeeded_get_reply(const(_mongoc_apm_command_succeeded_t)*) @nogc nothrow;
    const(char)* mongoc_apm_command_succeeded_get_command_name(const(_mongoc_apm_command_succeeded_t)*) @nogc nothrow;
    long mongoc_apm_command_succeeded_get_request_id(const(_mongoc_apm_command_succeeded_t)*) @nogc nothrow;
    long mongoc_apm_command_succeeded_get_operation_id(const(_mongoc_apm_command_succeeded_t)*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_command_succeeded_get_host(const(_mongoc_apm_command_succeeded_t)*) @nogc nothrow;
    uint mongoc_apm_command_succeeded_get_server_id(const(_mongoc_apm_command_succeeded_t)*) @nogc nothrow;
    void* mongoc_apm_command_succeeded_get_context(const(_mongoc_apm_command_succeeded_t)*) @nogc nothrow;
    long mongoc_apm_command_failed_get_duration(const(_mongoc_apm_command_failed_t)*) @nogc nothrow;
    const(char)* mongoc_apm_command_failed_get_command_name(const(_mongoc_apm_command_failed_t)*) @nogc nothrow;
    void mongoc_apm_command_failed_get_error(const(_mongoc_apm_command_failed_t)*, _bson_error_t*) @nogc nothrow;
    const(_bson_t)* mongoc_apm_command_failed_get_reply(const(_mongoc_apm_command_failed_t)*) @nogc nothrow;
    long mongoc_apm_command_failed_get_request_id(const(_mongoc_apm_command_failed_t)*) @nogc nothrow;
    long mongoc_apm_command_failed_get_operation_id(const(_mongoc_apm_command_failed_t)*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_command_failed_get_host(const(_mongoc_apm_command_failed_t)*) @nogc nothrow;
    uint mongoc_apm_command_failed_get_server_id(const(_mongoc_apm_command_failed_t)*) @nogc nothrow;
    void* mongoc_apm_command_failed_get_context(const(_mongoc_apm_command_failed_t)*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_server_changed_get_host(const(_mongoc_apm_server_changed_t)*) @nogc nothrow;
    void mongoc_apm_server_changed_get_topology_id(const(_mongoc_apm_server_changed_t)*, bson_oid_t*) @nogc nothrow;
    const(_mongoc_server_description_t)* mongoc_apm_server_changed_get_previous_description(const(_mongoc_apm_server_changed_t)*) @nogc nothrow;
    const(_mongoc_server_description_t)* mongoc_apm_server_changed_get_new_description(const(_mongoc_apm_server_changed_t)*) @nogc nothrow;
    void* mongoc_apm_server_changed_get_context(const(_mongoc_apm_server_changed_t)*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_server_opening_get_host(const(_mongoc_apm_server_opening_t)*) @nogc nothrow;
    void mongoc_apm_server_opening_get_topology_id(const(_mongoc_apm_server_opening_t)*, bson_oid_t*) @nogc nothrow;
    void* mongoc_apm_server_opening_get_context(const(_mongoc_apm_server_opening_t)*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_server_closed_get_host(const(_mongoc_apm_server_closed_t)*) @nogc nothrow;
    void mongoc_apm_server_closed_get_topology_id(const(_mongoc_apm_server_closed_t)*, bson_oid_t*) @nogc nothrow;
    void* mongoc_apm_server_closed_get_context(const(_mongoc_apm_server_closed_t)*) @nogc nothrow;
    void mongoc_apm_topology_changed_get_topology_id(const(_mongoc_apm_topology_changed_t)*, bson_oid_t*) @nogc nothrow;
    const(_mongoc_topology_description_t)* mongoc_apm_topology_changed_get_previous_description(const(_mongoc_apm_topology_changed_t)*) @nogc nothrow;
    const(_mongoc_topology_description_t)* mongoc_apm_topology_changed_get_new_description(const(_mongoc_apm_topology_changed_t)*) @nogc nothrow;
    void* mongoc_apm_topology_changed_get_context(const(_mongoc_apm_topology_changed_t)*) @nogc nothrow;
    void mongoc_apm_topology_opening_get_topology_id(const(_mongoc_apm_topology_opening_t)*, bson_oid_t*) @nogc nothrow;
    void* mongoc_apm_topology_opening_get_context(const(_mongoc_apm_topology_opening_t)*) @nogc nothrow;
    void mongoc_apm_topology_closed_get_topology_id(const(_mongoc_apm_topology_closed_t)*, bson_oid_t*) @nogc nothrow;
    void* mongoc_apm_topology_closed_get_context(const(_mongoc_apm_topology_closed_t)*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_server_heartbeat_started_get_host(const(_mongoc_apm_server_heartbeat_started_t)*) @nogc nothrow;
    void* mongoc_apm_server_heartbeat_started_get_context(const(_mongoc_apm_server_heartbeat_started_t)*) @nogc nothrow;
    long mongoc_apm_server_heartbeat_succeeded_get_duration(const(_mongoc_apm_server_heartbeat_succeeded_t)*) @nogc nothrow;
    const(_bson_t)* mongoc_apm_server_heartbeat_succeeded_get_reply(const(_mongoc_apm_server_heartbeat_succeeded_t)*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_server_heartbeat_succeeded_get_host(const(_mongoc_apm_server_heartbeat_succeeded_t)*) @nogc nothrow;
    void* mongoc_apm_server_heartbeat_succeeded_get_context(const(_mongoc_apm_server_heartbeat_succeeded_t)*) @nogc nothrow;
    long mongoc_apm_server_heartbeat_failed_get_duration(const(_mongoc_apm_server_heartbeat_failed_t)*) @nogc nothrow;
    void mongoc_apm_server_heartbeat_failed_get_error(const(_mongoc_apm_server_heartbeat_failed_t)*, _bson_error_t*) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_apm_server_heartbeat_failed_get_host(const(_mongoc_apm_server_heartbeat_failed_t)*) @nogc nothrow;
    void* mongoc_apm_server_heartbeat_failed_get_context(const(_mongoc_apm_server_heartbeat_failed_t)*) @nogc nothrow;
    alias mongoc_apm_command_started_cb_t = void function(const(_mongoc_apm_command_started_t)*);
    alias mongoc_apm_command_succeeded_cb_t = void function(const(_mongoc_apm_command_succeeded_t)*);
    alias mongoc_apm_command_failed_cb_t = void function(const(_mongoc_apm_command_failed_t)*);
    alias mongoc_apm_server_changed_cb_t = void function(const(_mongoc_apm_server_changed_t)*);
    alias mongoc_apm_server_opening_cb_t = void function(const(_mongoc_apm_server_opening_t)*);
    alias mongoc_apm_server_closed_cb_t = void function(const(_mongoc_apm_server_closed_t)*);
    alias mongoc_apm_topology_changed_cb_t = void function(const(_mongoc_apm_topology_changed_t)*);
    alias mongoc_apm_topology_opening_cb_t = void function(const(_mongoc_apm_topology_opening_t)*);
    alias mongoc_apm_topology_closed_cb_t = void function(const(_mongoc_apm_topology_closed_t)*);
    alias mongoc_apm_server_heartbeat_started_cb_t = void function(const(_mongoc_apm_server_heartbeat_started_t)*);
    alias mongoc_apm_server_heartbeat_succeeded_cb_t = void function(const(_mongoc_apm_server_heartbeat_succeeded_t)*);
    alias mongoc_apm_server_heartbeat_failed_cb_t = void function(const(_mongoc_apm_server_heartbeat_failed_t)*);
    _mongoc_apm_callbacks_t* mongoc_apm_callbacks_new() @nogc nothrow;
    void mongoc_apm_callbacks_destroy(_mongoc_apm_callbacks_t*) @nogc nothrow;
    void mongoc_apm_set_command_started_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_command_started_t)*)) @nogc nothrow;
    void mongoc_apm_set_command_succeeded_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_command_succeeded_t)*)) @nogc nothrow;
    void mongoc_apm_set_command_failed_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_command_failed_t)*)) @nogc nothrow;
    void mongoc_apm_set_server_changed_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_server_changed_t)*)) @nogc nothrow;
    void mongoc_apm_set_server_opening_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_server_opening_t)*)) @nogc nothrow;
    void mongoc_apm_set_server_closed_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_server_closed_t)*)) @nogc nothrow;
    void mongoc_apm_set_topology_changed_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_topology_changed_t)*)) @nogc nothrow;
    void mongoc_apm_set_topology_opening_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_topology_opening_t)*)) @nogc nothrow;
    void mongoc_apm_set_topology_closed_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_topology_closed_t)*)) @nogc nothrow;
    void mongoc_apm_set_server_heartbeat_started_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_server_heartbeat_started_t)*)) @nogc nothrow;
    void mongoc_apm_set_server_heartbeat_succeeded_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_server_heartbeat_succeeded_t)*)) @nogc nothrow;
    void mongoc_apm_set_server_heartbeat_failed_cb(_mongoc_apm_callbacks_t*, void function(const(_mongoc_apm_server_heartbeat_failed_t)*)) @nogc nothrow;
    struct _mongoc_client_session_t;
    alias mongoc_bulk_operation_t = _mongoc_bulk_operation_t;
    struct _mongoc_bulk_operation_t;
    alias mongoc_bulk_write_flags_t = _mongoc_bulk_write_flags_t;
    struct _mongoc_bulk_write_flags_t;
    void mongoc_bulk_operation_destroy(_mongoc_bulk_operation_t*) @nogc nothrow;
    uint mongoc_bulk_operation_execute(_mongoc_bulk_operation_t*, _bson_t*, _bson_error_t*) @nogc nothrow;
    void mongoc_bulk_operation_delete(_mongoc_bulk_operation_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_bulk_operation_delete_one(_mongoc_bulk_operation_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_bulk_operation_insert(_mongoc_bulk_operation_t*, const(_bson_t)*) @nogc nothrow;
    byte mongoc_bulk_operation_insert_with_opts(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    void mongoc_bulk_operation_remove(_mongoc_bulk_operation_t*, const(_bson_t)*) @nogc nothrow;
    byte mongoc_bulk_operation_remove_many_with_opts(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    void mongoc_bulk_operation_remove_one(_mongoc_bulk_operation_t*, const(_bson_t)*) @nogc nothrow;
    byte mongoc_bulk_operation_remove_one_with_opts(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    void mongoc_bulk_operation_replace_one(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, byte) @nogc nothrow;
    byte mongoc_bulk_operation_replace_one_with_opts(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    void mongoc_bulk_operation_update(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, byte) @nogc nothrow;
    byte mongoc_bulk_operation_update_many_with_opts(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    void mongoc_bulk_operation_update_one(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, byte) @nogc nothrow;
    byte mongoc_bulk_operation_update_one_with_opts(_mongoc_bulk_operation_t*, const(_bson_t)*, const(_bson_t)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    void mongoc_bulk_operation_set_bypass_document_validation(_mongoc_bulk_operation_t*, byte) @nogc nothrow;
    _mongoc_bulk_operation_t* mongoc_bulk_operation_new(byte) @nogc nothrow;
    void mongoc_bulk_operation_set_write_concern(_mongoc_bulk_operation_t*, const(_mongoc_write_concern_t)*) @nogc nothrow;
    void mongoc_bulk_operation_set_database(_mongoc_bulk_operation_t*, const(char)*) @nogc nothrow;
    void mongoc_bulk_operation_set_collection(_mongoc_bulk_operation_t*, const(char)*) @nogc nothrow;
    void mongoc_bulk_operation_set_client(_mongoc_bulk_operation_t*, void*) @nogc nothrow;
    void mongoc_bulk_operation_set_client_session(_mongoc_bulk_operation_t*, _mongoc_client_session_t*) @nogc nothrow;
    void mongoc_bulk_operation_set_hint(_mongoc_bulk_operation_t*, uint) @nogc nothrow;
    uint mongoc_bulk_operation_get_hint(const(_mongoc_bulk_operation_t)*) @nogc nothrow;
    const(_mongoc_write_concern_t)* mongoc_bulk_operation_get_write_concern(const(_mongoc_bulk_operation_t)*) @nogc nothrow;
    alias mongoc_change_stream_t = _mongoc_change_stream_t;
    struct _mongoc_change_stream_t;
    void mongoc_change_stream_destroy(_mongoc_change_stream_t*) @nogc nothrow;
    const(_bson_t)* mongoc_change_stream_get_resume_token(_mongoc_change_stream_t*) @nogc nothrow;
    byte mongoc_change_stream_next(_mongoc_change_stream_t*, const(_bson_t)**) @nogc nothrow;
    byte mongoc_change_stream_error_document(const(_mongoc_change_stream_t)*, _bson_error_t*, const(_bson_t)**) @nogc nothrow;
    alias mongoc_client_pool_t = _mongoc_client_pool_t;
    struct _mongoc_client_pool_t;
    _mongoc_client_pool_t* mongoc_client_pool_new(const(_mongoc_uri_t)*) @nogc nothrow;
    void mongoc_client_pool_destroy(_mongoc_client_pool_t*) @nogc nothrow;
    _mongoc_client_t* mongoc_client_pool_pop(_mongoc_client_pool_t*) @nogc nothrow;
    void mongoc_client_pool_push(_mongoc_client_pool_t*, _mongoc_client_t*) @nogc nothrow;
    _mongoc_client_t* mongoc_client_pool_try_pop(_mongoc_client_pool_t*) @nogc nothrow;
    void mongoc_client_pool_max_size(_mongoc_client_pool_t*, uint) @nogc nothrow;
    void mongoc_client_pool_min_size(_mongoc_client_pool_t*, uint) @nogc nothrow;
    void mongoc_client_pool_set_ssl_opts(_mongoc_client_pool_t*, const(_mongoc_ssl_opt_t)*) @nogc nothrow;
    byte mongoc_client_pool_set_apm_callbacks(_mongoc_client_pool_t*, _mongoc_apm_callbacks_t*, void*) @nogc nothrow;
    byte mongoc_client_pool_set_error_api(_mongoc_client_pool_t*, int) @nogc nothrow;
    byte mongoc_client_pool_set_appname(_mongoc_client_pool_t*, const(char)*) @nogc nothrow;
    alias mongoc_client_session_with_transaction_cb_t = byte function(_mongoc_client_session_t*, void*, _bson_t**, _bson_error_t*);
    _mongoc_transaction_opt_t* mongoc_transaction_opts_new() @nogc nothrow;
    _mongoc_transaction_opt_t* mongoc_transaction_opts_clone(const(_mongoc_transaction_opt_t)*) @nogc nothrow;
    void mongoc_transaction_opts_destroy(_mongoc_transaction_opt_t*) @nogc nothrow;
    void mongoc_transaction_opts_set_max_commit_time_ms(_mongoc_transaction_opt_t*, long) @nogc nothrow;
    long mongoc_transaction_opts_get_max_commit_time_ms(_mongoc_transaction_opt_t*) @nogc nothrow;
    void mongoc_transaction_opts_set_read_concern(_mongoc_transaction_opt_t*, const(_mongoc_read_concern_t)*) @nogc nothrow;
    const(_mongoc_read_concern_t)* mongoc_transaction_opts_get_read_concern(const(_mongoc_transaction_opt_t)*) @nogc nothrow;
    void mongoc_transaction_opts_set_write_concern(_mongoc_transaction_opt_t*, const(_mongoc_write_concern_t)*) @nogc nothrow;
    const(_mongoc_write_concern_t)* mongoc_transaction_opts_get_write_concern(const(_mongoc_transaction_opt_t)*) @nogc nothrow;
    void mongoc_transaction_opts_set_read_prefs(_mongoc_transaction_opt_t*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    const(_mongoc_read_prefs_t)* mongoc_transaction_opts_get_read_prefs(const(_mongoc_transaction_opt_t)*) @nogc nothrow;
    _mongoc_session_opt_t* mongoc_session_opts_new() @nogc nothrow;
    void mongoc_session_opts_set_causal_consistency(_mongoc_session_opt_t*, byte) @nogc nothrow;
    byte mongoc_session_opts_get_causal_consistency(const(_mongoc_session_opt_t)*) @nogc nothrow;
    void mongoc_session_opts_set_default_transaction_opts(_mongoc_session_opt_t*, const(_mongoc_transaction_opt_t)*) @nogc nothrow;
    const(_mongoc_transaction_opt_t)* mongoc_session_opts_get_default_transaction_opts(const(_mongoc_session_opt_t)*) @nogc nothrow;
    _mongoc_session_opt_t* mongoc_session_opts_clone(const(_mongoc_session_opt_t)*) @nogc nothrow;
    void mongoc_session_opts_destroy(_mongoc_session_opt_t*) @nogc nothrow;
    _mongoc_client_t* mongoc_client_session_get_client(const(_mongoc_client_session_t)*) @nogc nothrow;
    const(_mongoc_session_opt_t)* mongoc_client_session_get_opts(const(_mongoc_client_session_t)*) @nogc nothrow;
    const(_bson_t)* mongoc_client_session_get_lsid(const(_mongoc_client_session_t)*) @nogc nothrow;
    const(_bson_t)* mongoc_client_session_get_cluster_time(const(_mongoc_client_session_t)*) @nogc nothrow;
    void mongoc_client_session_advance_cluster_time(_mongoc_client_session_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_client_session_get_operation_time(const(_mongoc_client_session_t)*, uint*, uint*) @nogc nothrow;
    uint mongoc_client_session_get_server_id(const(_mongoc_client_session_t)*) @nogc nothrow;
    void mongoc_client_session_advance_operation_time(_mongoc_client_session_t*, uint, uint) @nogc nothrow;
    byte mongoc_client_session_with_transaction(_mongoc_client_session_t*, byte function(_mongoc_client_session_t*, void*, _bson_t**, _bson_error_t*), const(_mongoc_transaction_opt_t)*, void*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_session_start_transaction(_mongoc_client_session_t*, const(_mongoc_transaction_opt_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_session_in_transaction(const(_mongoc_client_session_t)*) @nogc nothrow;
    byte mongoc_client_session_commit_transaction(_mongoc_client_session_t*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_session_abort_transaction(_mongoc_client_session_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_session_append(const(_mongoc_client_session_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    void mongoc_client_session_destroy(_mongoc_client_session_t*) @nogc nothrow;
    alias mongoc_client_t = _mongoc_client_t;
    alias mongoc_client_session_t = _mongoc_client_session_t;
    alias mongoc_session_opt_t = _mongoc_session_opt_t;
    struct _mongoc_session_opt_t;
    alias mongoc_transaction_opt_t = _mongoc_transaction_opt_t;
    struct _mongoc_transaction_opt_t;
    alias mongoc_stream_initiator_t = _mongoc_stream_t* function(const(_mongoc_uri_t)*, const(_mongoc_host_list_t)*, void*, _bson_error_t*);
    _mongoc_client_t* mongoc_client_new(const(char)*) @nogc nothrow;
    _mongoc_client_t* mongoc_client_new_from_uri(const(_mongoc_uri_t)*) @nogc nothrow;
    const(_mongoc_uri_t)* mongoc_client_get_uri(const(_mongoc_client_t)*) @nogc nothrow;
    void mongoc_client_set_stream_initiator(_mongoc_client_t*, _mongoc_stream_t* function(const(_mongoc_uri_t)*, const(_mongoc_host_list_t)*, void*, _bson_error_t*), void*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_client_command(_mongoc_client_t*, const(char)*, mongoc_query_flags_t, uint, uint, uint, const(_bson_t)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    void mongoc_client_kill_cursor(_mongoc_client_t*, long) @nogc nothrow;
    byte mongoc_client_command_simple(_mongoc_client_t*, const(char)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_read_command_with_opts(_mongoc_client_t*, const(char)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_write_command_with_opts(_mongoc_client_t*, const(char)*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_read_write_command_with_opts(_mongoc_client_t*, const(char)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_command_with_opts(_mongoc_client_t*, const(char)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_command_simple_with_server_id(_mongoc_client_t*, const(char)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, uint, _bson_t*, _bson_error_t*) @nogc nothrow;
    void mongoc_client_destroy(_mongoc_client_t*) @nogc nothrow;
    _mongoc_client_session_t* mongoc_client_start_session(_mongoc_client_t*, const(_mongoc_session_opt_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_database_t* mongoc_client_get_database(_mongoc_client_t*, const(char)*) @nogc nothrow;
    _mongoc_database_t* mongoc_client_get_default_database(_mongoc_client_t*) @nogc nothrow;
    _mongoc_gridfs_t* mongoc_client_get_gridfs(_mongoc_client_t*, const(char)*, const(char)*, _bson_error_t*) @nogc nothrow;
    _mongoc_collection_t* mongoc_client_get_collection(_mongoc_client_t*, const(char)*, const(char)*) @nogc nothrow;
    char** mongoc_client_get_database_names(_mongoc_client_t*, _bson_error_t*) @nogc nothrow;
    char** mongoc_client_get_database_names_with_opts(_mongoc_client_t*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_client_find_databases(_mongoc_client_t*, _bson_error_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_client_find_databases_with_opts(_mongoc_client_t*, const(_bson_t)*) @nogc nothrow;
    byte mongoc_client_get_server_status(_mongoc_client_t*, _mongoc_read_prefs_t*, _bson_t*, _bson_error_t*) @nogc nothrow;
    int mongoc_client_get_max_message_size(_mongoc_client_t*) @nogc nothrow;
    int mongoc_client_get_max_bson_size(_mongoc_client_t*) @nogc nothrow;
    const(_mongoc_write_concern_t)* mongoc_client_get_write_concern(const(_mongoc_client_t)*) @nogc nothrow;
    void mongoc_client_set_write_concern(_mongoc_client_t*, const(_mongoc_write_concern_t)*) @nogc nothrow;
    const(_mongoc_read_concern_t)* mongoc_client_get_read_concern(const(_mongoc_client_t)*) @nogc nothrow;
    void mongoc_client_set_read_concern(_mongoc_client_t*, const(_mongoc_read_concern_t)*) @nogc nothrow;
    const(_mongoc_read_prefs_t)* mongoc_client_get_read_prefs(const(_mongoc_client_t)*) @nogc nothrow;
    void mongoc_client_set_read_prefs(_mongoc_client_t*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    void mongoc_client_set_ssl_opts(_mongoc_client_t*, const(_mongoc_ssl_opt_t)*) @nogc nothrow;
    byte mongoc_client_set_apm_callbacks(_mongoc_client_t*, _mongoc_apm_callbacks_t*, void*) @nogc nothrow;
    _mongoc_server_description_t* mongoc_client_get_server_description(_mongoc_client_t*, uint) @nogc nothrow;
    _mongoc_server_description_t** mongoc_client_get_server_descriptions(const(_mongoc_client_t)*, ulong*) @nogc nothrow;
    void mongoc_server_descriptions_destroy_all(_mongoc_server_description_t**, ulong) @nogc nothrow;
    _mongoc_server_description_t* mongoc_client_select_server(_mongoc_client_t*, byte, const(_mongoc_read_prefs_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_client_set_error_api(_mongoc_client_t*, int) @nogc nothrow;
    byte mongoc_client_set_appname(_mongoc_client_t*, const(char)*) @nogc nothrow;
    _mongoc_change_stream_t* mongoc_client_watch(_mongoc_client_t*, const(_bson_t)*, const(_bson_t)*) @nogc nothrow;
    void mongoc_client_reset(_mongoc_client_t*) @nogc nothrow;
    alias mongoc_collection_t = _mongoc_collection_t;
    struct _mongoc_collection_t;
    _mongoc_cursor_t* mongoc_collection_aggregate(_mongoc_collection_t*, mongoc_query_flags_t, const(_bson_t)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    void mongoc_collection_destroy(_mongoc_collection_t*) @nogc nothrow;
    _mongoc_collection_t* mongoc_collection_copy(_mongoc_collection_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_collection_command(_mongoc_collection_t*, mongoc_query_flags_t, uint, uint, uint, const(_bson_t)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    byte mongoc_collection_read_command_with_opts(_mongoc_collection_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_write_command_with_opts(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_read_write_command_with_opts(_mongoc_collection_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_command_with_opts(_mongoc_collection_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_command_simple(_mongoc_collection_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    long mongoc_collection_count(_mongoc_collection_t*, mongoc_query_flags_t, const(_bson_t)*, long, long, const(_mongoc_read_prefs_t)*, _bson_error_t*) @nogc nothrow;
    long mongoc_collection_count_with_opts(_mongoc_collection_t*, mongoc_query_flags_t, const(_bson_t)*, long, long, const(_bson_t)*, const(_mongoc_read_prefs_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_drop(_mongoc_collection_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_drop_with_opts(_mongoc_collection_t*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_drop_index(_mongoc_collection_t*, const(char)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_drop_index_with_opts(_mongoc_collection_t*, const(char)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_create_index(_mongoc_collection_t*, const(_bson_t)*, const(mongoc_index_opt_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_create_index_with_opts(_mongoc_collection_t*, const(_bson_t)*, const(mongoc_index_opt_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_ensure_index(_mongoc_collection_t*, const(_bson_t)*, const(mongoc_index_opt_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_collection_find_indexes(_mongoc_collection_t*, _bson_error_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_collection_find_indexes_with_opts(_mongoc_collection_t*, const(_bson_t)*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_collection_find(_mongoc_collection_t*, mongoc_query_flags_t, uint, uint, uint, const(_bson_t)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_collection_find_with_opts(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    byte mongoc_collection_insert(_mongoc_collection_t*, mongoc_insert_flags_t, const(_bson_t)*, const(_mongoc_write_concern_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_insert_one(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_insert_many(_mongoc_collection_t*, const(_bson_t)**, ulong, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_insert_bulk(_mongoc_collection_t*, mongoc_insert_flags_t, const(_bson_t)**, uint, const(_mongoc_write_concern_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_update(_mongoc_collection_t*, mongoc_update_flags_t, const(_bson_t)*, const(_bson_t)*, const(_mongoc_write_concern_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_update_one(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_update_many(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_replace_one(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_delete(_mongoc_collection_t*, mongoc_delete_flags_t, const(_bson_t)*, const(_mongoc_write_concern_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_save(_mongoc_collection_t*, const(_bson_t)*, const(_mongoc_write_concern_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_remove(_mongoc_collection_t*, mongoc_remove_flags_t, const(_bson_t)*, const(_mongoc_write_concern_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_delete_one(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_delete_many(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_rename(_mongoc_collection_t*, const(char)*, const(char)*, byte, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_rename_with_opts(_mongoc_collection_t*, const(char)*, const(char)*, byte, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_find_and_modify_with_opts(_mongoc_collection_t*, const(_bson_t)*, const(_mongoc_find_and_modify_opts_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_find_and_modify(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, const(_bson_t)*, const(_bson_t)*, byte, byte, byte, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_collection_stats(_mongoc_collection_t*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    _mongoc_bulk_operation_t* mongoc_collection_create_bulk_operation(_mongoc_collection_t*, byte, const(_mongoc_write_concern_t)*) @nogc nothrow;
    _mongoc_bulk_operation_t* mongoc_collection_create_bulk_operation_with_opts(_mongoc_collection_t*, const(_bson_t)*) @nogc nothrow;
    const(_mongoc_read_prefs_t)* mongoc_collection_get_read_prefs(const(_mongoc_collection_t)*) @nogc nothrow;
    void mongoc_collection_set_read_prefs(_mongoc_collection_t*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    const(_mongoc_read_concern_t)* mongoc_collection_get_read_concern(const(_mongoc_collection_t)*) @nogc nothrow;
    void mongoc_collection_set_read_concern(_mongoc_collection_t*, const(_mongoc_read_concern_t)*) @nogc nothrow;
    const(_mongoc_write_concern_t)* mongoc_collection_get_write_concern(const(_mongoc_collection_t)*) @nogc nothrow;
    void mongoc_collection_set_write_concern(_mongoc_collection_t*, const(_mongoc_write_concern_t)*) @nogc nothrow;
    const(char)* mongoc_collection_get_name(_mongoc_collection_t*) @nogc nothrow;
    const(_bson_t)* mongoc_collection_get_last_error(const(_mongoc_collection_t)*) @nogc nothrow;
    char* mongoc_collection_keys_to_index_string(const(_bson_t)*) @nogc nothrow;
    byte mongoc_collection_validate(_mongoc_collection_t*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    _mongoc_change_stream_t* mongoc_collection_watch(const(_mongoc_collection_t)*, const(_bson_t)*, const(_bson_t)*) @nogc nothrow;
    long mongoc_collection_count_documents(_mongoc_collection_t*, const(_bson_t)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    long mongoc_collection_estimated_document_count(_mongoc_collection_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    alias mongoc_cursor_t = _mongoc_cursor_t;
    struct _mongoc_cursor_t;
    struct _mongoc_client_t;
    _mongoc_cursor_t* mongoc_cursor_clone(const(_mongoc_cursor_t)*) @nogc nothrow;
    void mongoc_cursor_destroy(_mongoc_cursor_t*) @nogc nothrow;
    byte mongoc_cursor_more(_mongoc_cursor_t*) @nogc nothrow;
    byte mongoc_cursor_next(_mongoc_cursor_t*, const(_bson_t)**) @nogc nothrow;
    byte mongoc_cursor_error(_mongoc_cursor_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_cursor_error_document(_mongoc_cursor_t*, _bson_error_t*, const(_bson_t)**) @nogc nothrow;
    void mongoc_cursor_get_host(_mongoc_cursor_t*, _mongoc_host_list_t*) @nogc nothrow;
    byte mongoc_cursor_is_alive(const(_mongoc_cursor_t)*) @nogc nothrow;
    const(_bson_t)* mongoc_cursor_current(const(_mongoc_cursor_t)*) @nogc nothrow;
    void mongoc_cursor_set_batch_size(_mongoc_cursor_t*, uint) @nogc nothrow;
    uint mongoc_cursor_get_batch_size(const(_mongoc_cursor_t)*) @nogc nothrow;
    byte mongoc_cursor_set_limit(_mongoc_cursor_t*, long) @nogc nothrow;
    long mongoc_cursor_get_limit(const(_mongoc_cursor_t)*) @nogc nothrow;
    byte mongoc_cursor_set_hint(_mongoc_cursor_t*, uint) @nogc nothrow;
    uint mongoc_cursor_get_hint(const(_mongoc_cursor_t)*) @nogc nothrow;
    long mongoc_cursor_get_id(const(_mongoc_cursor_t)*) @nogc nothrow;
    void mongoc_cursor_set_max_await_time_ms(_mongoc_cursor_t*, uint) @nogc nothrow;
    uint mongoc_cursor_get_max_await_time_ms(const(_mongoc_cursor_t)*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_cursor_new_from_command_reply(_mongoc_client_t*, _bson_t*, uint) @nogc nothrow;
    _mongoc_cursor_t* mongoc_cursor_new_from_command_reply_with_opts(_mongoc_client_t*, _bson_t*, const(_bson_t)*) @nogc nothrow;
    alias mongoc_database_t = _mongoc_database_t;
    struct _mongoc_database_t;
    const(char)* mongoc_database_get_name(_mongoc_database_t*) @nogc nothrow;
    byte mongoc_database_remove_user(_mongoc_database_t*, const(char)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_remove_all_users(_mongoc_database_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_add_user(_mongoc_database_t*, const(char)*, const(char)*, const(_bson_t)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    void mongoc_database_destroy(_mongoc_database_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_database_aggregate(_mongoc_database_t*, const(_bson_t)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    _mongoc_database_t* mongoc_database_copy(_mongoc_database_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_database_command(_mongoc_database_t*, mongoc_query_flags_t, uint, uint, uint, const(_bson_t)*, const(_bson_t)*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    byte mongoc_database_read_command_with_opts(_mongoc_database_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_write_command_with_opts(_mongoc_database_t*, const(_bson_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_read_write_command_with_opts(_mongoc_database_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_command_with_opts(_mongoc_database_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, const(_bson_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_command_simple(_mongoc_database_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, _bson_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_drop(_mongoc_database_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_drop_with_opts(_mongoc_database_t*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_database_has_collection(_mongoc_database_t*, const(char)*, _bson_error_t*) @nogc nothrow;
    _mongoc_collection_t* mongoc_database_create_collection(_mongoc_database_t*, const(char)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    const(_mongoc_read_prefs_t)* mongoc_database_get_read_prefs(const(_mongoc_database_t)*) @nogc nothrow;
    void mongoc_database_set_read_prefs(_mongoc_database_t*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    const(_mongoc_write_concern_t)* mongoc_database_get_write_concern(const(_mongoc_database_t)*) @nogc nothrow;
    void mongoc_database_set_write_concern(_mongoc_database_t*, const(_mongoc_write_concern_t)*) @nogc nothrow;
    const(_mongoc_read_concern_t)* mongoc_database_get_read_concern(const(_mongoc_database_t)*) @nogc nothrow;
    void mongoc_database_set_read_concern(_mongoc_database_t*, const(_mongoc_read_concern_t)*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_database_find_collections(_mongoc_database_t*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_database_find_collections_with_opts(_mongoc_database_t*, const(_bson_t)*) @nogc nothrow;
    char** mongoc_database_get_collection_names(_mongoc_database_t*, _bson_error_t*) @nogc nothrow;
    char** mongoc_database_get_collection_names_with_opts(_mongoc_database_t*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_collection_t* mongoc_database_get_collection(_mongoc_database_t*, const(char)*) @nogc nothrow;
    _mongoc_change_stream_t* mongoc_database_watch(const(_mongoc_database_t)*, const(_bson_t)*, const(_bson_t)*) @nogc nothrow;
    alias mongoc_error_domain_t = _Anonymous_16;
    enum _Anonymous_16
    {
        MONGOC_ERROR_CLIENT = 1,
        MONGOC_ERROR_STREAM = 2,
        MONGOC_ERROR_PROTOCOL = 3,
        MONGOC_ERROR_CURSOR = 4,
        MONGOC_ERROR_QUERY = 5,
        MONGOC_ERROR_INSERT = 6,
        MONGOC_ERROR_SASL = 7,
        MONGOC_ERROR_BSON = 8,
        MONGOC_ERROR_MATCHER = 9,
        MONGOC_ERROR_NAMESPACE = 10,
        MONGOC_ERROR_COMMAND = 11,
        MONGOC_ERROR_COLLECTION = 12,
        MONGOC_ERROR_GRIDFS = 13,
        MONGOC_ERROR_SCRAM = 14,
        MONGOC_ERROR_SERVER_SELECTION = 15,
        MONGOC_ERROR_WRITE_CONCERN = 16,
        MONGOC_ERROR_SERVER = 17,
        MONGOC_ERROR_TRANSACTION = 18,
    }
    enum MONGOC_ERROR_CLIENT = _Anonymous_16.MONGOC_ERROR_CLIENT;
    enum MONGOC_ERROR_STREAM = _Anonymous_16.MONGOC_ERROR_STREAM;
    enum MONGOC_ERROR_PROTOCOL = _Anonymous_16.MONGOC_ERROR_PROTOCOL;
    enum MONGOC_ERROR_CURSOR = _Anonymous_16.MONGOC_ERROR_CURSOR;
    enum MONGOC_ERROR_QUERY = _Anonymous_16.MONGOC_ERROR_QUERY;
    enum MONGOC_ERROR_INSERT = _Anonymous_16.MONGOC_ERROR_INSERT;
    enum MONGOC_ERROR_SASL = _Anonymous_16.MONGOC_ERROR_SASL;
    enum MONGOC_ERROR_BSON = _Anonymous_16.MONGOC_ERROR_BSON;
    enum MONGOC_ERROR_MATCHER = _Anonymous_16.MONGOC_ERROR_MATCHER;
    enum MONGOC_ERROR_NAMESPACE = _Anonymous_16.MONGOC_ERROR_NAMESPACE;
    enum MONGOC_ERROR_COMMAND = _Anonymous_16.MONGOC_ERROR_COMMAND;
    enum MONGOC_ERROR_COLLECTION = _Anonymous_16.MONGOC_ERROR_COLLECTION;
    enum MONGOC_ERROR_GRIDFS = _Anonymous_16.MONGOC_ERROR_GRIDFS;
    enum MONGOC_ERROR_SCRAM = _Anonymous_16.MONGOC_ERROR_SCRAM;
    enum MONGOC_ERROR_SERVER_SELECTION = _Anonymous_16.MONGOC_ERROR_SERVER_SELECTION;
    enum MONGOC_ERROR_WRITE_CONCERN = _Anonymous_16.MONGOC_ERROR_WRITE_CONCERN;
    enum MONGOC_ERROR_SERVER = _Anonymous_16.MONGOC_ERROR_SERVER;
    enum MONGOC_ERROR_TRANSACTION = _Anonymous_16.MONGOC_ERROR_TRANSACTION;
    alias mongoc_error_code_t = _Anonymous_17;
    enum _Anonymous_17
    {
        MONGOC_ERROR_STREAM_INVALID_TYPE = 1,
        MONGOC_ERROR_STREAM_INVALID_STATE = 2,
        MONGOC_ERROR_STREAM_NAME_RESOLUTION = 3,
        MONGOC_ERROR_STREAM_SOCKET = 4,
        MONGOC_ERROR_STREAM_CONNECT = 5,
        MONGOC_ERROR_STREAM_NOT_ESTABLISHED = 6,
        MONGOC_ERROR_CLIENT_NOT_READY = 7,
        MONGOC_ERROR_CLIENT_TOO_BIG = 8,
        MONGOC_ERROR_CLIENT_TOO_SMALL = 9,
        MONGOC_ERROR_CLIENT_GETNONCE = 10,
        MONGOC_ERROR_CLIENT_AUTHENTICATE = 11,
        MONGOC_ERROR_CLIENT_NO_ACCEPTABLE_PEER = 12,
        MONGOC_ERROR_CLIENT_IN_EXHAUST = 13,
        MONGOC_ERROR_PROTOCOL_INVALID_REPLY = 14,
        MONGOC_ERROR_PROTOCOL_BAD_WIRE_VERSION = 15,
        MONGOC_ERROR_CURSOR_INVALID_CURSOR = 16,
        MONGOC_ERROR_QUERY_FAILURE = 17,
        MONGOC_ERROR_BSON_INVALID = 18,
        MONGOC_ERROR_MATCHER_INVALID = 19,
        MONGOC_ERROR_NAMESPACE_INVALID = 20,
        MONGOC_ERROR_NAMESPACE_INVALID_FILTER_TYPE = 21,
        MONGOC_ERROR_COMMAND_INVALID_ARG = 22,
        MONGOC_ERROR_COLLECTION_INSERT_FAILED = 23,
        MONGOC_ERROR_COLLECTION_UPDATE_FAILED = 24,
        MONGOC_ERROR_COLLECTION_DELETE_FAILED = 25,
        MONGOC_ERROR_COLLECTION_DOES_NOT_EXIST = 26,
        MONGOC_ERROR_GRIDFS_INVALID_FILENAME = 27,
        MONGOC_ERROR_SCRAM_NOT_DONE = 28,
        MONGOC_ERROR_SCRAM_PROTOCOL_ERROR = 29,
        MONGOC_ERROR_QUERY_COMMAND_NOT_FOUND = 59,
        MONGOC_ERROR_QUERY_NOT_TAILABLE = 13051,
        MONGOC_ERROR_SERVER_SELECTION_BAD_WIRE_VERSION = 13052,
        MONGOC_ERROR_SERVER_SELECTION_FAILURE = 13053,
        MONGOC_ERROR_SERVER_SELECTION_INVALID_ID = 13054,
        MONGOC_ERROR_GRIDFS_CHUNK_MISSING = 13055,
        MONGOC_ERROR_GRIDFS_PROTOCOL_ERROR = 13056,
        MONGOC_ERROR_PROTOCOL_ERROR = 17,
        MONGOC_ERROR_WRITE_CONCERN_ERROR = 64,
        MONGOC_ERROR_DUPLICATE_KEY = 11000,
        MONGOC_ERROR_MAX_TIME_MS_EXPIRED = 50,
        MONGOC_ERROR_CHANGE_STREAM_NO_RESUME_TOKEN = 51,
        MONGOC_ERROR_CLIENT_SESSION_FAILURE = 52,
        MONGOC_ERROR_TRANSACTION_INVALID_STATE = 53,
        MONGOC_ERROR_GRIDFS_CORRUPT = 54,
        MONGOC_ERROR_GRIDFS_BUCKET_FILE_NOT_FOUND = 55,
        MONGOC_ERROR_GRIDFS_BUCKET_STREAM = 56,
    }
    enum MONGOC_ERROR_STREAM_INVALID_TYPE = _Anonymous_17.MONGOC_ERROR_STREAM_INVALID_TYPE;
    enum MONGOC_ERROR_STREAM_INVALID_STATE = _Anonymous_17.MONGOC_ERROR_STREAM_INVALID_STATE;
    enum MONGOC_ERROR_STREAM_NAME_RESOLUTION = _Anonymous_17.MONGOC_ERROR_STREAM_NAME_RESOLUTION;
    enum MONGOC_ERROR_STREAM_SOCKET = _Anonymous_17.MONGOC_ERROR_STREAM_SOCKET;
    enum MONGOC_ERROR_STREAM_CONNECT = _Anonymous_17.MONGOC_ERROR_STREAM_CONNECT;
    enum MONGOC_ERROR_STREAM_NOT_ESTABLISHED = _Anonymous_17.MONGOC_ERROR_STREAM_NOT_ESTABLISHED;
    enum MONGOC_ERROR_CLIENT_NOT_READY = _Anonymous_17.MONGOC_ERROR_CLIENT_NOT_READY;
    enum MONGOC_ERROR_CLIENT_TOO_BIG = _Anonymous_17.MONGOC_ERROR_CLIENT_TOO_BIG;
    enum MONGOC_ERROR_CLIENT_TOO_SMALL = _Anonymous_17.MONGOC_ERROR_CLIENT_TOO_SMALL;
    enum MONGOC_ERROR_CLIENT_GETNONCE = _Anonymous_17.MONGOC_ERROR_CLIENT_GETNONCE;
    enum MONGOC_ERROR_CLIENT_AUTHENTICATE = _Anonymous_17.MONGOC_ERROR_CLIENT_AUTHENTICATE;
    enum MONGOC_ERROR_CLIENT_NO_ACCEPTABLE_PEER = _Anonymous_17.MONGOC_ERROR_CLIENT_NO_ACCEPTABLE_PEER;
    enum MONGOC_ERROR_CLIENT_IN_EXHAUST = _Anonymous_17.MONGOC_ERROR_CLIENT_IN_EXHAUST;
    enum MONGOC_ERROR_PROTOCOL_INVALID_REPLY = _Anonymous_17.MONGOC_ERROR_PROTOCOL_INVALID_REPLY;
    enum MONGOC_ERROR_PROTOCOL_BAD_WIRE_VERSION = _Anonymous_17.MONGOC_ERROR_PROTOCOL_BAD_WIRE_VERSION;
    enum MONGOC_ERROR_CURSOR_INVALID_CURSOR = _Anonymous_17.MONGOC_ERROR_CURSOR_INVALID_CURSOR;
    enum MONGOC_ERROR_QUERY_FAILURE = _Anonymous_17.MONGOC_ERROR_QUERY_FAILURE;
    enum MONGOC_ERROR_BSON_INVALID = _Anonymous_17.MONGOC_ERROR_BSON_INVALID;
    enum MONGOC_ERROR_MATCHER_INVALID = _Anonymous_17.MONGOC_ERROR_MATCHER_INVALID;
    enum MONGOC_ERROR_NAMESPACE_INVALID = _Anonymous_17.MONGOC_ERROR_NAMESPACE_INVALID;
    enum MONGOC_ERROR_NAMESPACE_INVALID_FILTER_TYPE = _Anonymous_17.MONGOC_ERROR_NAMESPACE_INVALID_FILTER_TYPE;
    enum MONGOC_ERROR_COMMAND_INVALID_ARG = _Anonymous_17.MONGOC_ERROR_COMMAND_INVALID_ARG;
    enum MONGOC_ERROR_COLLECTION_INSERT_FAILED = _Anonymous_17.MONGOC_ERROR_COLLECTION_INSERT_FAILED;
    enum MONGOC_ERROR_COLLECTION_UPDATE_FAILED = _Anonymous_17.MONGOC_ERROR_COLLECTION_UPDATE_FAILED;
    enum MONGOC_ERROR_COLLECTION_DELETE_FAILED = _Anonymous_17.MONGOC_ERROR_COLLECTION_DELETE_FAILED;
    enum MONGOC_ERROR_COLLECTION_DOES_NOT_EXIST = _Anonymous_17.MONGOC_ERROR_COLLECTION_DOES_NOT_EXIST;
    enum MONGOC_ERROR_GRIDFS_INVALID_FILENAME = _Anonymous_17.MONGOC_ERROR_GRIDFS_INVALID_FILENAME;
    enum MONGOC_ERROR_SCRAM_NOT_DONE = _Anonymous_17.MONGOC_ERROR_SCRAM_NOT_DONE;
    enum MONGOC_ERROR_SCRAM_PROTOCOL_ERROR = _Anonymous_17.MONGOC_ERROR_SCRAM_PROTOCOL_ERROR;
    enum MONGOC_ERROR_QUERY_COMMAND_NOT_FOUND = _Anonymous_17.MONGOC_ERROR_QUERY_COMMAND_NOT_FOUND;
    enum MONGOC_ERROR_QUERY_NOT_TAILABLE = _Anonymous_17.MONGOC_ERROR_QUERY_NOT_TAILABLE;
    enum MONGOC_ERROR_SERVER_SELECTION_BAD_WIRE_VERSION = _Anonymous_17.MONGOC_ERROR_SERVER_SELECTION_BAD_WIRE_VERSION;
    enum MONGOC_ERROR_SERVER_SELECTION_FAILURE = _Anonymous_17.MONGOC_ERROR_SERVER_SELECTION_FAILURE;
    enum MONGOC_ERROR_SERVER_SELECTION_INVALID_ID = _Anonymous_17.MONGOC_ERROR_SERVER_SELECTION_INVALID_ID;
    enum MONGOC_ERROR_GRIDFS_CHUNK_MISSING = _Anonymous_17.MONGOC_ERROR_GRIDFS_CHUNK_MISSING;
    enum MONGOC_ERROR_GRIDFS_PROTOCOL_ERROR = _Anonymous_17.MONGOC_ERROR_GRIDFS_PROTOCOL_ERROR;
    enum MONGOC_ERROR_PROTOCOL_ERROR = _Anonymous_17.MONGOC_ERROR_PROTOCOL_ERROR;
    enum MONGOC_ERROR_WRITE_CONCERN_ERROR = _Anonymous_17.MONGOC_ERROR_WRITE_CONCERN_ERROR;
    enum MONGOC_ERROR_DUPLICATE_KEY = _Anonymous_17.MONGOC_ERROR_DUPLICATE_KEY;
    enum MONGOC_ERROR_MAX_TIME_MS_EXPIRED = _Anonymous_17.MONGOC_ERROR_MAX_TIME_MS_EXPIRED;
    enum MONGOC_ERROR_CHANGE_STREAM_NO_RESUME_TOKEN = _Anonymous_17.MONGOC_ERROR_CHANGE_STREAM_NO_RESUME_TOKEN;
    enum MONGOC_ERROR_CLIENT_SESSION_FAILURE = _Anonymous_17.MONGOC_ERROR_CLIENT_SESSION_FAILURE;
    enum MONGOC_ERROR_TRANSACTION_INVALID_STATE = _Anonymous_17.MONGOC_ERROR_TRANSACTION_INVALID_STATE;
    enum MONGOC_ERROR_GRIDFS_CORRUPT = _Anonymous_17.MONGOC_ERROR_GRIDFS_CORRUPT;
    enum MONGOC_ERROR_GRIDFS_BUCKET_FILE_NOT_FOUND = _Anonymous_17.MONGOC_ERROR_GRIDFS_BUCKET_FILE_NOT_FOUND;
    enum MONGOC_ERROR_GRIDFS_BUCKET_STREAM = _Anonymous_17.MONGOC_ERROR_GRIDFS_BUCKET_STREAM;
    byte mongoc_error_has_label(const(_bson_t)*, const(char)*) @nogc nothrow;
    alias mongoc_find_and_modify_flags_t = _Anonymous_18;
    enum _Anonymous_18
    {
        MONGOC_FIND_AND_MODIFY_NONE = 0,
        MONGOC_FIND_AND_MODIFY_REMOVE = 1,
        MONGOC_FIND_AND_MODIFY_UPSERT = 2,
        MONGOC_FIND_AND_MODIFY_RETURN_NEW = 4,
    }
    enum MONGOC_FIND_AND_MODIFY_NONE = _Anonymous_18.MONGOC_FIND_AND_MODIFY_NONE;
    enum MONGOC_FIND_AND_MODIFY_REMOVE = _Anonymous_18.MONGOC_FIND_AND_MODIFY_REMOVE;
    enum MONGOC_FIND_AND_MODIFY_UPSERT = _Anonymous_18.MONGOC_FIND_AND_MODIFY_UPSERT;
    enum MONGOC_FIND_AND_MODIFY_RETURN_NEW = _Anonymous_18.MONGOC_FIND_AND_MODIFY_RETURN_NEW;
    alias mongoc_find_and_modify_opts_t = _mongoc_find_and_modify_opts_t;
    struct _mongoc_find_and_modify_opts_t;
    _mongoc_find_and_modify_opts_t* mongoc_find_and_modify_opts_new() @nogc nothrow;
    byte mongoc_find_and_modify_opts_set_sort(_mongoc_find_and_modify_opts_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_find_and_modify_opts_get_sort(const(_mongoc_find_and_modify_opts_t)*, _bson_t*) @nogc nothrow;
    byte mongoc_find_and_modify_opts_set_update(_mongoc_find_and_modify_opts_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_find_and_modify_opts_get_update(const(_mongoc_find_and_modify_opts_t)*, _bson_t*) @nogc nothrow;
    byte mongoc_find_and_modify_opts_set_fields(_mongoc_find_and_modify_opts_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_find_and_modify_opts_get_fields(const(_mongoc_find_and_modify_opts_t)*, _bson_t*) @nogc nothrow;
    byte mongoc_find_and_modify_opts_set_flags(_mongoc_find_and_modify_opts_t*, const(mongoc_find_and_modify_flags_t)) @nogc nothrow;
    mongoc_find_and_modify_flags_t mongoc_find_and_modify_opts_get_flags(const(_mongoc_find_and_modify_opts_t)*) @nogc nothrow;
    byte mongoc_find_and_modify_opts_set_bypass_document_validation(_mongoc_find_and_modify_opts_t*, byte) @nogc nothrow;
    byte mongoc_find_and_modify_opts_get_bypass_document_validation(const(_mongoc_find_and_modify_opts_t)*) @nogc nothrow;
    byte mongoc_find_and_modify_opts_set_max_time_ms(_mongoc_find_and_modify_opts_t*, uint) @nogc nothrow;
    uint mongoc_find_and_modify_opts_get_max_time_ms(const(_mongoc_find_and_modify_opts_t)*) @nogc nothrow;
    byte mongoc_find_and_modify_opts_append(_mongoc_find_and_modify_opts_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_find_and_modify_opts_get_extra(const(_mongoc_find_and_modify_opts_t)*, _bson_t*) @nogc nothrow;
    void mongoc_find_and_modify_opts_destroy(_mongoc_find_and_modify_opts_t*) @nogc nothrow;
    alias mongoc_delete_flags_t = _Anonymous_19;
    enum _Anonymous_19
    {
        MONGOC_DELETE_NONE = 0,
        MONGOC_DELETE_SINGLE_REMOVE = 1,
    }
    enum MONGOC_DELETE_NONE = _Anonymous_19.MONGOC_DELETE_NONE;
    enum MONGOC_DELETE_SINGLE_REMOVE = _Anonymous_19.MONGOC_DELETE_SINGLE_REMOVE;
    alias mongoc_remove_flags_t = _Anonymous_20;
    enum _Anonymous_20
    {
        MONGOC_REMOVE_NONE = 0,
        MONGOC_REMOVE_SINGLE_REMOVE = 1,
    }
    enum MONGOC_REMOVE_NONE = _Anonymous_20.MONGOC_REMOVE_NONE;
    enum MONGOC_REMOVE_SINGLE_REMOVE = _Anonymous_20.MONGOC_REMOVE_SINGLE_REMOVE;
    alias mongoc_insert_flags_t = _Anonymous_21;
    enum _Anonymous_21
    {
        MONGOC_INSERT_NONE = 0,
        MONGOC_INSERT_CONTINUE_ON_ERROR = 1,
    }
    enum MONGOC_INSERT_NONE = _Anonymous_21.MONGOC_INSERT_NONE;
    enum MONGOC_INSERT_CONTINUE_ON_ERROR = _Anonymous_21.MONGOC_INSERT_CONTINUE_ON_ERROR;
    alias mongoc_query_flags_t = _Anonymous_22;
    enum _Anonymous_22
    {
        MONGOC_QUERY_NONE = 0,
        MONGOC_QUERY_TAILABLE_CURSOR = 2,
        MONGOC_QUERY_SLAVE_OK = 4,
        MONGOC_QUERY_OPLOG_REPLAY = 8,
        MONGOC_QUERY_NO_CURSOR_TIMEOUT = 16,
        MONGOC_QUERY_AWAIT_DATA = 32,
        MONGOC_QUERY_EXHAUST = 64,
        MONGOC_QUERY_PARTIAL = 128,
    }
    enum MONGOC_QUERY_NONE = _Anonymous_22.MONGOC_QUERY_NONE;
    enum MONGOC_QUERY_TAILABLE_CURSOR = _Anonymous_22.MONGOC_QUERY_TAILABLE_CURSOR;
    enum MONGOC_QUERY_SLAVE_OK = _Anonymous_22.MONGOC_QUERY_SLAVE_OK;
    enum MONGOC_QUERY_OPLOG_REPLAY = _Anonymous_22.MONGOC_QUERY_OPLOG_REPLAY;
    enum MONGOC_QUERY_NO_CURSOR_TIMEOUT = _Anonymous_22.MONGOC_QUERY_NO_CURSOR_TIMEOUT;
    enum MONGOC_QUERY_AWAIT_DATA = _Anonymous_22.MONGOC_QUERY_AWAIT_DATA;
    enum MONGOC_QUERY_EXHAUST = _Anonymous_22.MONGOC_QUERY_EXHAUST;
    enum MONGOC_QUERY_PARTIAL = _Anonymous_22.MONGOC_QUERY_PARTIAL;
    alias mongoc_reply_flags_t = _Anonymous_23;
    enum _Anonymous_23
    {
        MONGOC_REPLY_NONE = 0,
        MONGOC_REPLY_CURSOR_NOT_FOUND = 1,
        MONGOC_REPLY_QUERY_FAILURE = 2,
        MONGOC_REPLY_SHARD_CONFIG_STALE = 4,
        MONGOC_REPLY_AWAIT_CAPABLE = 8,
    }
    enum MONGOC_REPLY_NONE = _Anonymous_23.MONGOC_REPLY_NONE;
    enum MONGOC_REPLY_CURSOR_NOT_FOUND = _Anonymous_23.MONGOC_REPLY_CURSOR_NOT_FOUND;
    enum MONGOC_REPLY_QUERY_FAILURE = _Anonymous_23.MONGOC_REPLY_QUERY_FAILURE;
    enum MONGOC_REPLY_SHARD_CONFIG_STALE = _Anonymous_23.MONGOC_REPLY_SHARD_CONFIG_STALE;
    enum MONGOC_REPLY_AWAIT_CAPABLE = _Anonymous_23.MONGOC_REPLY_AWAIT_CAPABLE;
    alias mongoc_update_flags_t = _Anonymous_24;
    enum _Anonymous_24
    {
        MONGOC_UPDATE_NONE = 0,
        MONGOC_UPDATE_UPSERT = 1,
        MONGOC_UPDATE_MULTI_UPDATE = 2,
    }
    enum MONGOC_UPDATE_NONE = _Anonymous_24.MONGOC_UPDATE_NONE;
    enum MONGOC_UPDATE_UPSERT = _Anonymous_24.MONGOC_UPDATE_UPSERT;
    enum MONGOC_UPDATE_MULTI_UPDATE = _Anonymous_24.MONGOC_UPDATE_MULTI_UPDATE;
    alias mongoc_gridfs_bucket_t = _mongoc_gridfs_bucket_t;
    struct _mongoc_gridfs_bucket_t;
    _mongoc_gridfs_bucket_t* mongoc_gridfs_bucket_new(_mongoc_database_t*, const(_bson_t)*, const(_mongoc_read_prefs_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_stream_t* mongoc_gridfs_bucket_open_upload_stream(_mongoc_gridfs_bucket_t*, const(char)*, const(_bson_t)*, _bson_value_t*, _bson_error_t*) @nogc nothrow;
    _mongoc_stream_t* mongoc_gridfs_bucket_open_upload_stream_with_id(_mongoc_gridfs_bucket_t*, const(_bson_value_t)*, const(char)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_gridfs_bucket_upload_from_stream(_mongoc_gridfs_bucket_t*, const(char)*, _mongoc_stream_t*, const(_bson_t)*, _bson_value_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_gridfs_bucket_upload_from_stream_with_id(_mongoc_gridfs_bucket_t*, const(_bson_value_t)*, const(char)*, _mongoc_stream_t*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_stream_t* mongoc_gridfs_bucket_open_download_stream(_mongoc_gridfs_bucket_t*, const(_bson_value_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_gridfs_bucket_download_to_stream(_mongoc_gridfs_bucket_t*, const(_bson_value_t)*, _mongoc_stream_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_gridfs_bucket_delete_by_id(_mongoc_gridfs_bucket_t*, const(_bson_value_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_cursor_t* mongoc_gridfs_bucket_find(_mongoc_gridfs_bucket_t*, const(_bson_t)*, const(_bson_t)*) @nogc nothrow;
    byte mongoc_gridfs_bucket_stream_error(_mongoc_stream_t*, _bson_error_t*) @nogc nothrow;
    void mongoc_gridfs_bucket_destroy(_mongoc_gridfs_bucket_t*) @nogc nothrow;
    byte mongoc_gridfs_bucket_abort_upload(_mongoc_stream_t*) @nogc nothrow;
    alias mongoc_gridfs_file_list_t = _mongoc_gridfs_file_list_t;
    struct _mongoc_gridfs_file_list_t;
    _mongoc_gridfs_file_t* mongoc_gridfs_file_list_next(_mongoc_gridfs_file_list_t*) @nogc nothrow;
    void mongoc_gridfs_file_list_destroy(_mongoc_gridfs_file_list_t*) @nogc nothrow;
    byte mongoc_gridfs_file_list_error(_mongoc_gridfs_file_list_t*, _bson_error_t*) @nogc nothrow;
    alias mongoc_gridfs_file_page_t = _mongoc_gridfs_file_page_t;
    struct _mongoc_gridfs_file_page_t;
    alias mongoc_gridfs_file_t = _mongoc_gridfs_file_t;
    struct _mongoc_gridfs_file_t;
    alias mongoc_gridfs_file_opt_t = _mongoc_gridfs_file_opt_t;
    struct _mongoc_gridfs_file_opt_t
    {
        const(char)* md5;
        const(char)* filename;
        const(char)* content_type;
        const(_bson_t)* aliases;
        const(_bson_t)* metadata;
        uint chunk_size;
    }
    const(char)* mongoc_gridfs_file_get_md5(_mongoc_gridfs_file_t*) @nogc nothrow;
    void mongoc_gridfs_file_set_md5(_mongoc_gridfs_file_t*, const(char)*) @nogc nothrow;
    void mongoc_gridfs_file_set_filename(_mongoc_gridfs_file_t*, const(char)*) @nogc nothrow;
    const(char)* mongoc_gridfs_file_get_filename(_mongoc_gridfs_file_t*) @nogc nothrow;
    void mongoc_gridfs_file_set_content_type(_mongoc_gridfs_file_t*, const(char)*) @nogc nothrow;
    const(char)* mongoc_gridfs_file_get_content_type(_mongoc_gridfs_file_t*) @nogc nothrow;
    const(_bson_t)* mongoc_gridfs_file_get_aliases(_mongoc_gridfs_file_t*) @nogc nothrow;
    void mongoc_gridfs_file_set_aliases(_mongoc_gridfs_file_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_gridfs_file_set_metadata(_mongoc_gridfs_file_t*, const(_bson_t)*) @nogc nothrow;
    const(_bson_t)* mongoc_gridfs_file_get_metadata(_mongoc_gridfs_file_t*) @nogc nothrow;
    const(_bson_value_t)* mongoc_gridfs_file_get_id(_mongoc_gridfs_file_t*) @nogc nothrow;
    long mongoc_gridfs_file_get_length(_mongoc_gridfs_file_t*) @nogc nothrow;
    int mongoc_gridfs_file_get_chunk_size(_mongoc_gridfs_file_t*) @nogc nothrow;
    long mongoc_gridfs_file_get_upload_date(_mongoc_gridfs_file_t*) @nogc nothrow;
    long mongoc_gridfs_file_writev(_mongoc_gridfs_file_t*, const(mongoc_iovec_t)*, ulong, uint) @nogc nothrow;
    long mongoc_gridfs_file_readv(_mongoc_gridfs_file_t*, mongoc_iovec_t*, ulong, ulong, uint) @nogc nothrow;
    int mongoc_gridfs_file_seek(_mongoc_gridfs_file_t*, long, int) @nogc nothrow;
    ulong mongoc_gridfs_file_tell(_mongoc_gridfs_file_t*) @nogc nothrow;
    byte mongoc_gridfs_file_set_id(_mongoc_gridfs_file_t*, const(_bson_value_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_gridfs_file_save(_mongoc_gridfs_file_t*) @nogc nothrow;
    void mongoc_gridfs_file_destroy(_mongoc_gridfs_file_t*) @nogc nothrow;
    byte mongoc_gridfs_file_error(_mongoc_gridfs_file_t*, _bson_error_t*) @nogc nothrow;
    byte mongoc_gridfs_file_remove(_mongoc_gridfs_file_t*, _bson_error_t*) @nogc nothrow;
    alias mongoc_gridfs_t = _mongoc_gridfs_t;
    struct _mongoc_gridfs_t;
    _mongoc_gridfs_file_t* mongoc_gridfs_create_file_from_stream(_mongoc_gridfs_t*, _mongoc_stream_t*, _mongoc_gridfs_file_opt_t*) @nogc nothrow;
    _mongoc_gridfs_file_t* mongoc_gridfs_create_file(_mongoc_gridfs_t*, _mongoc_gridfs_file_opt_t*) @nogc nothrow;
    _mongoc_gridfs_file_list_t* mongoc_gridfs_find(_mongoc_gridfs_t*, const(_bson_t)*) @nogc nothrow;
    _mongoc_gridfs_file_t* mongoc_gridfs_find_one(_mongoc_gridfs_t*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_gridfs_file_list_t* mongoc_gridfs_find_with_opts(_mongoc_gridfs_t*, const(_bson_t)*, const(_bson_t)*) @nogc nothrow;
    _mongoc_gridfs_file_t* mongoc_gridfs_find_one_with_opts(_mongoc_gridfs_t*, const(_bson_t)*, const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    _mongoc_gridfs_file_t* mongoc_gridfs_find_one_by_filename(_mongoc_gridfs_t*, const(char)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_gridfs_drop(_mongoc_gridfs_t*, _bson_error_t*) @nogc nothrow;
    void mongoc_gridfs_destroy(_mongoc_gridfs_t*) @nogc nothrow;
    _mongoc_collection_t* mongoc_gridfs_get_files(_mongoc_gridfs_t*) @nogc nothrow;
    _mongoc_collection_t* mongoc_gridfs_get_chunks(_mongoc_gridfs_t*) @nogc nothrow;
    byte mongoc_gridfs_remove_by_filename(_mongoc_gridfs_t*, const(char)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_handshake_data_append(const(char)*, const(char)*, const(char)*) @nogc nothrow;
    alias mongoc_host_list_t = _mongoc_host_list_t;
    struct _mongoc_host_list_t
    {
        _mongoc_host_list_t* next;
        char[256] host;
        char[262] host_and_port;
        ushort port;
        int family;
        void*[4] padding;
    }
    struct mongoc_index_opt_geo_t
    {
        ubyte twod_sphere_version;
        ubyte twod_bits_precision;
        double twod_location_min;
        double twod_location_max;
        double haystack_bucket_size;
        ubyte*[32] padding;
    }
    struct mongoc_index_opt_storage_t
    {
        int type;
    }
    alias mongoc_index_storage_opt_type_t = _Anonymous_25;
    enum _Anonymous_25
    {
        MONGOC_INDEX_STORAGE_OPT_MMAPV1 = 0,
        MONGOC_INDEX_STORAGE_OPT_WIREDTIGER = 1,
    }
    enum MONGOC_INDEX_STORAGE_OPT_MMAPV1 = _Anonymous_25.MONGOC_INDEX_STORAGE_OPT_MMAPV1;
    enum MONGOC_INDEX_STORAGE_OPT_WIREDTIGER = _Anonymous_25.MONGOC_INDEX_STORAGE_OPT_WIREDTIGER;
    struct mongoc_index_opt_wt_t
    {
        mongoc_index_opt_storage_t base;
        const(char)* config_str;
        void*[8] padding;
    }
    struct mongoc_index_opt_t
    {
        byte is_initialized;
        byte background;
        byte unique;
        const(char)* name;
        byte drop_dups;
        byte sparse;
        int expire_after_seconds;
        int v;
        const(_bson_t)* weights;
        const(char)* default_language;
        const(char)* language_override;
        mongoc_index_opt_geo_t* geo_options;
        mongoc_index_opt_storage_t* storage_options;
        const(_bson_t)* partial_filter_expression;
        const(_bson_t)* collation;
        void*[4] padding;
    }
    const(mongoc_index_opt_t)* mongoc_index_opt_get_default() @nogc nothrow;
    const(mongoc_index_opt_geo_t)* mongoc_index_opt_geo_get_default() @nogc nothrow;
    const(mongoc_index_opt_wt_t)* mongoc_index_opt_wt_get_default() @nogc nothrow;
    void mongoc_index_opt_init(mongoc_index_opt_t*) @nogc nothrow;
    void mongoc_index_opt_geo_init(mongoc_index_opt_geo_t*) @nogc nothrow;
    void mongoc_index_opt_wt_init(mongoc_index_opt_wt_t*) @nogc nothrow;
    void mongoc_init() @nogc nothrow;
    void mongoc_cleanup() @nogc nothrow;
    struct mongoc_iovec_t
    {
        ulong iov_len;
        char* iov_base;
    }
    alias static_assert_test_42sizeof_iovect_t = char[1];
    alias static_assert_test_45offsetof_iovec_base = char[1];
    alias static_assert_test_48offsetof_iovec_len = char[1];
    alias mongoc_log_level_t = _Anonymous_26;
    enum _Anonymous_26
    {
        MONGOC_LOG_LEVEL_ERROR = 0,
        MONGOC_LOG_LEVEL_CRITICAL = 1,
        MONGOC_LOG_LEVEL_WARNING = 2,
        MONGOC_LOG_LEVEL_MESSAGE = 3,
        MONGOC_LOG_LEVEL_INFO = 4,
        MONGOC_LOG_LEVEL_DEBUG = 5,
        MONGOC_LOG_LEVEL_TRACE = 6,
    }
    enum MONGOC_LOG_LEVEL_ERROR = _Anonymous_26.MONGOC_LOG_LEVEL_ERROR;
    enum MONGOC_LOG_LEVEL_CRITICAL = _Anonymous_26.MONGOC_LOG_LEVEL_CRITICAL;
    enum MONGOC_LOG_LEVEL_WARNING = _Anonymous_26.MONGOC_LOG_LEVEL_WARNING;
    enum MONGOC_LOG_LEVEL_MESSAGE = _Anonymous_26.MONGOC_LOG_LEVEL_MESSAGE;
    enum MONGOC_LOG_LEVEL_INFO = _Anonymous_26.MONGOC_LOG_LEVEL_INFO;
    enum MONGOC_LOG_LEVEL_DEBUG = _Anonymous_26.MONGOC_LOG_LEVEL_DEBUG;
    enum MONGOC_LOG_LEVEL_TRACE = _Anonymous_26.MONGOC_LOG_LEVEL_TRACE;
    alias mongoc_log_func_t = void function(mongoc_log_level_t, const(char)*, const(char)*, void*);
    void mongoc_log_set_handler(void function(mongoc_log_level_t, const(char)*, const(char)*, void*), void*) @nogc nothrow;
    void mongoc_log(mongoc_log_level_t, const(char)*, const(char)*, ...) @nogc nothrow;
    void mongoc_log_default_handler(mongoc_log_level_t, const(char)*, const(char)*, void*) @nogc nothrow;
    const(char)* mongoc_log_level_str(mongoc_log_level_t) @nogc nothrow;
    void mongoc_log_trace_enable() @nogc nothrow;
    void mongoc_log_trace_disable() @nogc nothrow;
    alias mongoc_matcher_t = _mongoc_matcher_t;
    struct _mongoc_matcher_t;
    _mongoc_matcher_t* mongoc_matcher_new(const(_bson_t)*, _bson_error_t*) @nogc nothrow;
    byte mongoc_matcher_match(const(_mongoc_matcher_t)*, const(_bson_t)*) @nogc nothrow;
    void mongoc_matcher_destroy(_mongoc_matcher_t*) @nogc nothrow;
    alias mongoc_opcode_t = _Anonymous_27;
    enum _Anonymous_27
    {
        MONGOC_OPCODE_REPLY = 1,
        MONGOC_OPCODE_UPDATE = 2001,
        MONGOC_OPCODE_INSERT = 2002,
        MONGOC_OPCODE_QUERY = 2004,
        MONGOC_OPCODE_GET_MORE = 2005,
        MONGOC_OPCODE_DELETE = 2006,
        MONGOC_OPCODE_KILL_CURSORS = 2007,
        MONGOC_OPCODE_COMPRESSED = 2012,
        MONGOC_OPCODE_MSG = 2013,
    }
    enum MONGOC_OPCODE_REPLY = _Anonymous_27.MONGOC_OPCODE_REPLY;
    enum MONGOC_OPCODE_UPDATE = _Anonymous_27.MONGOC_OPCODE_UPDATE;
    enum MONGOC_OPCODE_INSERT = _Anonymous_27.MONGOC_OPCODE_INSERT;
    enum MONGOC_OPCODE_QUERY = _Anonymous_27.MONGOC_OPCODE_QUERY;
    enum MONGOC_OPCODE_GET_MORE = _Anonymous_27.MONGOC_OPCODE_GET_MORE;
    enum MONGOC_OPCODE_DELETE = _Anonymous_27.MONGOC_OPCODE_DELETE;
    enum MONGOC_OPCODE_KILL_CURSORS = _Anonymous_27.MONGOC_OPCODE_KILL_CURSORS;
    enum MONGOC_OPCODE_COMPRESSED = _Anonymous_27.MONGOC_OPCODE_COMPRESSED;
    enum MONGOC_OPCODE_MSG = _Anonymous_27.MONGOC_OPCODE_MSG;
    void mongoc_rand_seed(const(void)*, int) @nogc nothrow;
    void mongoc_rand_add(const(void)*, int, double) @nogc nothrow;
    int mongoc_rand_status() @nogc nothrow;
    alias mongoc_read_concern_t = _mongoc_read_concern_t;
    struct _mongoc_read_concern_t;
    _mongoc_read_concern_t* mongoc_read_concern_new() @nogc nothrow;
    _mongoc_read_concern_t* mongoc_read_concern_copy(const(_mongoc_read_concern_t)*) @nogc nothrow;
    void mongoc_read_concern_destroy(_mongoc_read_concern_t*) @nogc nothrow;
    const(char)* mongoc_read_concern_get_level(const(_mongoc_read_concern_t)*) @nogc nothrow;
    byte mongoc_read_concern_set_level(_mongoc_read_concern_t*, const(char)*) @nogc nothrow;
    byte mongoc_read_concern_append(_mongoc_read_concern_t*, _bson_t*) @nogc nothrow;
    byte mongoc_read_concern_is_default(const(_mongoc_read_concern_t)*) @nogc nothrow;
    alias mongoc_read_prefs_t = _mongoc_read_prefs_t;
    struct _mongoc_read_prefs_t;
    alias mongoc_read_mode_t = _Anonymous_28;
    enum _Anonymous_28
    {
        MONGOC_READ_PRIMARY = 1,
        MONGOC_READ_SECONDARY = 2,
        MONGOC_READ_PRIMARY_PREFERRED = 5,
        MONGOC_READ_SECONDARY_PREFERRED = 6,
        MONGOC_READ_NEAREST = 10,
    }
    enum MONGOC_READ_PRIMARY = _Anonymous_28.MONGOC_READ_PRIMARY;
    enum MONGOC_READ_SECONDARY = _Anonymous_28.MONGOC_READ_SECONDARY;
    enum MONGOC_READ_PRIMARY_PREFERRED = _Anonymous_28.MONGOC_READ_PRIMARY_PREFERRED;
    enum MONGOC_READ_SECONDARY_PREFERRED = _Anonymous_28.MONGOC_READ_SECONDARY_PREFERRED;
    enum MONGOC_READ_NEAREST = _Anonymous_28.MONGOC_READ_NEAREST;
    _mongoc_read_prefs_t* mongoc_read_prefs_new(mongoc_read_mode_t) @nogc nothrow;
    _mongoc_read_prefs_t* mongoc_read_prefs_copy(const(_mongoc_read_prefs_t)*) @nogc nothrow;
    void mongoc_read_prefs_destroy(_mongoc_read_prefs_t*) @nogc nothrow;
    mongoc_read_mode_t mongoc_read_prefs_get_mode(const(_mongoc_read_prefs_t)*) @nogc nothrow;
    void mongoc_read_prefs_set_mode(_mongoc_read_prefs_t*, mongoc_read_mode_t) @nogc nothrow;
    const(_bson_t)* mongoc_read_prefs_get_tags(const(_mongoc_read_prefs_t)*) @nogc nothrow;
    void mongoc_read_prefs_set_tags(_mongoc_read_prefs_t*, const(_bson_t)*) @nogc nothrow;
    void mongoc_read_prefs_add_tag(_mongoc_read_prefs_t*, const(_bson_t)*) @nogc nothrow;
    long mongoc_read_prefs_get_max_staleness_seconds(const(_mongoc_read_prefs_t)*) @nogc nothrow;
    void mongoc_read_prefs_set_max_staleness_seconds(_mongoc_read_prefs_t*, long) @nogc nothrow;
    byte mongoc_read_prefs_is_valid(const(_mongoc_read_prefs_t)*) @nogc nothrow;
    alias mongoc_server_description_t = _mongoc_server_description_t;
    struct _mongoc_server_description_t;
    void mongoc_server_description_destroy(_mongoc_server_description_t*) @nogc nothrow;
    _mongoc_server_description_t* mongoc_server_description_new_copy(const(_mongoc_server_description_t)*) @nogc nothrow;
    uint mongoc_server_description_id(const(_mongoc_server_description_t)*) @nogc nothrow;
    _mongoc_host_list_t* mongoc_server_description_host(const(_mongoc_server_description_t)*) @nogc nothrow;
    long mongoc_server_description_last_update_time(const(_mongoc_server_description_t)*) @nogc nothrow;
    long mongoc_server_description_round_trip_time(const(_mongoc_server_description_t)*) @nogc nothrow;
    const(char)* mongoc_server_description_type(const(_mongoc_server_description_t)*) @nogc nothrow;
    const(_bson_t)* mongoc_server_description_ismaster(const(_mongoc_server_description_t)*) @nogc nothrow;
    int mongoc_server_description_compressor_id(const(_mongoc_server_description_t)*) @nogc nothrow;
    alias mongoc_socklen_t = int;
    alias mongoc_socket_t = _mongoc_socket_t;
    struct _mongoc_socket_t;
    struct mongoc_socket_poll_t
    {
        _mongoc_socket_t* socket;
        int events;
        int revents;
    }
    _mongoc_socket_t* mongoc_socket_accept(_mongoc_socket_t*, long) @nogc nothrow;
    int mongoc_socket_bind(_mongoc_socket_t*, const(sockaddr)*, int) @nogc nothrow;
    int mongoc_socket_close(_mongoc_socket_t*) @nogc nothrow;
    int mongoc_socket_connect(_mongoc_socket_t*, const(sockaddr)*, int, long) @nogc nothrow;
    char* mongoc_socket_getnameinfo(_mongoc_socket_t*) @nogc nothrow;
    void mongoc_socket_destroy(_mongoc_socket_t*) @nogc nothrow;
    int mongoc_socket_errno(_mongoc_socket_t*) @nogc nothrow;
    int mongoc_socket_getsockname(_mongoc_socket_t*, sockaddr*, int*) @nogc nothrow;
    int mongoc_socket_listen(_mongoc_socket_t*, uint) @nogc nothrow;
    _mongoc_socket_t* mongoc_socket_new(int, int, int) @nogc nothrow;
    long mongoc_socket_recv(_mongoc_socket_t*, void*, ulong, int, long) @nogc nothrow;
    int mongoc_socket_setsockopt(_mongoc_socket_t*, int, int, const(void)*, int) @nogc nothrow;
    long mongoc_socket_send(_mongoc_socket_t*, const(void)*, ulong, long) @nogc nothrow;
    long mongoc_socket_sendv(_mongoc_socket_t*, mongoc_iovec_t*, ulong, long) @nogc nothrow;
    byte mongoc_socket_check_closed(_mongoc_socket_t*) @nogc nothrow;
    void mongoc_socket_inet_ntop(addrinfo*, char*, ulong) @nogc nothrow;
    long mongoc_socket_poll(mongoc_socket_poll_t*, ulong, int) @nogc nothrow;
    alias mongoc_ssl_opt_t = _mongoc_ssl_opt_t;
    struct _mongoc_ssl_opt_t
    {
        const(char)* pem_file;
        const(char)* pem_pwd;
        const(char)* ca_file;
        const(char)* ca_dir;
        const(char)* crl_file;
        byte weak_cert_validation;
        byte allow_invalid_hostname;
        void*[7] padding;
    }
    const(_mongoc_ssl_opt_t)* mongoc_ssl_opt_get_default() @nogc nothrow;
    _mongoc_stream_t* mongoc_stream_buffered_new(_mongoc_stream_t*, ulong) @nogc nothrow;
    alias mongoc_stream_file_t = _mongoc_stream_file_t;
    struct _mongoc_stream_file_t;
    _mongoc_stream_t* mongoc_stream_file_new(int) @nogc nothrow;
    _mongoc_stream_t* mongoc_stream_file_new_for_path(const(char)*, int, int) @nogc nothrow;
    int mongoc_stream_file_get_fd(_mongoc_stream_file_t*) @nogc nothrow;
    _mongoc_stream_t* mongoc_stream_gridfs_new(_mongoc_gridfs_file_t*) @nogc nothrow;
    alias mongoc_stream_socket_t = _mongoc_stream_socket_t;
    struct _mongoc_stream_socket_t;
    _mongoc_stream_t* mongoc_stream_socket_new(_mongoc_socket_t*) @nogc nothrow;
    _mongoc_socket_t* mongoc_stream_socket_get_socket(_mongoc_stream_socket_t*) @nogc nothrow;
    alias mongoc_stream_tls_t = _mongoc_stream_tls_t;
    struct _mongoc_stream_tls_t;
    byte mongoc_stream_tls_handshake(_mongoc_stream_t*, const(char)*, int, int*, _bson_error_t*) @nogc nothrow;
    byte mongoc_stream_tls_handshake_block(_mongoc_stream_t*, const(char)*, int, _bson_error_t*) @nogc nothrow;
    byte mongoc_stream_tls_do_handshake(_mongoc_stream_t*, int) @nogc nothrow;
    byte mongoc_stream_tls_check_cert(_mongoc_stream_t*, const(char)*) @nogc nothrow;
    _mongoc_stream_t* mongoc_stream_tls_new_with_hostname(_mongoc_stream_t*, const(char)*, _mongoc_ssl_opt_t*, int) @nogc nothrow;
    _mongoc_stream_t* mongoc_stream_tls_new(_mongoc_stream_t*, _mongoc_ssl_opt_t*, int) @nogc nothrow;
    alias mongoc_stream_t = _mongoc_stream_t;
    struct _mongoc_stream_t
    {
        int type;
        void function(_mongoc_stream_t*) destroy;
        int function(_mongoc_stream_t*) close;
        int function(_mongoc_stream_t*) flush;
        long function(_mongoc_stream_t*, mongoc_iovec_t*, ulong, int) writev;
        long function(_mongoc_stream_t*, mongoc_iovec_t*, ulong, ulong, int) readv;
        int function(_mongoc_stream_t*, int, int, void*, int) setsockopt;
        _mongoc_stream_t* function(_mongoc_stream_t*) get_base_stream;
        byte function(_mongoc_stream_t*) check_closed;
        long function(_mongoc_stream_poll_t*, ulong, int) poll;
        void function(_mongoc_stream_t*) failed;
        byte function(_mongoc_stream_t*) timed_out;
        byte function(_mongoc_stream_t*) should_retry;
        void*[3] padding;
    }
    alias mongoc_stream_poll_t = _mongoc_stream_poll_t;
    struct _mongoc_stream_poll_t
    {
        _mongoc_stream_t* stream;
        int events;
        int revents;
    }
    _mongoc_stream_t* mongoc_stream_get_base_stream(_mongoc_stream_t*) @nogc nothrow;
    _mongoc_stream_t* mongoc_stream_get_tls_stream(_mongoc_stream_t*) @nogc nothrow;
    int mongoc_stream_close(_mongoc_stream_t*) @nogc nothrow;
    void mongoc_stream_destroy(_mongoc_stream_t*) @nogc nothrow;
    void mongoc_stream_failed(_mongoc_stream_t*) @nogc nothrow;
    int mongoc_stream_flush(_mongoc_stream_t*) @nogc nothrow;
    long mongoc_stream_writev(_mongoc_stream_t*, mongoc_iovec_t*, ulong, int) @nogc nothrow;
    long mongoc_stream_write(_mongoc_stream_t*, void*, ulong, int) @nogc nothrow;
    long mongoc_stream_readv(_mongoc_stream_t*, mongoc_iovec_t*, ulong, ulong, int) @nogc nothrow;
    long mongoc_stream_read(_mongoc_stream_t*, void*, ulong, ulong, int) @nogc nothrow;
    int mongoc_stream_setsockopt(_mongoc_stream_t*, int, int, void*, int) @nogc nothrow;
    byte mongoc_stream_check_closed(_mongoc_stream_t*) @nogc nothrow;
    byte mongoc_stream_timed_out(_mongoc_stream_t*) @nogc nothrow;
    byte mongoc_stream_should_retry(_mongoc_stream_t*) @nogc nothrow;
    long mongoc_stream_poll(_mongoc_stream_poll_t*, ulong, int) @nogc nothrow;
    alias mongoc_topology_description_t = _mongoc_topology_description_t;
    struct _mongoc_topology_description_t;
    byte mongoc_topology_description_has_readable_server(_mongoc_topology_description_t*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    byte mongoc_topology_description_has_writable_server(_mongoc_topology_description_t*) @nogc nothrow;
    const(char)* mongoc_topology_description_type(const(_mongoc_topology_description_t)*) @nogc nothrow;
    _mongoc_server_description_t** mongoc_topology_description_get_servers(const(_mongoc_topology_description_t)*, ulong*) @nogc nothrow;
    alias mongoc_uri_t = _mongoc_uri_t;
    struct _mongoc_uri_t;
    _mongoc_uri_t* mongoc_uri_copy(const(_mongoc_uri_t)*) @nogc nothrow;
    void mongoc_uri_destroy(_mongoc_uri_t*) @nogc nothrow;
    _mongoc_uri_t* mongoc_uri_new(const(char)*) @nogc nothrow;
    _mongoc_uri_t* mongoc_uri_new_with_error(const(char)*, _bson_error_t*) @nogc nothrow;
    _mongoc_uri_t* mongoc_uri_new_for_host_port(const(char)*, ushort) @nogc nothrow;
    const(_mongoc_host_list_t)* mongoc_uri_get_hosts(const(_mongoc_uri_t)*) @nogc nothrow;
    const(char)* mongoc_uri_get_service(const(_mongoc_uri_t)*) @nogc nothrow;
    const(char)* mongoc_uri_get_database(const(_mongoc_uri_t)*) @nogc nothrow;
    byte mongoc_uri_set_database(_mongoc_uri_t*, const(char)*) @nogc nothrow;
    const(_bson_t)* mongoc_uri_get_compressors(const(_mongoc_uri_t)*) @nogc nothrow;
    const(_bson_t)* mongoc_uri_get_options(const(_mongoc_uri_t)*) @nogc nothrow;
    const(char)* mongoc_uri_get_password(const(_mongoc_uri_t)*) @nogc nothrow;
    byte mongoc_uri_set_password(_mongoc_uri_t*, const(char)*) @nogc nothrow;
    byte mongoc_uri_option_is_int32(const(char)*) @nogc nothrow;
    byte mongoc_uri_option_is_bool(const(char)*) @nogc nothrow;
    byte mongoc_uri_option_is_utf8(const(char)*) @nogc nothrow;
    int mongoc_uri_get_option_as_int32(const(_mongoc_uri_t)*, const(char)*, int) @nogc nothrow;
    byte mongoc_uri_get_option_as_bool(const(_mongoc_uri_t)*, const(char)*, byte) @nogc nothrow;
    const(char)* mongoc_uri_get_option_as_utf8(const(_mongoc_uri_t)*, const(char)*, const(char)*) @nogc nothrow;
    byte mongoc_uri_set_option_as_int32(_mongoc_uri_t*, const(char)*, int) @nogc nothrow;
    byte mongoc_uri_set_option_as_bool(_mongoc_uri_t*, const(char)*, byte) @nogc nothrow;
    byte mongoc_uri_set_option_as_utf8(_mongoc_uri_t*, const(char)*, const(char)*) @nogc nothrow;
    const(_bson_t)* mongoc_uri_get_read_prefs(const(_mongoc_uri_t)*) @nogc nothrow;
    const(char)* mongoc_uri_get_replica_set(const(_mongoc_uri_t)*) @nogc nothrow;
    const(char)* mongoc_uri_get_string(const(_mongoc_uri_t)*) @nogc nothrow;
    const(char)* mongoc_uri_get_username(const(_mongoc_uri_t)*) @nogc nothrow;
    byte mongoc_uri_set_username(_mongoc_uri_t*, const(char)*) @nogc nothrow;
    const(_bson_t)* mongoc_uri_get_credentials(const(_mongoc_uri_t)*) @nogc nothrow;
    const(char)* mongoc_uri_get_auth_source(const(_mongoc_uri_t)*) @nogc nothrow;
    byte mongoc_uri_set_auth_source(_mongoc_uri_t*, const(char)*) @nogc nothrow;
    const(char)* mongoc_uri_get_appname(const(_mongoc_uri_t)*) @nogc nothrow;
    byte mongoc_uri_set_appname(_mongoc_uri_t*, const(char)*) @nogc nothrow;
    byte mongoc_uri_set_compressors(_mongoc_uri_t*, const(char)*) @nogc nothrow;
    const(char)* mongoc_uri_get_auth_mechanism(const(_mongoc_uri_t)*) @nogc nothrow;
    byte mongoc_uri_set_auth_mechanism(_mongoc_uri_t*, const(char)*) @nogc nothrow;
    byte mongoc_uri_get_mechanism_properties(const(_mongoc_uri_t)*, _bson_t*) @nogc nothrow;
    byte mongoc_uri_set_mechanism_properties(_mongoc_uri_t*, const(_bson_t)*) @nogc nothrow;
    byte mongoc_uri_get_ssl(const(_mongoc_uri_t)*) @nogc nothrow;
    byte mongoc_uri_get_tls(const(_mongoc_uri_t)*) @nogc nothrow;
    char* mongoc_uri_unescape(const(char)*) @nogc nothrow;
    const(_mongoc_read_prefs_t)* mongoc_uri_get_read_prefs_t(const(_mongoc_uri_t)*) @nogc nothrow;
    void mongoc_uri_set_read_prefs_t(_mongoc_uri_t*, const(_mongoc_read_prefs_t)*) @nogc nothrow;
    const(_mongoc_write_concern_t)* mongoc_uri_get_write_concern(const(_mongoc_uri_t)*) @nogc nothrow;
    void mongoc_uri_set_write_concern(_mongoc_uri_t*, const(_mongoc_write_concern_t)*) @nogc nothrow;
    const(_mongoc_read_concern_t)* mongoc_uri_get_read_concern(const(_mongoc_uri_t)*) @nogc nothrow;
    void mongoc_uri_set_read_concern(_mongoc_uri_t*, const(_mongoc_read_concern_t)*) @nogc nothrow;
    int mongoc_get_major_version() @nogc nothrow;
    int mongoc_get_minor_version() @nogc nothrow;
    int mongoc_get_micro_version() @nogc nothrow;
    const(char)* mongoc_get_version() @nogc nothrow;
    byte mongoc_check_version(int, int, int) @nogc nothrow;
    alias mongoc_write_concern_t = _mongoc_write_concern_t;
    struct _mongoc_write_concern_t;
    _mongoc_write_concern_t* mongoc_write_concern_new() @nogc nothrow;
    _mongoc_write_concern_t* mongoc_write_concern_copy(const(_mongoc_write_concern_t)*) @nogc nothrow;
    void mongoc_write_concern_destroy(_mongoc_write_concern_t*) @nogc nothrow;
    byte mongoc_write_concern_get_fsync(const(_mongoc_write_concern_t)*) @nogc nothrow;
    void mongoc_write_concern_set_fsync(_mongoc_write_concern_t*, byte) @nogc nothrow;
    byte mongoc_write_concern_get_journal(const(_mongoc_write_concern_t)*) @nogc nothrow;
    byte mongoc_write_concern_journal_is_set(const(_mongoc_write_concern_t)*) @nogc nothrow;
    void mongoc_write_concern_set_journal(_mongoc_write_concern_t*, byte) @nogc nothrow;
    int mongoc_write_concern_get_w(const(_mongoc_write_concern_t)*) @nogc nothrow;
    void mongoc_write_concern_set_w(_mongoc_write_concern_t*, int) @nogc nothrow;
    const(char)* mongoc_write_concern_get_wtag(const(_mongoc_write_concern_t)*) @nogc nothrow;
    void mongoc_write_concern_set_wtag(_mongoc_write_concern_t*, const(char)*) @nogc nothrow;
    int mongoc_write_concern_get_wtimeout(const(_mongoc_write_concern_t)*) @nogc nothrow;
    long mongoc_write_concern_get_wtimeout_int64(const(_mongoc_write_concern_t)*) @nogc nothrow;
    void mongoc_write_concern_set_wtimeout(_mongoc_write_concern_t*, int) @nogc nothrow;
    void mongoc_write_concern_set_wtimeout_int64(_mongoc_write_concern_t*, long) @nogc nothrow;
    byte mongoc_write_concern_get_wmajority(const(_mongoc_write_concern_t)*) @nogc nothrow;
    void mongoc_write_concern_set_wmajority(_mongoc_write_concern_t*, int) @nogc nothrow;
    byte mongoc_write_concern_is_acknowledged(const(_mongoc_write_concern_t)*) @nogc nothrow;
    byte mongoc_write_concern_is_valid(const(_mongoc_write_concern_t)*) @nogc nothrow;
    byte mongoc_write_concern_append(_mongoc_write_concern_t*, _bson_t*) @nogc nothrow;
    byte mongoc_write_concern_is_default(const(_mongoc_write_concern_t)*) @nogc nothrow;
    static if(!is(typeof(MONGOC_WRITE_CONCERN_W_UNACKNOWLEDGED))) {
        enum MONGOC_WRITE_CONCERN_W_UNACKNOWLEDGED = 0;
    }
    static if(!is(typeof(MONGOC_VERSION_S))) {
        enum MONGOC_VERSION_S = "1.15.1";
    }
    static if(!is(typeof(MONGOC_URI_SSLALLOWINVALIDHOSTNAMES))) {
        enum MONGOC_URI_SSLALLOWINVALIDHOSTNAMES = "sslallowinvalidhostnames";
    }




    static if(!is(typeof(MONGOC_URI_SSLALLOWINVALIDCERTIFICATES))) {
        enum MONGOC_URI_SSLALLOWINVALIDCERTIFICATES = "sslallowinvalidcertificates";
    }




    static if(!is(typeof(MONGOC_URI_SSLCERTIFICATEAUTHORITYFILE))) {
        enum MONGOC_URI_SSLCERTIFICATEAUTHORITYFILE = "sslcertificateauthorityfile";
    }




    static if(!is(typeof(MONGOC_URI_SSLCLIENTCERTIFICATEKEYPASSWORD))) {
        enum MONGOC_URI_SSLCLIENTCERTIFICATEKEYPASSWORD = "sslclientcertificatekeypassword";
    }




    static if(!is(typeof(MONGOC_URI_SSLCLIENTCERTIFICATEKEYFILE))) {
        enum MONGOC_URI_SSLCLIENTCERTIFICATEKEYFILE = "sslclientcertificatekeyfile";
    }




    static if(!is(typeof(MONGOC_URI_SSL))) {
        enum MONGOC_URI_SSL = "ssl";
    }




    static if(!is(typeof(MONGOC_URI_ZLIBCOMPRESSIONLEVEL))) {
        enum MONGOC_URI_ZLIBCOMPRESSIONLEVEL = "zlibcompressionlevel";
    }




    static if(!is(typeof(MONGOC_URI_WTIMEOUTMS))) {
        enum MONGOC_URI_WTIMEOUTMS = "wtimeoutms";
    }




    static if(!is(typeof(MONGOC_URI_WAITQUEUETIMEOUTMS))) {
        enum MONGOC_URI_WAITQUEUETIMEOUTMS = "waitqueuetimeoutms";
    }




    static if(!is(typeof(MONGOC_URI_WAITQUEUEMULTIPLE))) {
        enum MONGOC_URI_WAITQUEUEMULTIPLE = "waitqueuemultiple";
    }




    static if(!is(typeof(MONGOC_URI_W))) {
        enum MONGOC_URI_W = "w";
    }




    static if(!is(typeof(MONGOC_URI_TLSINSECURE))) {
        enum MONGOC_URI_TLSINSECURE = "tlsinsecure";
    }




    static if(!is(typeof(MONGOC_URI_TLSALLOWINVALIDHOSTNAMES))) {
        enum MONGOC_URI_TLSALLOWINVALIDHOSTNAMES = "tlsallowinvalidhostnames";
    }




    static if(!is(typeof(MONGOC_URI_TLSALLOWINVALIDCERTIFICATES))) {
        enum MONGOC_URI_TLSALLOWINVALIDCERTIFICATES = "tlsallowinvalidcertificates";
    }




    static if(!is(typeof(MONGOC_URI_TLSCAFILE))) {
        enum MONGOC_URI_TLSCAFILE = "tlscafile";
    }




    static if(!is(typeof(MONGOC_URI_TLSCERTIFICATEKEYFILEPASSWORD))) {
        enum MONGOC_URI_TLSCERTIFICATEKEYFILEPASSWORD = "tlscertificatekeyfilepassword";
    }




    static if(!is(typeof(MONGOC_URI_TLSCERTIFICATEKEYFILE))) {
        enum MONGOC_URI_TLSCERTIFICATEKEYFILE = "tlscertificatekeyfile";
    }




    static if(!is(typeof(MONGOC_URI_TLS))) {
        enum MONGOC_URI_TLS = "tls";
    }




    static if(!is(typeof(MONGOC_URI_SOCKETTIMEOUTMS))) {
        enum MONGOC_URI_SOCKETTIMEOUTMS = "sockettimeoutms";
    }




    static if(!is(typeof(MONGOC_URI_SOCKETCHECKINTERVALMS))) {
        enum MONGOC_URI_SOCKETCHECKINTERVALMS = "socketcheckintervalms";
    }




    static if(!is(typeof(MONGOC_URI_SLAVEOK))) {
        enum MONGOC_URI_SLAVEOK = "slaveok";
    }




    static if(!is(typeof(MONGOC_URI_SERVERSELECTIONTRYONCE))) {
        enum MONGOC_URI_SERVERSELECTIONTRYONCE = "serverselectiontryonce";
    }




    static if(!is(typeof(MONGOC_URI_SERVERSELECTIONTIMEOUTMS))) {
        enum MONGOC_URI_SERVERSELECTIONTIMEOUTMS = "serverselectiontimeoutms";
    }




    static if(!is(typeof(MONGOC_URI_SAFE))) {
        enum MONGOC_URI_SAFE = "safe";
    }




    static if(!is(typeof(MONGOC_URI_RETRYWRITES))) {
        enum MONGOC_URI_RETRYWRITES = "retrywrites";
    }




    static if(!is(typeof(MONGOC_URI_RETRYREADS))) {
        enum MONGOC_URI_RETRYREADS = "retryreads";
    }




    static if(!is(typeof(MONGOC_URI_REPLICASET))) {
        enum MONGOC_URI_REPLICASET = "replicaset";
    }




    static if(!is(typeof(MONGOC_URI_READPREFERENCETAGS))) {
        enum MONGOC_URI_READPREFERENCETAGS = "readpreferencetags";
    }




    static if(!is(typeof(MONGOC_URI_READPREFERENCE))) {
        enum MONGOC_URI_READPREFERENCE = "readpreference";
    }




    static if(!is(typeof(MONGOC_URI_READCONCERNLEVEL))) {
        enum MONGOC_URI_READCONCERNLEVEL = "readconcernlevel";
    }




    static if(!is(typeof(MONGOC_URI_MINPOOLSIZE))) {
        enum MONGOC_URI_MINPOOLSIZE = "minpoolsize";
    }




    static if(!is(typeof(MONGOC_URI_MAXSTALENESSSECONDS))) {
        enum MONGOC_URI_MAXSTALENESSSECONDS = "maxstalenessseconds";
    }




    static if(!is(typeof(MONGOC_URI_MAXPOOLSIZE))) {
        enum MONGOC_URI_MAXPOOLSIZE = "maxpoolsize";
    }




    static if(!is(typeof(MONGOC_URI_MAXIDLETIMEMS))) {
        enum MONGOC_URI_MAXIDLETIMEMS = "maxidletimems";
    }




    static if(!is(typeof(MONGOC_URI_LOCALTHRESHOLDMS))) {
        enum MONGOC_URI_LOCALTHRESHOLDMS = "localthresholdms";
    }




    static if(!is(typeof(MONGOC_URI_JOURNAL))) {
        enum MONGOC_URI_JOURNAL = "journal";
    }




    static if(!is(typeof(MONGOC_URI_HEARTBEATFREQUENCYMS))) {
        enum MONGOC_URI_HEARTBEATFREQUENCYMS = "heartbeatfrequencyms";
    }




    static if(!is(typeof(MONGOC_URI_GSSAPISERVICENAME))) {
        enum MONGOC_URI_GSSAPISERVICENAME = "gssapiservicename";
    }




    static if(!is(typeof(MONGOC_URI_COMPRESSORS))) {
        enum MONGOC_URI_COMPRESSORS = "compressors";
    }




    static if(!is(typeof(MONGOC_URI_CONNECTTIMEOUTMS))) {
        enum MONGOC_URI_CONNECTTIMEOUTMS = "connecttimeoutms";
    }




    static if(!is(typeof(MONGOC_URI_CANONICALIZEHOSTNAME))) {
        enum MONGOC_URI_CANONICALIZEHOSTNAME = "canonicalizehostname";
    }




    static if(!is(typeof(MONGOC_URI_AUTHSOURCE))) {
        enum MONGOC_URI_AUTHSOURCE = "authsource";
    }




    static if(!is(typeof(MONGOC_URI_AUTHMECHANISMPROPERTIES))) {
        enum MONGOC_URI_AUTHMECHANISMPROPERTIES = "authmechanismproperties";
    }




    static if(!is(typeof(MONGOC_URI_AUTHMECHANISM))) {
        enum MONGOC_URI_AUTHMECHANISM = "authmechanism";
    }




    static if(!is(typeof(MONGOC_URI_APPNAME))) {
        enum MONGOC_URI_APPNAME = "appname";
    }




    static if(!is(typeof(MONGOC_DEFAULT_PORT))) {
        enum MONGOC_DEFAULT_PORT = 27017;
    }
    static if(!is(typeof(MONGOC_SMALLEST_MAX_STALENESS_SECONDS))) {
        enum MONGOC_SMALLEST_MAX_STALENESS_SECONDS = 90;
    }
    static if(!is(typeof(MONGOC_READ_CONCERN_LEVEL_SNAPSHOT))) {
        enum MONGOC_READ_CONCERN_LEVEL_SNAPSHOT = "snapshot";
    }




    static if(!is(typeof(MONGOC_READ_CONCERN_LEVEL_LINEARIZABLE))) {
        enum MONGOC_READ_CONCERN_LEVEL_LINEARIZABLE = "linearizable";
    }




    static if(!is(typeof(MONGOC_READ_CONCERN_LEVEL_MAJORITY))) {
        enum MONGOC_READ_CONCERN_LEVEL_MAJORITY = "majority";
    }




    static if(!is(typeof(MONGOC_READ_CONCERN_LEVEL_LOCAL))) {
        enum MONGOC_READ_CONCERN_LEVEL_LOCAL = "local";
    }




    static if(!is(typeof(MONGOC_READ_CONCERN_LEVEL_AVAILABLE))) {
        enum MONGOC_READ_CONCERN_LEVEL_AVAILABLE = "available";
    }
    static if(!is(typeof(MONGOC_LOG_DOMAIN))) {
        enum MONGOC_LOG_DOMAIN = "mongoc";
    }
    static if(!is(typeof(BSON_HOST_NAME_MAX))) {
        enum BSON_HOST_NAME_MAX = 255;
    }






    static if(!is(typeof(MONGOC_HANDSHAKE_APPNAME_MAX))) {
        enum MONGOC_HANDSHAKE_APPNAME_MAX = 128;
    }
    static if(!is(typeof(MONGOC_ERROR_API_VERSION_2))) {
        enum MONGOC_ERROR_API_VERSION_2 = 2;
    }




    static if(!is(typeof(MONGOC_ERROR_API_VERSION_LEGACY))) {
        enum MONGOC_ERROR_API_VERSION_LEGACY = 1;
    }
    static if(!is(typeof(MONGOC_ENABLE_ICU))) {
        enum MONGOC_ENABLE_ICU = 0;
    }




    static if(!is(typeof(MONGOC_TRACE))) {
        enum MONGOC_TRACE = 0;
    }




    static if(!is(typeof(MONGOC_HAVE_SCHED_GETCPU))) {
        enum MONGOC_HAVE_SCHED_GETCPU = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_RDTSCP))) {
        enum MONGOC_ENABLE_RDTSCP = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_SHM_COUNTERS))) {
        enum MONGOC_ENABLE_SHM_COUNTERS = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_COMPRESSION_ZSTD))) {
        enum MONGOC_ENABLE_COMPRESSION_ZSTD = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_COMPRESSION_ZLIB))) {
        enum MONGOC_ENABLE_COMPRESSION_ZLIB = 1;
    }




    static if(!is(typeof(MONGOC_ENABLE_COMPRESSION_SNAPPY))) {
        enum MONGOC_ENABLE_COMPRESSION_SNAPPY = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_COMPRESSION))) {
        enum MONGOC_ENABLE_COMPRESSION = 1;
    }
    static if(!is(typeof(MONGOC_HAVE_RES_SEARCH))) {
        enum MONGOC_HAVE_RES_SEARCH = 0;
    }




    static if(!is(typeof(MONGOC_HAVE_RES_NCLOSE))) {
        enum MONGOC_HAVE_RES_NCLOSE = 0;
    }




    static if(!is(typeof(MONGOC_HAVE_RES_NDESTROY))) {
        enum MONGOC_HAVE_RES_NDESTROY = 0;
    }




    static if(!is(typeof(MONGOC_HAVE_RES_NSEARCH))) {
        enum MONGOC_HAVE_RES_NSEARCH = 0;
    }




    static if(!is(typeof(MONGOC_HAVE_DNSAPI))) {
        enum MONGOC_HAVE_DNSAPI = 1;
    }




    static if(!is(typeof(MONGOC_HAVE_SOCKLEN))) {
        enum MONGOC_HAVE_SOCKLEN = 1;
    }




    static if(!is(typeof(MONGOC_NO_AUTOMATIC_GLOBALS))) {
        enum MONGOC_NO_AUTOMATIC_GLOBALS = 0;
    }




    static if(!is(typeof(MONGOC_HAVE_SASL_CLIENT_DONE))) {
        enum MONGOC_HAVE_SASL_CLIENT_DONE = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_SASL_SSPI))) {
        enum MONGOC_ENABLE_SASL_SSPI = 1;
    }




    static if(!is(typeof(MONGOC_ENABLE_SASL_CYRUS))) {
        enum MONGOC_ENABLE_SASL_CYRUS = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_SASL))) {
        enum MONGOC_ENABLE_SASL = 1;
    }




    static if(!is(typeof(MONGOC_HAVE_ASN1_STRING_GET0_DATA))) {
        enum MONGOC_HAVE_ASN1_STRING_GET0_DATA = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_CRYPTO_SYSTEM_PROFILE))) {
        enum MONGOC_ENABLE_CRYPTO_SYSTEM_PROFILE = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_CRYPTO))) {
        enum MONGOC_ENABLE_CRYPTO = 1;
    }




    static if(!is(typeof(MONGOC_ENABLE_SSL))) {
        enum MONGOC_ENABLE_SSL = 1;
    }




    static if(!is(typeof(MONGOC_ENABLE_CRYPTO_LIBCRYPTO))) {
        enum MONGOC_ENABLE_CRYPTO_LIBCRYPTO = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_SSL_OPENSSL))) {
        enum MONGOC_ENABLE_SSL_OPENSSL = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_SSL_LIBRESSL))) {
        enum MONGOC_ENABLE_SSL_LIBRESSL = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_CRYPTO_COMMON_CRYPTO))) {
        enum MONGOC_ENABLE_CRYPTO_COMMON_CRYPTO = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_SSL_SECURE_TRANSPORT))) {
        enum MONGOC_ENABLE_SSL_SECURE_TRANSPORT = 0;
    }




    static if(!is(typeof(MONGOC_ENABLE_CRYPTO_CNG))) {
        enum MONGOC_ENABLE_CRYPTO_CNG = 1;
    }




    static if(!is(typeof(MONGOC_ENABLE_SSL_SECURE_CHANNEL))) {
        enum MONGOC_ENABLE_SSL_SECURE_CHANNEL = 1;
    }




    static if(!is(typeof(MONGOC_CC))) {
        enum MONGOC_CC = "C:/Program Files (x86)/Microsoft Visual Studio 12.0/VC/bin/x86_amd64/cl.exe";
    }




    static if(!is(typeof(MONGOC_USER_SET_LDFLAGS))) {
        enum MONGOC_USER_SET_LDFLAGS = "/machine:x64";
    }




    static if(!is(typeof(MONGOC_USER_SET_CFLAGS))) {
        enum MONGOC_USER_SET_CFLAGS = "/DWIN32 /D_WINDOWS /W3";
    }
    static if(!is(typeof(MONGOC_NAMESPACE_MAX))) {
        enum MONGOC_NAMESPACE_MAX = 128;
    }
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


struct addrinfo;
struct timeval;
struct sockaddr;
mixin dpp.EnumD!("DeleteFlags",mongoc_delete_flags_t,"MONGOC_DELETE_");

mixin dpp.EnumD!("RemoveFlags",mongoc_remove_flags_t,"MONGOC_REMOVE_");

mixin dpp.EnumD!("InsertFlags",mongoc_insert_flags_t,"MONGOC_INSERT_");

mixin dpp.EnumD!("QueryFlags",mongoc_query_flags_t,"MONGOC_QUERY_");

mixin dpp.EnumD!("ReplyFlags",mongoc_reply_flags_t,"MONGOC_REPLY_");

mixin dpp.EnumD!("UpdateFlags",mongoc_update_flags_t,"MONGOC_UPDATE_");
