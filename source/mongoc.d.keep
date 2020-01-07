// This file was auto-generated. Don't change it.
// mongo-c-driver version: 1.8.0
// libbson version: 1.7.0

import core.stdc.stdio;
import core.sys.posix.unistd;
import core.sys.posix.netdb;

extern (C): 

// libbson stuffs --->


bson_context_t* bson_context_get_default ();

void bson_context_destroy (bson_context_t* context);


bson_t* bson_new_from_json (
    const(ubyte)* data,
    ssize_t len,
    bson_error_t* error);


char* bson_as_json (const(bson_t)* bson, size_t* length);


void bson_destroy (bson_t* bson);


const(ubyte)* bson_get_data (const(bson_t)* bson);


bson_t* bson_new_from_data (const(ubyte)* data, size_t length);


bool bson_init_static (bson_t* b, const(ubyte)* data, size_t length);

void bson_oid_init (bson_oid_t* oid, bson_context_t* context);

void bson_strfreev (char** strv);
// libbson data struct --->
extern (C):

alias bson_unichar_t = uint;

enum bson_context_flags_t
{
    BSON_CONTEXT_NONE = 0,
    BSON_CONTEXT_THREAD_SAFE = 1,
    BSON_CONTEXT_DISABLE_HOST_CACHE = 2,
    BSON_CONTEXT_DISABLE_PID_CACHE = 4,

    BSON_CONTEXT_USE_TASK_ID = 8
}

struct _bson_context_t;
alias bson_context_t = _bson_context_t;

struct _bson_t
{
    uint flags;
    uint len;
    ubyte[120] padding;
}

alias bson_t = _bson_t;

alias static_assert_test_149 = char[1];

struct bson_oid_t
{
    ubyte[12] bytes;
}

alias static_assert_test_163 = char[1];

struct bson_decimal128_t
{
    ulong low;
    ulong high;
}

enum bson_validate_flags_t
{
    BSON_VALIDATE_NONE = 0,
    BSON_VALIDATE_UTF8 = 1,
    BSON_VALIDATE_DOLLAR_KEYS = 2,
    BSON_VALIDATE_DOT_KEYS = 4,
    BSON_VALIDATE_UTF8_ALLOW_NULL = 8,
    BSON_VALIDATE_EMPTY_KEYS = 16
}

enum bson_type_t
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
    BSON_TYPE_MINKEY = 255
}

enum bson_subtype_t
{
    BSON_SUBTYPE_BINARY = 0,
    BSON_SUBTYPE_FUNCTION = 1,
    BSON_SUBTYPE_BINARY_DEPRECATED = 2,
    BSON_SUBTYPE_UUID_DEPRECATED = 3,
    BSON_SUBTYPE_UUID = 4,
    BSON_SUBTYPE_MD5 = 5,
    BSON_SUBTYPE_USER = 128
}

struct _bson_value_t;
// IGN struct _bson_value_t
// IGN {
// IGN     bson_type_t value_type;
// IGN     int padding;
// IGN 
// IGN     union _Anonymous_0
// IGN     {
// IGN         bson_oid_t v_oid;
// IGN         long v_int64;
// IGN         int v_int32;
// IGN         byte v_int8;
// IGN         double v_double;
// IGN         bool v_bool;
// IGN         long v_datetime;
// IGN 
// IGN         struct _Anonymous_1
// IGN         {
// IGN             uint timestamp;
// IGN             uint increment;
// IGN         }
// IGN 
// IGN         _Anonymous_1 v_timestamp;
// IGN 
// IGN         struct _Anonymous_2
// IGN         {
// IGN             char* str;
// IGN             uint len;
// IGN         }
// IGN 
// IGN         _Anonymous_2 v_utf8;
// IGN 
// IGN         struct _Anonymous_3
// IGN         {
// IGN             ubyte* data;
// IGN             uint data_len;
// IGN         }
// IGN 
// IGN         _Anonymous_3 v_doc;
// IGN 
// IGN         struct _Anonymous_4
// IGN         {
// IGN             ubyte* data;
// IGN             uint data_len;
// IGN             bson_subtype_t subtype;
// IGN         }
// IGN 
// IGN         _Anonymous_4 v_binary;
// IGN 
// IGN         struct _Anonymous_5
// IGN         {
// IGN             char* regex;
// IGN             char* options;
// IGN         }
// IGN 
// IGN         _Anonymous_5 v_regex;
// IGN 
// IGN         struct _Anonymous_6
// IGN         {
// IGN             char* collection;
// IGN             uint collection_len;
// IGN             bson_oid_t oid;
// IGN         }
// IGN 
// IGN         _Anonymous_6 v_dbpointer;
// IGN 
// IGN         struct _Anonymous_7
// IGN         {
// IGN             char* code;
// IGN             uint code_len;
// IGN         }
// IGN 
// IGN         _Anonymous_7 v_code;
// IGN 
// IGN         struct _Anonymous_8
// IGN         {
// IGN             char* code;
// IGN             ubyte* scope_data;
// IGN             uint code_len;
// IGN             uint scope_len;
// IGN         }
// IGN 
// IGN         _Anonymous_8 v_codewscope;
// IGN 
// IGN         struct _Anonymous_9
// IGN         {
// IGN             char* symbol;
// IGN             uint len;
// IGN         }
// IGN 
// IGN         _Anonymous_9 v_symbol;
// IGN         bson_decimal128_t v_decimal128;
// IGN     }
// IGN 
// IGN     _Anonymous_0 value;
// IGN }

alias bson_value_t = _bson_value_t;

struct bson_iter_t;
// IGN struct bson_iter_t
// IGN {
// IGN     const(ubyte)* raw;
// IGN     uint len;
// IGN     uint off;
// IGN     uint type;
// IGN     uint key;
// IGN     uint d1;
// IGN     uint d2;
// IGN     uint d3;
// IGN     uint d4;
// IGN     uint next_off;
// IGN     uint err_off;
// IGN     bson_value_t value;
// IGN }

struct bson_reader_t
{
    uint type;
}

struct bson_visitor_t
{
    bool function (const(bson_iter_t)* iter, const(char)* key, void* data) visit_before;
    bool function (const(bson_iter_t)* iter, const(char)* key, void* data) visit_after;

    void function (const(bson_iter_t)* iter, void* data) visit_corrupt;

    bool function (const(bson_iter_t)* iter, const(char)* key, double v_double, void* data) visit_double;
    bool function (const(bson_iter_t)* iter, const(char)* key, size_t v_utf8_len, const(char)* v_utf8, void* data) visit_utf8;
    bool function (const(bson_iter_t)* iter, const(char)* key, const(bson_t)* v_document, void* data) visit_document;
    bool function (const(bson_iter_t)* iter, const(char)* key, const(bson_t)* v_array, void* data) visit_array;
    bool function (const(bson_iter_t)* iter, const(char)* key, bson_subtype_t v_subtype, size_t v_binary_len, const(ubyte)* v_binary, void* data) visit_binary;

    bool function (const(bson_iter_t)* iter, const(char)* key, void* data) visit_undefined;
    bool function (const(bson_iter_t)* iter, const(char)* key, const(bson_oid_t)* v_oid, void* data) visit_oid;
    bool function (const(bson_iter_t)* iter, const(char)* key, bool v_bool, void* data) visit_bool;
    bool function (const(bson_iter_t)* iter, const(char)* key, long msec_since_epoch, void* data) visit_date_time;
    bool function (const(bson_iter_t)* iter, const(char)* key, void* data) visit_null;
    bool function (const(bson_iter_t)* iter, const(char)* key, const(char)* v_regex, const(char)* v_options, void* data) visit_regex;
    bool function (const(bson_iter_t)* iter, const(char)* key, size_t v_collection_len, const(char)* v_collection, const(bson_oid_t)* v_oid, void* data) visit_dbpointer;
    bool function (const(bson_iter_t)* iter, const(char)* key, size_t v_code_len, const(char)* v_code, void* data) visit_code;
    bool function (const(bson_iter_t)* iter, const(char)* key, size_t v_symbol_len, const(char)* v_symbol, void* data) visit_symbol;
    bool function (const(bson_iter_t)* iter, const(char)* key, size_t v_code_len, const(char)* v_code, const(bson_t)* v_scope, void* data) visit_codewscope;
    bool function (const(bson_iter_t)* iter, const(char)* key, int v_int32, void* data) visit_int32;
    bool function (const(bson_iter_t)* iter, const(char)* key, uint v_timestamp, uint v_increment, void* data) visit_timestamp;
    bool function (const(bson_iter_t)* iter, const(char)* key, long v_int64, void* data) visit_int64;
    bool function (const(bson_iter_t)* iter, const(char)* key, void* data) visit_maxkey;
    bool function (const(bson_iter_t)* iter, const(char)* key, void* data) visit_minkey;

    void function (const(bson_iter_t)* iter, const(char)* key, uint type_code, void* data) visit_unsupported_type;
    bool function (const(bson_iter_t)* iter, const(char)* key, const(bson_decimal128_t)* v_decimal128, void* data) visit_decimal128;

    void*[7] padding;
}

enum BSON_ERROR_BUFFER_SIZE = 504;

struct _bson_error_t
{
    uint domain;
    uint code;
    char[BSON_ERROR_BUFFER_SIZE] message;
}

alias bson_error_t = _bson_error_t;

alias static_assert_test_504 = char[1];

size_t bson_next_power_of_two (size_t v);

bool bson_is_power_of_two (uint v);


// mongo-c-clients stuffs --->

// from file mongoc-stream-tls-libressl.h:
/*
 * Copyright 2016 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/* MONGOC_ENABLE_SSL_LIBRESSL */
/* MONGOC_STREAM_TLS_LIBRESSL_H */

// from file mongoc-write-concern.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum WRITE_CONCERN_W_UNACKNOWLEDGED = 0;
enum WRITE_CONCERN_W_ERRORS_IGNORED = -1; /* deprecated */
enum WRITE_CONCERN_W_DEFAULT = -2;
enum WRITE_CONCERN_W_MAJORITY = -3;
enum WRITE_CONCERN_W_TAG = -4;

struct _mongoc_write_concern_t;
alias mongoc_write_concern_t = _mongoc_write_concern_t;

mongoc_write_concern_t* mongoc_write_concern_new ();
mongoc_write_concern_t* mongoc_write_concern_copy (
    const(mongoc_write_concern_t)* write_concern);
void mongoc_write_concern_destroy (mongoc_write_concern_t* write_concern);
bool mongoc_write_concern_get_fsync (
    const(mongoc_write_concern_t)* write_concern);
void mongoc_write_concern_set_fsync (
    mongoc_write_concern_t* write_concern,
    bool fsync_);
bool mongoc_write_concern_get_journal (
    const(mongoc_write_concern_t)* write_concern);
bool mongoc_write_concern_journal_is_set (
    const(mongoc_write_concern_t)* write_concern);
void mongoc_write_concern_set_journal (
    mongoc_write_concern_t* write_concern,
    bool journal);
int mongoc_write_concern_get_w (const(mongoc_write_concern_t)* write_concern);
void mongoc_write_concern_set_w (mongoc_write_concern_t* write_concern, int w);
const(char)* mongoc_write_concern_get_wtag (
    const(mongoc_write_concern_t)* write_concern);
void mongoc_write_concern_set_wtag (
    mongoc_write_concern_t* write_concern,
    const(char)* tag);
int mongoc_write_concern_get_wtimeout (
    const(mongoc_write_concern_t)* write_concern);
void mongoc_write_concern_set_wtimeout (
    mongoc_write_concern_t* write_concern,
    int wtimeout_msec);
bool mongoc_write_concern_get_wmajority (
    const(mongoc_write_concern_t)* write_concern);
void mongoc_write_concern_set_wmajority (
    mongoc_write_concern_t* write_concern,
    int wtimeout_msec);
bool mongoc_write_concern_is_acknowledged (
    const(mongoc_write_concern_t)* write_concern);
bool mongoc_write_concern_is_valid (
    const(mongoc_write_concern_t)* write_concern);
bool mongoc_write_concern_append (
    mongoc_write_concern_t* write_concern,
    bson_t* doc);
bool mongoc_write_concern_is_default (
    const(mongoc_write_concern_t)* write_concern);

/* MONGOC_WRITE_CONCERN_H */

// from file mongoc-server-description.h:
/*
 * Copyright 2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_server_description_t;
alias mongoc_server_description_t = _mongoc_server_description_t;

void mongoc_server_description_destroy (
    mongoc_server_description_t* description);

mongoc_server_description_t* mongoc_server_description_new_copy (
    const(mongoc_server_description_t)* description);

uint mongoc_server_description_id (
    const(mongoc_server_description_t)* description);

mongoc_host_list_t* mongoc_server_description_host (
    const(mongoc_server_description_t)* description);

long mongoc_server_description_round_trip_time (
    const(mongoc_server_description_t)* description);

const(char)* mongoc_server_description_type (
    const(mongoc_server_description_t)* description);

const(bson_t)* mongoc_server_description_ismaster (
    const(mongoc_server_description_t)* description);

int mongoc_server_description_compressor_id (
    const(mongoc_server_description_t)* description);


// from file mongoc-iovec.h:
/*
 * Copyright 2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


alias mongoc_iovec_t = iovec;

/* MONGOC_IOVEC_H */

// from file mongoc-host-list.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum BSON_HOST_NAME_MAX = 255;

alias mongoc_host_list_t = _mongoc_host_list_t;

struct _mongoc_host_list_t
{
    mongoc_host_list_t* next;
    char[256] host;
    char[262] host_and_port;
    ushort port;
    int family;
    void*[4] padding;
}

/* MONGOC_HOST_LIST_H */

// from file mongoc-topology-description-patched.c:
/*
 * Copyright 2016 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_topology_description_t;
alias mongoc_topology_description_t = _mongoc_topology_description_t;

bool mongoc_topology_description_has_readable_server (
    mongoc_topology_description_t* td,
    const(mongoc_read_prefs_t)* prefs);
bool mongoc_topology_description_has_writable_server (
    mongoc_topology_description_t* td);
const(char)* mongoc_topology_description_type (
    const(mongoc_topology_description_t)* td);
mongoc_server_description_t** mongoc_topology_description_get_servers (
    const(mongoc_topology_description_t)* td,
    size_t* n);

/* MONGOC_TOPOLOGY_DESCRIPTION_H */

// from file mongoc-stream-gridfs.h:
/*
 * Copyright 2013 MongoDB Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


mongoc_stream_t* mongoc_stream_gridfs_new (mongoc_gridfs_file_t* file);

/* MONGOC_STREAM_GRIDFS_H */

// from file mongoc-stream.h:
/*
 * Copyright 2013-2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */




alias mongoc_stream_t = _mongoc_stream_t;

struct _mongoc_stream_poll_t
{
    mongoc_stream_t* stream;
    int events;
    int revents;
}

alias mongoc_stream_poll_t = _mongoc_stream_poll_t;

struct _mongoc_stream_t
{
    int type;
    void function (mongoc_stream_t* stream) destroy;
    int function (mongoc_stream_t* stream) close;
    int function (mongoc_stream_t* stream) flush;
    ssize_t function (mongoc_stream_t* stream, mongoc_iovec_t* iov, size_t iovcnt, int timeout_msec) writev;
    ssize_t function (mongoc_stream_t* stream, mongoc_iovec_t* iov, size_t iovcnt, size_t min_bytes, int timeout_msec) readv;
    int function (mongoc_stream_t* stream, int level, int optname, void* optval, mongoc_socklen_t optlen) setsockopt;
    mongoc_stream_t* function (mongoc_stream_t* stream) get_base_stream;
    bool function (mongoc_stream_t* stream) check_closed;
    ssize_t function (mongoc_stream_poll_t* streams, size_t nstreams, int timeout) poll;
    void function (mongoc_stream_t* stream) failed;
    bool function (mongoc_stream_t* stream) timed_out;
    void*[4] padding;
}

mongoc_stream_t* mongoc_stream_get_base_stream (mongoc_stream_t* stream);
mongoc_stream_t* mongoc_stream_get_tls_stream (mongoc_stream_t* stream);
int mongoc_stream_close (mongoc_stream_t* stream);
void mongoc_stream_destroy (mongoc_stream_t* stream);
void mongoc_stream_failed (mongoc_stream_t* stream);
int mongoc_stream_flush (mongoc_stream_t* stream);
ssize_t mongoc_stream_writev (
    mongoc_stream_t* stream,
    mongoc_iovec_t* iov,
    size_t iovcnt,
    int timeout_msec);
ssize_t mongoc_stream_write (
    mongoc_stream_t* stream,
    void* buf,
    size_t count,
    int timeout_msec);
ssize_t mongoc_stream_readv (
    mongoc_stream_t* stream,
    mongoc_iovec_t* iov,
    size_t iovcnt,
    size_t min_bytes,
    int timeout_msec);
ssize_t mongoc_stream_read (
    mongoc_stream_t* stream,
    void* buf,
    size_t count,
    size_t min_bytes,
    int timeout_msec);
int mongoc_stream_setsockopt (
    mongoc_stream_t* stream,
    int level,
    int optname,
    void* optval,
    mongoc_socklen_t optlen);
bool mongoc_stream_check_closed (mongoc_stream_t* stream);
bool mongoc_stream_timed_out (mongoc_stream_t* stream);
ssize_t mongoc_stream_poll (
    mongoc_stream_poll_t* streams,
    size_t nstreams,
    int timeout);

/* MONGOC_STREAM_H */

// from file mongoc-apm.h:
/*
 * Copyright 2015 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/*
 * Application Performance Management (APM) interface, complies with two specs.
 * MongoDB's Command Monitoring Spec:
 *
 * https://github.com/mongodb/specifications/tree/master/source/command-monitoring
 *
 * MongoDB's Spec for Monitoring Server Discovery and Monitoring (SDAM) events:
 *
 * https://github.com/mongodb/specifications/tree/master/source/server-discovery-and-monitoring
 *
 */

/*
 * callbacks to receive APM events
 */

struct _mongoc_apm_callbacks_t;
alias mongoc_apm_callbacks_t = _mongoc_apm_callbacks_t;

/*
 * command monitoring events
 */

struct _mongoc_apm_command_started_t;
alias mongoc_apm_command_started_t = _mongoc_apm_command_started_t;
struct _mongoc_apm_command_succeeded_t;
alias mongoc_apm_command_succeeded_t = _mongoc_apm_command_succeeded_t;
struct _mongoc_apm_command_failed_t;
alias mongoc_apm_command_failed_t = _mongoc_apm_command_failed_t;

/*
 * SDAM monitoring events
 */

struct _mongoc_apm_server_changed_t;
alias mongoc_apm_server_changed_t = _mongoc_apm_server_changed_t;
struct _mongoc_apm_server_opening_t;
alias mongoc_apm_server_opening_t = _mongoc_apm_server_opening_t;
struct _mongoc_apm_server_closed_t;
alias mongoc_apm_server_closed_t = _mongoc_apm_server_closed_t;
struct _mongoc_apm_topology_changed_t;
alias mongoc_apm_topology_changed_t = _mongoc_apm_topology_changed_t;
struct _mongoc_apm_topology_opening_t;
alias mongoc_apm_topology_opening_t = _mongoc_apm_topology_opening_t;
struct _mongoc_apm_topology_closed_t;
alias mongoc_apm_topology_closed_t = _mongoc_apm_topology_closed_t;
struct _mongoc_apm_server_heartbeat_started_t;
alias mongoc_apm_server_heartbeat_started_t = _mongoc_apm_server_heartbeat_started_t;
struct _mongoc_apm_server_heartbeat_succeeded_t;
alias mongoc_apm_server_heartbeat_succeeded_t = _mongoc_apm_server_heartbeat_succeeded_t;
struct _mongoc_apm_server_heartbeat_failed_t;
alias mongoc_apm_server_heartbeat_failed_t = _mongoc_apm_server_heartbeat_failed_t;

/*
 * event field accessors
 */

/* command-started event fields */

const(bson_t)* mongoc_apm_command_started_get_command (
    const(mongoc_apm_command_started_t)* event);
const(char)* mongoc_apm_command_started_get_database_name (
    const(mongoc_apm_command_started_t)* event);
const(char)* mongoc_apm_command_started_get_command_name (
    const(mongoc_apm_command_started_t)* event);
long mongoc_apm_command_started_get_request_id (
    const(mongoc_apm_command_started_t)* event);
long mongoc_apm_command_started_get_operation_id (
    const(mongoc_apm_command_started_t)* event);
const(mongoc_host_list_t)* mongoc_apm_command_started_get_host (
    const(mongoc_apm_command_started_t)* event);
uint mongoc_apm_command_started_get_server_id (
    const(mongoc_apm_command_started_t)* event);
void* mongoc_apm_command_started_get_context (
    const(mongoc_apm_command_started_t)* event);

/* command-succeeded event fields */

long mongoc_apm_command_succeeded_get_duration (
    const(mongoc_apm_command_succeeded_t)* event);
const(bson_t)* mongoc_apm_command_succeeded_get_reply (
    const(mongoc_apm_command_succeeded_t)* event);
const(char)* mongoc_apm_command_succeeded_get_command_name (
    const(mongoc_apm_command_succeeded_t)* event);
long mongoc_apm_command_succeeded_get_request_id (
    const(mongoc_apm_command_succeeded_t)* event);
long mongoc_apm_command_succeeded_get_operation_id (
    const(mongoc_apm_command_succeeded_t)* event);
const(mongoc_host_list_t)* mongoc_apm_command_succeeded_get_host (
    const(mongoc_apm_command_succeeded_t)* event);
uint mongoc_apm_command_succeeded_get_server_id (
    const(mongoc_apm_command_succeeded_t)* event);
void* mongoc_apm_command_succeeded_get_context (
    const(mongoc_apm_command_succeeded_t)* event);

/* command-failed event fields */

long mongoc_apm_command_failed_get_duration (
    const(mongoc_apm_command_failed_t)* event);
const(char)* mongoc_apm_command_failed_get_command_name (
    const(mongoc_apm_command_failed_t)* event);

/* retrieve the error by filling out the passed-in "error" struct */
void mongoc_apm_command_failed_get_error (
    const(mongoc_apm_command_failed_t)* event,
    bson_error_t* error);
long mongoc_apm_command_failed_get_request_id (
    const(mongoc_apm_command_failed_t)* event);
long mongoc_apm_command_failed_get_operation_id (
    const(mongoc_apm_command_failed_t)* event);
const(mongoc_host_list_t)* mongoc_apm_command_failed_get_host (
    const(mongoc_apm_command_failed_t)* event);
uint mongoc_apm_command_failed_get_server_id (
    const(mongoc_apm_command_failed_t)* event);
void* mongoc_apm_command_failed_get_context (
    const(mongoc_apm_command_failed_t)* event);

/* server-changed event fields */

const(mongoc_host_list_t)* mongoc_apm_server_changed_get_host (
    const(mongoc_apm_server_changed_t)* event);
void mongoc_apm_server_changed_get_topology_id (
    const(mongoc_apm_server_changed_t)* event,
    bson_oid_t* topology_id);
const(mongoc_server_description_t)* mongoc_apm_server_changed_get_previous_description (
    const(mongoc_apm_server_changed_t)* event);
const(mongoc_server_description_t)* mongoc_apm_server_changed_get_new_description (
    const(mongoc_apm_server_changed_t)* event);
void* mongoc_apm_server_changed_get_context (
    const(mongoc_apm_server_changed_t)* event);

/* server-opening event fields */

const(mongoc_host_list_t)* mongoc_apm_server_opening_get_host (
    const(mongoc_apm_server_opening_t)* event);
void mongoc_apm_server_opening_get_topology_id (
    const(mongoc_apm_server_opening_t)* event,
    bson_oid_t* topology_id);
void* mongoc_apm_server_opening_get_context (
    const(mongoc_apm_server_opening_t)* event);

/* server-closed event fields */

const(mongoc_host_list_t)* mongoc_apm_server_closed_get_host (
    const(mongoc_apm_server_closed_t)* event);
void mongoc_apm_server_closed_get_topology_id (
    const(mongoc_apm_server_closed_t)* event,
    bson_oid_t* topology_id);
void* mongoc_apm_server_closed_get_context (
    const(mongoc_apm_server_closed_t)* event);

/* topology-changed event fields */

void mongoc_apm_topology_changed_get_topology_id (
    const(mongoc_apm_topology_changed_t)* event,
    bson_oid_t* topology_id);
const(mongoc_topology_description_t)* mongoc_apm_topology_changed_get_previous_description (
    const(mongoc_apm_topology_changed_t)* event);
const(mongoc_topology_description_t)* mongoc_apm_topology_changed_get_new_description (
    const(mongoc_apm_topology_changed_t)* event);
void* mongoc_apm_topology_changed_get_context (
    const(mongoc_apm_topology_changed_t)* event);

/* topology-opening event field */

void mongoc_apm_topology_opening_get_topology_id (
    const(mongoc_apm_topology_opening_t)* event,
    bson_oid_t* topology_id);
void* mongoc_apm_topology_opening_get_context (
    const(mongoc_apm_topology_opening_t)* event);

/* topology-closed event field */

void mongoc_apm_topology_closed_get_topology_id (
    const(mongoc_apm_topology_closed_t)* event,
    bson_oid_t* topology_id);
void* mongoc_apm_topology_closed_get_context (
    const(mongoc_apm_topology_closed_t)* event);

/* heartbeat-started event field */

const(mongoc_host_list_t)* mongoc_apm_server_heartbeat_started_get_host (
    const(mongoc_apm_server_heartbeat_started_t)* event);
void* mongoc_apm_server_heartbeat_started_get_context (
    const(mongoc_apm_server_heartbeat_started_t)* event);

/* heartbeat-succeeded event fields */

long mongoc_apm_server_heartbeat_succeeded_get_duration (
    const(mongoc_apm_server_heartbeat_succeeded_t)* event);
const(bson_t)* mongoc_apm_server_heartbeat_succeeded_get_reply (
    const(mongoc_apm_server_heartbeat_succeeded_t)* event);
const(mongoc_host_list_t)* mongoc_apm_server_heartbeat_succeeded_get_host (
    const(mongoc_apm_server_heartbeat_succeeded_t)* event);
void* mongoc_apm_server_heartbeat_succeeded_get_context (
    const(mongoc_apm_server_heartbeat_succeeded_t)* event);

/* heartbeat-failed event fields */

long mongoc_apm_server_heartbeat_failed_get_duration (
    const(mongoc_apm_server_heartbeat_failed_t)* event);
void mongoc_apm_server_heartbeat_failed_get_error (
    const(mongoc_apm_server_heartbeat_failed_t)* event,
    bson_error_t* error);
const(mongoc_host_list_t)* mongoc_apm_server_heartbeat_failed_get_host (
    const(mongoc_apm_server_heartbeat_failed_t)* event);
void* mongoc_apm_server_heartbeat_failed_get_context (
    const(mongoc_apm_server_heartbeat_failed_t)* event);

/*
 * callbacks
 */

alias mongoc_apm_command_started_cb_t = void function (const(mongoc_apm_command_started_t)* event);
alias mongoc_apm_command_succeeded_cb_t = void function (const(mongoc_apm_command_succeeded_t)* event);
alias mongoc_apm_command_failed_cb_t = void function (const(mongoc_apm_command_failed_t)* event);
alias mongoc_apm_server_changed_cb_t = void function (const(mongoc_apm_server_changed_t)* event);
alias mongoc_apm_server_opening_cb_t = void function (const(mongoc_apm_server_opening_t)* event);
alias mongoc_apm_server_closed_cb_t = void function (const(mongoc_apm_server_closed_t)* event);
alias mongoc_apm_topology_changed_cb_t = void function (const(mongoc_apm_topology_changed_t)* event);
alias mongoc_apm_topology_opening_cb_t = void function (const(mongoc_apm_topology_opening_t)* event);
alias mongoc_apm_topology_closed_cb_t = void function (const(mongoc_apm_topology_closed_t)* event);
alias mongoc_apm_server_heartbeat_started_cb_t = void function (const(mongoc_apm_server_heartbeat_started_t)* event);
alias mongoc_apm_server_heartbeat_succeeded_cb_t = void function (const(mongoc_apm_server_heartbeat_succeeded_t)* event);
alias mongoc_apm_server_heartbeat_failed_cb_t = void function (const(mongoc_apm_server_heartbeat_failed_t)* event);

/*
 * registering callbacks
 */

mongoc_apm_callbacks_t* mongoc_apm_callbacks_new ();
void mongoc_apm_callbacks_destroy (mongoc_apm_callbacks_t* callbacks);
void mongoc_apm_set_command_started_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_command_started_cb_t cb);
void mongoc_apm_set_command_succeeded_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_command_succeeded_cb_t cb);
void mongoc_apm_set_command_failed_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_command_failed_cb_t cb);
void mongoc_apm_set_server_changed_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_server_changed_cb_t cb);
void mongoc_apm_set_server_opening_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_server_opening_cb_t cb);
void mongoc_apm_set_server_closed_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_server_closed_cb_t cb);
void mongoc_apm_set_topology_changed_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_topology_changed_cb_t cb);
void mongoc_apm_set_topology_opening_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_topology_opening_cb_t cb);
void mongoc_apm_set_topology_closed_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_topology_closed_cb_t cb);
void mongoc_apm_set_server_heartbeat_started_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_server_heartbeat_started_cb_t cb);
void mongoc_apm_set_server_heartbeat_succeeded_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_server_heartbeat_succeeded_cb_t cb);
void mongoc_apm_set_server_heartbeat_failed_cb (
    mongoc_apm_callbacks_t* callbacks,
    mongoc_apm_server_heartbeat_failed_cb_t cb);

/* MONGOC_APM_H */

// from file mongoc-index.h:
/*
 * Copyright 2013 MongoDB Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


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

enum mongoc_index_storage_opt_type_t
{
    STORAGE_OPT_MMAPV1 = 0,
    STORAGE_OPT_WIREDTIGER = 1
}

struct mongoc_index_opt_wt_t
{
    mongoc_index_opt_storage_t base;
    const(char)* config_str;
    void*[8] padding;
}

struct mongoc_index_opt_t
{
    bool is_initialized;
    bool background;
    bool unique;
    const(char)* name;
    bool drop_dups;
    bool sparse;
    int expire_after_seconds;
    int v;
    const(bson_t)* weights;
    const(char)* default_language;
    const(char)* language_override;
    mongoc_index_opt_geo_t* geo_options;
    mongoc_index_opt_storage_t* storage_options;
    const(bson_t)* partial_filter_expression;
    const(bson_t)* collation;
    void*[4] padding;
}

const(mongoc_index_opt_t)* mongoc_index_opt_get_default ();
const(mongoc_index_opt_geo_t)* mongoc_index_opt_geo_get_default ();
const(mongoc_index_opt_wt_t)* mongoc_index_opt_wt_get_default ();
void mongoc_index_opt_init (mongoc_index_opt_t* opt);
void mongoc_index_opt_geo_init (mongoc_index_opt_geo_t* opt);
void mongoc_index_opt_wt_init (mongoc_index_opt_wt_t* opt);

/* MONGOC_INDEX_H */

// from file mongoc-stream-buffered.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


mongoc_stream_t* mongoc_stream_buffered_new (
    mongoc_stream_t* base_stream,
    size_t buffer_size);

/* MONGOC_STREAM_BUFFERED_H */

// from file mongoc-database-patched.c:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_collection_t;
alias mongoc_collection_t = _mongoc_collection_t;
struct _mongoc_database_t;
alias mongoc_database_t = _mongoc_database_t;

const(char)* mongoc_database_get_name (mongoc_database_t* database);
bool mongoc_database_remove_user (
    mongoc_database_t* database,
    const(char)* username,
    bson_error_t* error);
bool mongoc_database_remove_all_users (
    mongoc_database_t* database,
    bson_error_t* error);
bool mongoc_database_add_user (
    mongoc_database_t* database,
    const(char)* username,
    const(char)* password,
    const(bson_t)* roles,
    const(bson_t)* custom_data,
    bson_error_t* error);
void mongoc_database_destroy (mongoc_database_t* database);
mongoc_database_t* mongoc_database_copy (mongoc_database_t* database);
mongoc_cursor_t* mongoc_database_command (
    mongoc_database_t* database,
    mongoc_query_flags_t flags,
    uint skip,
    uint limit,
    uint batch_size,
    const(bson_t)* command,
    const(bson_t)* fields,
    const(mongoc_read_prefs_t)* read_prefs);
bool mongoc_database_read_command_with_opts (
    mongoc_database_t* database,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_database_write_command_with_opts (
    mongoc_database_t* database,
    const(bson_t)* command,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);

/* IGNORED */
bool mongoc_database_read_write_command_with_opts (
    mongoc_database_t* database,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_database_command_simple (
    mongoc_database_t* database,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_database_drop (mongoc_database_t* database, bson_error_t* error);
bool mongoc_database_drop_with_opts (
    mongoc_database_t* database,
    const(bson_t)* opts,
    bson_error_t* error);
bool mongoc_database_has_collection (
    mongoc_database_t* database,
    const(char)* name,
    bson_error_t* error);
mongoc_collection_t* mongoc_database_create_collection (
    mongoc_database_t* database,
    const(char)* name,
    const(bson_t)* options,
    bson_error_t* error);
const(mongoc_read_prefs_t)* mongoc_database_get_read_prefs (
    const(mongoc_database_t)* database);
void mongoc_database_set_read_prefs (
    mongoc_database_t* database,
    const(mongoc_read_prefs_t)* read_prefs);
const(mongoc_write_concern_t)* mongoc_database_get_write_concern (
    const(mongoc_database_t)* database);
void mongoc_database_set_write_concern (
    mongoc_database_t* database,
    const(mongoc_write_concern_t)* write_concern);
const(mongoc_read_concern_t)* mongoc_database_get_read_concern (
    const(mongoc_database_t)* database);
void mongoc_database_set_read_concern (
    mongoc_database_t* database,
    const(mongoc_read_concern_t)* read_concern);
mongoc_cursor_t* mongoc_database_find_collections (
    mongoc_database_t* database,
    const(bson_t)* filter,
    bson_error_t* error);
char** mongoc_database_get_collection_names (
    mongoc_database_t* database,
    bson_error_t* error);
mongoc_collection_t* mongoc_database_get_collection (
    mongoc_database_t* database,
    const(char)* name);

/* MONGOC_DATABASE_H */

// from file mongoc-bulk-operation.h:
/*
 * Copyright 2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_bulk_operation_t;
alias mongoc_bulk_operation_t = _mongoc_bulk_operation_t;
struct _mongoc_bulk_write_flags_t;
alias mongoc_bulk_write_flags_t = _mongoc_bulk_write_flags_t;

void mongoc_bulk_operation_destroy (mongoc_bulk_operation_t* bulk);
uint mongoc_bulk_operation_execute (
    mongoc_bulk_operation_t* bulk,
    bson_t* reply,
    bson_error_t* error);
void mongoc_bulk_operation_delete (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector);
void mongoc_bulk_operation_delete_one (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector);
void mongoc_bulk_operation_insert (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* document);
bool mongoc_bulk_operation_insert_with_opts (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* document,
    const(bson_t)* opts,
    bson_error_t* error); /* OUT */
void mongoc_bulk_operation_remove (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector);
bool mongoc_bulk_operation_remove_many_with_opts (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector,
    const(bson_t)* opts,
    bson_error_t* error); /* OUT */
void mongoc_bulk_operation_remove_one (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector);
bool mongoc_bulk_operation_remove_one_with_opts (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector,
    const(bson_t)* opts,
    bson_error_t* error); /* OUT */
void mongoc_bulk_operation_replace_one (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector,
    const(bson_t)* document,
    bool upsert);
bool mongoc_bulk_operation_replace_one_with_opts (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector,
    const(bson_t)* document,
    const(bson_t)* opts,
    bson_error_t* error); /* OUT */
void mongoc_bulk_operation_update (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector,
    const(bson_t)* document,
    bool upsert);
bool mongoc_bulk_operation_update_many_with_opts (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector,
    const(bson_t)* document,
    const(bson_t)* opts,
    bson_error_t* error); /* OUT */
void mongoc_bulk_operation_update_one (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector,
    const(bson_t)* document,
    bool upsert);
bool mongoc_bulk_operation_update_one_with_opts (
    mongoc_bulk_operation_t* bulk,
    const(bson_t)* selector,
    const(bson_t)* document,
    const(bson_t)* opts,
    bson_error_t* error); /* OUT */
void mongoc_bulk_operation_set_bypass_document_validation (
    mongoc_bulk_operation_t* bulk,
    bool bypass);

/*
 * The following functions are really only useful by language bindings and
 * those wanting to replay a bulk operation to a number of clients or
 * collections.
 */
mongoc_bulk_operation_t* mongoc_bulk_operation_new (bool ordered);
void mongoc_bulk_operation_set_write_concern (
    mongoc_bulk_operation_t* bulk,
    const(mongoc_write_concern_t)* write_concern);
void mongoc_bulk_operation_set_database (
    mongoc_bulk_operation_t* bulk,
    const(char)* database);
void mongoc_bulk_operation_set_collection (
    mongoc_bulk_operation_t* bulk,
    const(char)* collection);
void mongoc_bulk_operation_set_client (
    mongoc_bulk_operation_t* bulk,
    void* client);

/* These names include the term "hint" for backward compatibility, should be
 * mongoc_bulk_operation_get_server_id, mongoc_bulk_operation_set_server_id. */
void mongoc_bulk_operation_set_hint (
    mongoc_bulk_operation_t* bulk,
    uint server_id);
uint mongoc_bulk_operation_get_hint (const(mongoc_bulk_operation_t)* bulk);
const(mongoc_write_concern_t)* mongoc_bulk_operation_get_write_concern (
    const(mongoc_bulk_operation_t)* bulk);

/* MONGOC_BULK_OPERATION_H */

// from file mongoc-uri.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum DEFAULT_PORT = 27017;

enum URI_APPNAME = "appname";
enum URI_AUTHMECHANISM = "authmechanism";
enum URI_AUTHMECHANISMPROPERTIES = "authmechanismproperties";
enum URI_AUTHSOURCE = "authsource";
enum URI_CANONICALIZEHOSTNAME = "canonicalizehostname";
enum URI_CONNECTTIMEOUTMS = "connecttimeoutms";
enum URI_COMPRESSORS = "compressors";
enum URI_GSSAPISERVICENAME = "gssapiservicename";
enum URI_HEARTBEATFREQUENCYMS = "heartbeatfrequencyms";
enum URI_JOURNAL = "journal";
enum URI_LOCALTHRESHOLDMS = "localthresholdms";
enum URI_MAXIDLETIMEMS = "maxidletimems";
enum URI_MAXPOOLSIZE = "maxpoolsize";
enum URI_MAXSTALENESSSECONDS = "maxstalenessseconds";
enum URI_MINPOOLSIZE = "minpoolsize";
enum URI_READCONCERNLEVEL = "readconcernlevel";
enum URI_READPREFERENCE = "readpreference";
enum URI_READPREFERENCETAGS = "readpreferencetags";
enum URI_REPLICASET = "replicaset";
enum URI_SAFE = "safe";
enum URI_SERVERSELECTIONTIMEOUTMS = "serverselectiontimeoutms";
enum URI_SERVERSELECTIONTRYONCE = "serverselectiontryonce";
enum URI_SLAVEOK = "slaveok";
enum URI_SOCKETCHECKINTERVALMS = "socketcheckintervalms";
enum URI_SOCKETTIMEOUTMS = "sockettimeoutms";
enum URI_SSL = "ssl";
enum URI_SSLCLIENTCERTIFICATEKEYFILE = "sslclientcertificatekeyfile";
enum URI_SSLCLIENTCERTIFICATEKEYPASSWORD = "sslclientcertificatekeypassword";
enum URI_SSLCERTIFICATEAUTHORITYFILE = "sslcertificateauthorityfile";
enum URI_SSLALLOWINVALIDCERTIFICATES = "sslallowinvalidcertificates";
enum URI_SSLALLOWINVALIDHOSTNAMES = "sslallowinvalidhostnames";
enum URI_W = "w";
enum URI_WAITQUEUEMULTIPLE = "waitqueuemultiple";
enum URI_WAITQUEUETIMEOUTMS = "waitqueuetimeoutms";
enum URI_WTIMEOUTMS = "wtimeoutms";
enum URI_ZLIBCOMPRESSIONLEVEL = "zlibcompressionlevel";

struct _mongoc_uri_t;
alias mongoc_uri_t = _mongoc_uri_t;

mongoc_uri_t* mongoc_uri_copy (const(mongoc_uri_t)* uri);
void mongoc_uri_destroy (mongoc_uri_t* uri);
mongoc_uri_t* mongoc_uri_new (const(char)* uri_string);
mongoc_uri_t* mongoc_uri_new_with_error (
    const(char)* uri_string,
    bson_error_t* error);
mongoc_uri_t* mongoc_uri_new_for_host_port (const(char)* hostname, ushort port);
const(mongoc_host_list_t)* mongoc_uri_get_hosts (const(mongoc_uri_t)* uri);
const(char)* mongoc_uri_get_database (const(mongoc_uri_t)* uri);
bool mongoc_uri_set_database (mongoc_uri_t* uri, const(char)* database);
const(bson_t)* mongoc_uri_get_compressors (const(mongoc_uri_t)* uri);
const(bson_t)* mongoc_uri_get_options (const(mongoc_uri_t)* uri);
const(char)* mongoc_uri_get_password (const(mongoc_uri_t)* uri);
bool mongoc_uri_set_password (mongoc_uri_t* uri, const(char)* password);
bool mongoc_uri_option_is_int32 (const(char)* key);
bool mongoc_uri_option_is_bool (const(char)* key);
bool mongoc_uri_option_is_utf8 (const(char)* key);
int mongoc_uri_get_option_as_int32 (
    const(mongoc_uri_t)* uri,
    const(char)* option,
    int fallback);
bool mongoc_uri_get_option_as_bool (
    const(mongoc_uri_t)* uri,
    const(char)* option,
    bool fallback);
const(char)* mongoc_uri_get_option_as_utf8 (
    const(mongoc_uri_t)* uri,
    const(char)* option,
    const(char)* fallback);
bool mongoc_uri_set_option_as_int32 (
    mongoc_uri_t* uri,
    const(char)* option,
    int value);
bool mongoc_uri_set_option_as_bool (
    mongoc_uri_t* uri,
    const(char)* option,
    bool value);
bool mongoc_uri_set_option_as_utf8 (
    mongoc_uri_t* uri,
    const(char)* option,
    const(char)* value);
const(bson_t)* mongoc_uri_get_read_prefs (const(mongoc_uri_t)* uri);
const(char)* mongoc_uri_get_replica_set (const(mongoc_uri_t)* uri);
const(char)* mongoc_uri_get_string (const(mongoc_uri_t)* uri);
const(char)* mongoc_uri_get_username (const(mongoc_uri_t)* uri);
bool mongoc_uri_set_username (mongoc_uri_t* uri, const(char)* username);
const(bson_t)* mongoc_uri_get_credentials (const(mongoc_uri_t)* uri);
const(char)* mongoc_uri_get_auth_source (const(mongoc_uri_t)* uri);
bool mongoc_uri_set_auth_source (mongoc_uri_t* uri, const(char)* value);
const(char)* mongoc_uri_get_appname (const(mongoc_uri_t)* uri);
bool mongoc_uri_set_appname (mongoc_uri_t* uri, const(char)* value);
bool mongoc_uri_set_compressors (mongoc_uri_t* uri, const(char)* value);
const(char)* mongoc_uri_get_auth_mechanism (const(mongoc_uri_t)* uri);
bool mongoc_uri_set_auth_mechanism (mongoc_uri_t* uri, const(char)* value);
bool mongoc_uri_get_mechanism_properties (
    const(mongoc_uri_t)* uri,
    bson_t* properties);
bool mongoc_uri_set_mechanism_properties (
    mongoc_uri_t* uri,
    const(bson_t)* properties);
bool mongoc_uri_get_ssl (const(mongoc_uri_t)* uri);
char* mongoc_uri_unescape (const(char)* escaped_string);
const(mongoc_read_prefs_t)* mongoc_uri_get_read_prefs_t (
    const(mongoc_uri_t)* uri);
void mongoc_uri_set_read_prefs_t (
    mongoc_uri_t* uri,
    const(mongoc_read_prefs_t)* prefs);
const(mongoc_write_concern_t)* mongoc_uri_get_write_concern (
    const(mongoc_uri_t)* uri);
void mongoc_uri_set_write_concern (
    mongoc_uri_t* uri,
    const(mongoc_write_concern_t)* wc);
const(mongoc_read_concern_t)* mongoc_uri_get_read_concern (
    const(mongoc_uri_t)* uri);
void mongoc_uri_set_read_concern (
    mongoc_uri_t* uri,
    const(mongoc_read_concern_t)* rc);

/* MONGOC_URI_H */

// from file mongoc-find-and-modify.h:
/*
 * Copyright 2015 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum mongoc_find_and_modify_flags_t
{
    AND_MODIFY_NONE = 0,
    AND_MODIFY_REMOVE = 1,
    AND_MODIFY_UPSERT = 2,
    AND_MODIFY_RETURN_NEW = 4
}

struct _mongoc_find_and_modify_opts_t;
alias mongoc_find_and_modify_opts_t = _mongoc_find_and_modify_opts_t;

mongoc_find_and_modify_opts_t* mongoc_find_and_modify_opts_new ();

bool mongoc_find_and_modify_opts_set_sort (
    mongoc_find_and_modify_opts_t* opts,
    const(bson_t)* sort);

void mongoc_find_and_modify_opts_get_sort (
    const(mongoc_find_and_modify_opts_t)* opts,
    bson_t* sort);

bool mongoc_find_and_modify_opts_set_update (
    mongoc_find_and_modify_opts_t* opts,
    const(bson_t)* update);

void mongoc_find_and_modify_opts_get_update (
    const(mongoc_find_and_modify_opts_t)* opts,
    bson_t* update);

bool mongoc_find_and_modify_opts_set_fields (
    mongoc_find_and_modify_opts_t* opts,
    const(bson_t)* fields);

void mongoc_find_and_modify_opts_get_fields (
    const(mongoc_find_and_modify_opts_t)* opts,
    bson_t* fields);

bool mongoc_find_and_modify_opts_set_flags (
    mongoc_find_and_modify_opts_t* opts,
    const mongoc_find_and_modify_flags_t flags);

mongoc_find_and_modify_flags_t mongoc_find_and_modify_opts_get_flags (
    const(mongoc_find_and_modify_opts_t)* opts);

bool mongoc_find_and_modify_opts_set_bypass_document_validation (
    mongoc_find_and_modify_opts_t* opts,
    bool bypass);

bool mongoc_find_and_modify_opts_get_bypass_document_validation (
    const(mongoc_find_and_modify_opts_t)* opts);

bool mongoc_find_and_modify_opts_set_max_time_ms (
    mongoc_find_and_modify_opts_t* opts,
    uint max_time_ms);

uint mongoc_find_and_modify_opts_get_max_time_ms (
    const(mongoc_find_and_modify_opts_t)* opts);

bool mongoc_find_and_modify_opts_append (
    mongoc_find_and_modify_opts_t* opts,
    const(bson_t)* extra);

void mongoc_find_and_modify_opts_get_extra (
    const(mongoc_find_and_modify_opts_t)* opts,
    bson_t* extra);

void mongoc_find_and_modify_opts_destroy (mongoc_find_and_modify_opts_t* opts);

/* MONGOC_FIND_AND_MODIFY_H */

// from file mongoc-stream-file.h:
/*
 * Copyright 2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_stream_file_t;
alias mongoc_stream_file_t = _mongoc_stream_file_t;

mongoc_stream_t* mongoc_stream_file_new (int fd);
mongoc_stream_t* mongoc_stream_file_new_for_path (
    const(char)* path,
    int flags,
    int mode);
int mongoc_stream_file_get_fd (mongoc_stream_file_t* stream);

/* MONGOC_STREAM_FILE_H */

// from file mongoc-read-concern.h:
/*
 * Copyright 2015 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum READ_CONCERN_LEVEL_LOCAL = "local";
enum READ_CONCERN_LEVEL_MAJORITY = "majority";
enum READ_CONCERN_LEVEL_LINEARIZABLE = "linearizable";

struct _mongoc_read_concern_t;
alias mongoc_read_concern_t = _mongoc_read_concern_t;

mongoc_read_concern_t* mongoc_read_concern_new ();
mongoc_read_concern_t* mongoc_read_concern_copy (
    const(mongoc_read_concern_t)* read_concern);
void mongoc_read_concern_destroy (mongoc_read_concern_t* read_concern);
const(char)* mongoc_read_concern_get_level (
    const(mongoc_read_concern_t)* read_concern);
bool mongoc_read_concern_set_level (
    mongoc_read_concern_t* read_concern,
    const(char)* level);
bool mongoc_read_concern_append (
    mongoc_read_concern_t* read_concern,
    bson_t* doc);
bool mongoc_read_concern_is_default (
    const(mongoc_read_concern_t)* read_concern);

/* MONGOC_READ_CONCERN_H */

// from file mongoc-stream-tls-openssl.h:
/*
 * Copyright 2016 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/* MONGOC_ENABLE_SSL_OPENSSL */
/* MONGOC_STREAM_TLS_OPENSSL_H */

// from file mongoc-version-functions.h:
/*
 * Copyright 2015 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/* for "bool" */

int mongoc_get_major_version ();
int mongoc_get_minor_version ();
int mongoc_get_micro_version ();
const(char)* mongoc_get_version ();
bool mongoc_check_version (
    int required_major,
    int required_minor,
    int required_micro);

/* MONGOC_VERSION_FUNCTIONS_H */

// from file mongoc-gridfs-file.h:
/*
 * Copyright 2013 MongoDB Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



struct _mongoc_gridfs_file_t;
alias mongoc_gridfs_file_t = _mongoc_gridfs_file_t;
alias mongoc_gridfs_file_opt_t = _mongoc_gridfs_file_opt_t;

struct _mongoc_gridfs_file_opt_t
{
    const(char)* md5;
    const(char)* filename;
    const(char)* content_type;
    const(bson_t)* aliases;
    const(bson_t)* metadata;
    uint chunk_size;
}

const(char)* mongoc_gridfs_file_get_md5 (mongoc_gridfs_file_t* file);
void mongoc_gridfs_file_set_md5 (mongoc_gridfs_file_t* file, const(char)* str);
const(char)* mongoc_gridfs_file_get_filename (mongoc_gridfs_file_t* file);
void mongoc_gridfs_file_set_filename (mongoc_gridfs_file_t* file, const(char)* str);
const(char)* mongoc_gridfs_file_get_content_type (mongoc_gridfs_file_t* file);
void mongoc_gridfs_file_set_content_type (mongoc_gridfs_file_t* file, const(char)* str);
const(bson_t)* mongoc_gridfs_file_get_aliases (mongoc_gridfs_file_t* file);
void mongoc_gridfs_file_set_aliases (mongoc_gridfs_file_t* file, const(bson_t)* bson);
const(bson_t)* mongoc_gridfs_file_get_metadata (mongoc_gridfs_file_t* file);
void mongoc_gridfs_file_set_metadata (mongoc_gridfs_file_t* file, const(bson_t)* bson);

const(bson_value_t)* mongoc_gridfs_file_get_id (mongoc_gridfs_file_t* file);

long mongoc_gridfs_file_get_length (mongoc_gridfs_file_t* file);

int mongoc_gridfs_file_get_chunk_size (mongoc_gridfs_file_t* file);

long mongoc_gridfs_file_get_upload_date (mongoc_gridfs_file_t* file);

ssize_t mongoc_gridfs_file_writev (
    mongoc_gridfs_file_t* file,
    const(mongoc_iovec_t)* iov,
    size_t iovcnt,
    uint timeout_msec);
ssize_t mongoc_gridfs_file_readv (
    mongoc_gridfs_file_t* file,
    mongoc_iovec_t* iov,
    size_t iovcnt,
    size_t min_bytes,
    uint timeout_msec);
int mongoc_gridfs_file_seek (
    mongoc_gridfs_file_t* file,
    long delta,
    int whence);

ulong mongoc_gridfs_file_tell (mongoc_gridfs_file_t* file);

bool mongoc_gridfs_file_set_id (
    mongoc_gridfs_file_t* file,
    const(bson_value_t)* id,
    bson_error_t* error);

bool mongoc_gridfs_file_save (mongoc_gridfs_file_t* file);

void mongoc_gridfs_file_destroy (mongoc_gridfs_file_t* file);

bool mongoc_gridfs_file_error (mongoc_gridfs_file_t* file, bson_error_t* error);

bool mongoc_gridfs_file_remove (
    mongoc_gridfs_file_t* file,
    bson_error_t* error);

/* MONGOC_GRIDFS_FILE_H */

// from file mongoc-gridfs-file-page.h:
/*
 * Copyright 2013 MongoDB Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_gridfs_file_page_t;
alias mongoc_gridfs_file_page_t = _mongoc_gridfs_file_page_t;

/* MONGOC_GRIDFS_FILE_PAGE_H */

// from file mongoc-macros.h:
/*
 * Copyright 2017 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/* Decorate public functions:
 * - if MONGOC_STATIC, we're compiling a program that uses libmongoc as
 *   a static library, don't decorate functions
 * - else if MONGOC_COMPILATION, we're compiling a static or shared libmongoc,
 *   mark public functions for export from the shared lib (which has no effect
 *   on the static lib)
 * - else, we're compiling a program that uses libmongoc as a shared library,
 *   mark public functions as DLL imports for Microsoft Visual C.
 */

/*
 * Microsoft Visual C
 */

/*
 * GCC
 */

/*
 * Other compilers
 */

/* MONGOC_MACROS_H */

// from file mongoc-crypto-cng.h:
/*
 * Copyright 2016 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/* OUT */

/* OUT */

/* MONGOC_CRYPTO_CNG_H */
/* MONGOC_ENABLE_CRYPTO_CNG */

// from file mongoc-read-prefs.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum NO_MAX_STALENESS = -1;
enum SMALLEST_MAX_STALENESS_SECONDS = 90;

struct _mongoc_read_prefs_t;
alias mongoc_read_prefs_t = _mongoc_read_prefs_t;

enum mongoc_read_mode_t
{
    PRIMARY = 1,
    SECONDARY = 2,
    PRIMARY_PREFERRED = 5,
    SECONDARY_PREFERRED = 6,
    NEAREST = 10
}

mongoc_read_prefs_t* mongoc_read_prefs_new (mongoc_read_mode_t read_mode);
mongoc_read_prefs_t* mongoc_read_prefs_copy (
    const(mongoc_read_prefs_t)* read_prefs);
void mongoc_read_prefs_destroy (mongoc_read_prefs_t* read_prefs);
mongoc_read_mode_t mongoc_read_prefs_get_mode (
    const(mongoc_read_prefs_t)* read_prefs);
void mongoc_read_prefs_set_mode (
    mongoc_read_prefs_t* read_prefs,
    mongoc_read_mode_t mode);
const(bson_t)* mongoc_read_prefs_get_tags (
    const(mongoc_read_prefs_t)* read_prefs);
void mongoc_read_prefs_set_tags (
    mongoc_read_prefs_t* read_prefs,
    const(bson_t)* tags);
void mongoc_read_prefs_add_tag (
    mongoc_read_prefs_t* read_prefs,
    const(bson_t)* tag);
long mongoc_read_prefs_get_max_staleness_seconds (
    const(mongoc_read_prefs_t)* read_prefs);
void mongoc_read_prefs_set_max_staleness_seconds (
    mongoc_read_prefs_t* read_prefs,
    long max_staleness_seconds);
bool mongoc_read_prefs_is_valid (const(mongoc_read_prefs_t)* read_prefs);

/* MONGOC_READ_PREFS_H */

// from file mongoc.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/* MONGOC_H */

// from file mongoc-gridfs-file-list.h:
/*
 * Copyright 2013 MongoDB Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_gridfs_file_list_t;
alias mongoc_gridfs_file_list_t = _mongoc_gridfs_file_list_t;

mongoc_gridfs_file_t* mongoc_gridfs_file_list_next (
    mongoc_gridfs_file_list_t* list);
void mongoc_gridfs_file_list_destroy (mongoc_gridfs_file_list_t* list);
bool mongoc_gridfs_file_list_error (
    mongoc_gridfs_file_list_t* list,
    bson_error_t* error);

/* MONGOC_GRIDFS_FILE_LIST_H */

// from file mongoc-stream-tls.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_stream_tls_t;
alias mongoc_stream_tls_t = _mongoc_stream_tls_t;

bool mongoc_stream_tls_handshake (
    mongoc_stream_t* stream,
    const(char)* host,
    int timeout_msec,
    int* events,
    bson_error_t* error);
bool mongoc_stream_tls_handshake_block (
    mongoc_stream_t* stream,
    const(char)* host,
    int timeout_msec,
    bson_error_t* error);
bool mongoc_stream_tls_do_handshake (mongoc_stream_t* stream, int timeout_msec);
bool mongoc_stream_tls_check_cert (mongoc_stream_t* stream, const(char)* host);
mongoc_stream_t* mongoc_stream_tls_new_with_hostname (
    mongoc_stream_t* base_stream,
    const(char)* host,
    mongoc_ssl_opt_t* opt,
    int client);
mongoc_stream_t* mongoc_stream_tls_new (
    mongoc_stream_t* base_stream,
    mongoc_ssl_opt_t* opt,
    int client);

/* MONGOC_STREAM_TLS_H */

// from file mongoc-client.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum NAMESPACE_MAX = 128;

enum DEFAULT_CONNECTTIMEOUTMS = 10 * 1000L;

/*
 * NOTE: The default socket timeout for connections is 5 minutes. This
 *       means that if your MongoDB server dies or becomes unavailable
 *       it will take 5 minutes to detect this.
 *
 *       You can change this by providing sockettimeoutms= in your
 *       connection URI.
 */
enum DEFAULT_SOCKETTIMEOUTMS = 1000L * 60L * 5L;

/**
 * mongoc_client_t:
 *
 * The mongoc_client_t structure maintains information about a connection to
 * a MongoDB server.
 */
struct _mongoc_client_t;
alias mongoc_client_t = _mongoc_client_t;

/**
 * mongoc_stream_initiator_t:
 * @uri: The uri and options for the stream.
 * @host: The host and port (or UNIX domain socket path) to connect to.
 * @user_data: The pointer passed to mongoc_client_set_stream_initiator.
 * @error: A location for an error.
 *
 * Creates a new mongoc_stream_t for the host and port. Begin a
 * non-blocking connect and return immediately.
 *
 * This can be used by language bindings to create network transports other
 * than those built into libmongoc. An example of such would be the streams
 * API provided by PHP.
 *
 * Returns: A newly allocated mongoc_stream_t or NULL on failure.
 */
alias mongoc_stream_initiator_t = _mongoc_stream_t* function (const(mongoc_uri_t)* uri, const(mongoc_host_list_t)* host, void* user_data, bson_error_t* error);

mongoc_client_t* mongoc_client_new (const(char)* uri_string);
mongoc_client_t* mongoc_client_new_from_uri (const(mongoc_uri_t)* uri);
const(mongoc_uri_t)* mongoc_client_get_uri (const(mongoc_client_t)* client);
void mongoc_client_set_stream_initiator (
    mongoc_client_t* client,
    mongoc_stream_initiator_t initiator,
    void* user_data);
mongoc_cursor_t* mongoc_client_command (
    mongoc_client_t* client,
    const(char)* db_name,
    mongoc_query_flags_t flags,
    uint skip,
    uint limit,
    uint batch_size,
    const(bson_t)* query,
    const(bson_t)* fields,
    const(mongoc_read_prefs_t)* read_prefs);
void mongoc_client_kill_cursor (mongoc_client_t* client, long cursor_id);
bool mongoc_client_command_simple (
    mongoc_client_t* client,
    const(char)* db_name,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_client_read_command_with_opts (
    mongoc_client_t* client,
    const(char)* db_name,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_client_write_command_with_opts (
    mongoc_client_t* client,
    const(char)* db_name,
    const(bson_t)* command,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);

/* IGNORED */
bool mongoc_client_read_write_command_with_opts (
    mongoc_client_t* client,
    const(char)* db_name,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_client_command_simple_with_server_id (
    mongoc_client_t* client,
    const(char)* db_name,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    uint server_id,
    bson_t* reply,
    bson_error_t* error);
void mongoc_client_destroy (mongoc_client_t* client);
mongoc_database_t* mongoc_client_get_database (
    mongoc_client_t* client,
    const(char)* name);
mongoc_database_t* mongoc_client_get_default_database (mongoc_client_t* client);
mongoc_gridfs_t* mongoc_client_get_gridfs (
    mongoc_client_t* client,
    const(char)* db,
    const(char)* prefix,
    bson_error_t* error);
mongoc_collection_t* mongoc_client_get_collection (
    mongoc_client_t* client,
    const(char)* db,
    const(char)* collection);
char** mongoc_client_get_database_names (
    mongoc_client_t* client,
    bson_error_t* error);
mongoc_cursor_t* mongoc_client_find_databases (
    mongoc_client_t* client,
    bson_error_t* error);
bool mongoc_client_get_server_status (
    mongoc_client_t* client,
    mongoc_read_prefs_t* read_prefs,
    bson_t* reply,
    bson_error_t* error);
int mongoc_client_get_max_message_size (mongoc_client_t* client);
int mongoc_client_get_max_bson_size (mongoc_client_t* client);
const(mongoc_write_concern_t)* mongoc_client_get_write_concern (
    const(mongoc_client_t)* client);
void mongoc_client_set_write_concern (
    mongoc_client_t* client,
    const(mongoc_write_concern_t)* write_concern);
const(mongoc_read_concern_t)* mongoc_client_get_read_concern (
    const(mongoc_client_t)* client);
void mongoc_client_set_read_concern (
    mongoc_client_t* client,
    const(mongoc_read_concern_t)* read_concern);
const(mongoc_read_prefs_t)* mongoc_client_get_read_prefs (
    const(mongoc_client_t)* client);
void mongoc_client_set_read_prefs (
    mongoc_client_t* client,
    const(mongoc_read_prefs_t)* read_prefs);
void mongoc_client_set_ssl_opts (
    mongoc_client_t* client,
    const(mongoc_ssl_opt_t)* opts);

bool mongoc_client_set_apm_callbacks (
    mongoc_client_t* client,
    mongoc_apm_callbacks_t* callbacks,
    void* context);
mongoc_server_description_t* mongoc_client_get_server_description (
    mongoc_client_t* client,
    uint server_id);
mongoc_server_description_t** mongoc_client_get_server_descriptions (
    const(mongoc_client_t)* client,
    size_t* n);
void mongoc_server_descriptions_destroy_all (
    mongoc_server_description_t** sds,
    size_t n);
mongoc_server_description_t* mongoc_client_select_server (
    mongoc_client_t* client,
    bool for_writes,
    const(mongoc_read_prefs_t)* prefs,
    bson_error_t* error);
bool mongoc_client_set_error_api (mongoc_client_t* client, int version_);
bool mongoc_client_set_appname (mongoc_client_t* client, const(char)* appname);

/* MONGOC_CLIENT_H */

// from file mongoc-client-pool.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_client_pool_t;
alias mongoc_client_pool_t = _mongoc_client_pool_t;

mongoc_client_pool_t* mongoc_client_pool_new (const(mongoc_uri_t)* uri);
void mongoc_client_pool_destroy (mongoc_client_pool_t* pool);
mongoc_client_t* mongoc_client_pool_pop (mongoc_client_pool_t* pool);
void mongoc_client_pool_push (
    mongoc_client_pool_t* pool,
    mongoc_client_t* client);
mongoc_client_t* mongoc_client_pool_try_pop (mongoc_client_pool_t* pool);
void mongoc_client_pool_max_size (
    mongoc_client_pool_t* pool,
    uint max_pool_size);
void mongoc_client_pool_min_size (
    mongoc_client_pool_t* pool,
    uint min_pool_size);
void mongoc_client_pool_set_ssl_opts (
    mongoc_client_pool_t* pool,
    const(mongoc_ssl_opt_t)* opts);

bool mongoc_client_pool_set_apm_callbacks (
    mongoc_client_pool_t* pool,
    mongoc_apm_callbacks_t* callbacks,
    void* context);
bool mongoc_client_pool_set_error_api (
    mongoc_client_pool_t* pool,
    int version_);
bool mongoc_client_pool_set_appname (
    mongoc_client_pool_t* pool,
    const(char)* appname);

/* MONGOC_CLIENT_POOL_H */

// from file mongoc-opcode.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum mongoc_opcode_t
{
    REPLY = 1,
    MSG = 1000,
    UPDATE = 2001,
    INSERT = 2002,
    QUERY = 2004,
    GET_MORE = 2005,
    DELETE = 2006,
    KILL_CURSORS = 2007,
    COMPRESSED = 2012
}

/* MONGOC_OPCODE_H */

// from file mongoc-handshake.h:
/*
 * Copyright 2016 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum HANDSHAKE_APPNAME_MAX = 128;

/**
 * mongoc_handshake_data_append:
 *
 * This function is intended for use by drivers which wrap the C Driver.
 * Calling this function will store the given strings as handshake data about
 * the system and driver by appending them to the handshake data for the
 * underlying C Driver. These values, along with other handshake data collected
 * during mongoc_init will be sent to the server as part of the initial
 * connection handshake in the "client" document. This function cannot be
 * called more than once, or after a handshake has been initiated.
 *
 * The passed in strings are copied, and don't have to remain valid after the
 * call to mongoc_handshake_data_append(). The driver may store truncated
 * versions of the passed in strings.
 *
 * Note:
 *   This function allocates memory, and therefore caution should be used when
 *   using this in conjunction with bson_mem_set_vtable. If this function is
 *   called before bson_mem_set_vtable, then bson_mem_restore_vtable must be
 *   called before calling mongoc_cleanup. Failure to do so will result in
 *   memory being freed by the wrong allocator.
 *
 *
 * @driver_name: An optional string storing the name of the wrapping driver
 * @driver_version: An optional string storing the version of the wrapping
 * driver.
 * @platform: An optional string storing any information about the current
 *            platform, for example configure options or compile flags.
 *
 *
 * Returns true if the given fields are set successfully. Otherwise, it returns
 * false and logs an error.
 *
 * The default handshake data the driver sends with "isMaster" looks something
 * like:
 *  client: {
 *    driver: {
 *      name: "mongoc",
 *      version: "1.5.0"
 *    },
 *    os: {...},
 *    platform: "CC=gcc CFLAGS=-Wall -pedantic"
 *  }
 *
 * If we call
 *   mongoc_handshake_data_append ("phongo", "1.1.8", "CC=clang")
 * and it returns true, the driver sends handshake data like:
 *  client: {
 *    driver: {
 *      name: "mongoc / phongo",
 *      version: "1.5.0 / 1.1.8"
 *    },
 *    os: {...},
 *    platform: "CC=gcc CFLAGS=-Wall -pedantic / CC=clang"
 *  }
 *
 */
bool mongoc_handshake_data_append (
    const(char)* driver_name,
    const(char)* driver_version,
    const(char)* platform);


// from file mongoc-cursor.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_cursor_t;
alias mongoc_cursor_t = _mongoc_cursor_t;

/* forward decl */

mongoc_cursor_t* mongoc_cursor_clone (const(mongoc_cursor_t)* cursor);
void mongoc_cursor_destroy (mongoc_cursor_t* cursor);
bool mongoc_cursor_more (mongoc_cursor_t* cursor);
bool mongoc_cursor_next (mongoc_cursor_t* cursor, const(bson_t*)* bson);
bool mongoc_cursor_error (mongoc_cursor_t* cursor, bson_error_t* error);
bool mongoc_cursor_error_document (
    mongoc_cursor_t* cursor,
    bson_error_t* error,
    const(bson_t*)* doc);
void mongoc_cursor_get_host (mongoc_cursor_t* cursor, mongoc_host_list_t* host);
bool mongoc_cursor_is_alive (const(mongoc_cursor_t)* cursor);
const(bson_t)* mongoc_cursor_current (const(mongoc_cursor_t)* cursor);
void mongoc_cursor_set_batch_size (mongoc_cursor_t* cursor, uint batch_size);
uint mongoc_cursor_get_batch_size (const(mongoc_cursor_t)* cursor);
bool mongoc_cursor_set_limit (mongoc_cursor_t* cursor, long limit);
long mongoc_cursor_get_limit (const(mongoc_cursor_t)* cursor);

/* These names include the term "hint" for backward compatibility, should be
 * mongoc_cursor_get_server_id, mongoc_cursor_set_server_id. */
bool mongoc_cursor_set_hint (mongoc_cursor_t* cursor, uint server_id);
uint mongoc_cursor_get_hint (const(mongoc_cursor_t)* cursor);
long mongoc_cursor_get_id (const(mongoc_cursor_t)* cursor);
void mongoc_cursor_set_max_await_time_ms (
    mongoc_cursor_t* cursor,
    uint max_await_time_ms);
uint mongoc_cursor_get_max_await_time_ms (const(mongoc_cursor_t)* cursor);
mongoc_cursor_t* mongoc_cursor_new_from_command_reply (
    _mongoc_client_t* client,
    bson_t* reply,
    uint server_id);

/* MONGOC_CURSOR_H */

// from file mongoc-collection.h:
/*
 * Copyright 2013-2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



mongoc_cursor_t* mongoc_collection_aggregate (
    mongoc_collection_t* collection,
    mongoc_query_flags_t flags,
    const(bson_t)* pipeline,
    const(bson_t)* opts,
    const(mongoc_read_prefs_t)* read_prefs);
void mongoc_collection_destroy (mongoc_collection_t* collection);
mongoc_collection_t* mongoc_collection_copy (mongoc_collection_t* collection);
mongoc_cursor_t* mongoc_collection_command (
    mongoc_collection_t* collection,
    mongoc_query_flags_t flags,
    uint skip,
    uint limit,
    uint batch_size,
    const(bson_t)* command,
    const(bson_t)* fields,
    const(mongoc_read_prefs_t)* read_prefs);
bool mongoc_collection_read_command_with_opts (
    mongoc_collection_t* collection,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_collection_write_command_with_opts (
    mongoc_collection_t* collection,
    const(bson_t)* command,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);

/* IGNORED */
bool mongoc_collection_read_write_command_with_opts (
    mongoc_collection_t* collection,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_collection_command_simple (
    mongoc_collection_t* collection,
    const(bson_t)* command,
    const(mongoc_read_prefs_t)* read_prefs,
    bson_t* reply,
    bson_error_t* error);
long mongoc_collection_count (
    mongoc_collection_t* collection,
    mongoc_query_flags_t flags,
    const(bson_t)* query,
    long skip,
    long limit,
    const(mongoc_read_prefs_t)* read_prefs,
    bson_error_t* error);
long mongoc_collection_count_with_opts (
    mongoc_collection_t* collection,
    mongoc_query_flags_t flags,
    const(bson_t)* query,
    long skip,
    long limit,
    const(bson_t)* opts,
    const(mongoc_read_prefs_t)* read_prefs,
    bson_error_t* error);
bool mongoc_collection_drop (
    mongoc_collection_t* collection,
    bson_error_t* error);
bool mongoc_collection_drop_with_opts (
    mongoc_collection_t* collection,
    const(bson_t)* opts,
    bson_error_t* error);
bool mongoc_collection_drop_index (
    mongoc_collection_t* collection,
    const(char)* index_name,
    bson_error_t* error);
bool mongoc_collection_drop_index_with_opts (
    mongoc_collection_t* collection,
    const(char)* index_name,
    const(bson_t)* opts,
    bson_error_t* error);
bool mongoc_collection_create_index (
    mongoc_collection_t* collection,
    const(bson_t)* keys,
    const(mongoc_index_opt_t)* opt,
    bson_error_t* error);
bool mongoc_collection_create_index_with_opts (
    mongoc_collection_t* collection,
    const(bson_t)* keys,
    const(mongoc_index_opt_t)* opt,
    const(bson_t)* opts,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_collection_ensure_index (
    mongoc_collection_t* collection,
    const(bson_t)* keys,
    const(mongoc_index_opt_t)* opt,
    bson_error_t* error);
mongoc_cursor_t* mongoc_collection_find_indexes (
    mongoc_collection_t* collection,
    bson_error_t* error);
mongoc_cursor_t* mongoc_collection_find (
    mongoc_collection_t* collection,
    mongoc_query_flags_t flags,
    uint skip,
    uint limit,
    uint batch_size,
    const(bson_t)* query,
    const(bson_t)* fields,
    const(mongoc_read_prefs_t)* read_prefs);
mongoc_cursor_t* mongoc_collection_find_with_opts (
    mongoc_collection_t* collection,
    const(bson_t)* filter,
    const(bson_t)* opts,
    const(mongoc_read_prefs_t)* read_prefs);
bool mongoc_collection_insert (
    mongoc_collection_t* collection,
    mongoc_insert_flags_t flags,
    const(bson_t)* document,
    const(mongoc_write_concern_t)* write_concern,
    bson_error_t* error);
bool mongoc_collection_insert_bulk (
    mongoc_collection_t* collection,
    mongoc_insert_flags_t flags,
    const(bson_t*)* documents,
    uint n_documents,
    const(mongoc_write_concern_t)* write_concern,
    bson_error_t* error);
bool mongoc_collection_update (
    mongoc_collection_t* collection,
    mongoc_update_flags_t flags,
    const(bson_t)* selector,
    const(bson_t)* update,
    const(mongoc_write_concern_t)* write_concern,
    bson_error_t* error);
bool mongoc_collection_delete (
    mongoc_collection_t* collection,
    mongoc_delete_flags_t flags,
    const(bson_t)* selector,
    const(mongoc_write_concern_t)* write_concern,
    bson_error_t* error);
bool mongoc_collection_save (
    mongoc_collection_t* collection,
    const(bson_t)* document,
    const(mongoc_write_concern_t)* write_concern,
    bson_error_t* error);
bool mongoc_collection_remove (
    mongoc_collection_t* collection,
    mongoc_remove_flags_t flags,
    const(bson_t)* selector,
    const(mongoc_write_concern_t)* write_concern,
    bson_error_t* error);
bool mongoc_collection_rename (
    mongoc_collection_t* collection,
    const(char)* new_db,
    const(char)* new_name,
    bool drop_target_before_rename,
    bson_error_t* error);
bool mongoc_collection_rename_with_opts (
    mongoc_collection_t* collection,
    const(char)* new_db,
    const(char)* new_name,
    bool drop_target_before_rename,
    const(bson_t)* opts,
    bson_error_t* error);
bool mongoc_collection_find_and_modify_with_opts (
    mongoc_collection_t* collection,
    const(bson_t)* query,
    const(mongoc_find_and_modify_opts_t)* opts,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_collection_find_and_modify (
    mongoc_collection_t* collection,
    const(bson_t)* query,
    const(bson_t)* sort,
    const(bson_t)* update,
    const(bson_t)* fields,
    bool _remove,
    bool upsert,
    bool _new,
    bson_t* reply,
    bson_error_t* error);
bool mongoc_collection_stats (
    mongoc_collection_t* collection,
    const(bson_t)* options,
    bson_t* reply,
    bson_error_t* error);
mongoc_bulk_operation_t* mongoc_collection_create_bulk_operation (
    mongoc_collection_t* collection,
    bool ordered,
    const(mongoc_write_concern_t)* write_concern);
const(mongoc_read_prefs_t)* mongoc_collection_get_read_prefs (
    const(mongoc_collection_t)* collection);
void mongoc_collection_set_read_prefs (
    mongoc_collection_t* collection,
    const(mongoc_read_prefs_t)* read_prefs);
const(mongoc_read_concern_t)* mongoc_collection_get_read_concern (
    const(mongoc_collection_t)* collection);
void mongoc_collection_set_read_concern (
    mongoc_collection_t* collection,
    const(mongoc_read_concern_t)* read_concern);
const(mongoc_write_concern_t)* mongoc_collection_get_write_concern (
    const(mongoc_collection_t)* collection);
void mongoc_collection_set_write_concern (
    mongoc_collection_t* collection,
    const(mongoc_write_concern_t)* write_concern);
const(char)* mongoc_collection_get_name (mongoc_collection_t* collection);
const(bson_t)* mongoc_collection_get_last_error (
    const(mongoc_collection_t)* collection);
char* mongoc_collection_keys_to_index_string (const(bson_t)* keys);
bool mongoc_collection_validate (
    mongoc_collection_t* collection,
    const(bson_t)* options,
    bson_t* reply,
    bson_error_t* error);

/* MONGOC_COLLECTION_H */

// from file mongoc-socket.h:
/*
 * Copyright 2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



alias mongoc_socklen_t = uint;

struct _mongoc_socket_t;
alias mongoc_socket_t = _mongoc_socket_t;

struct mongoc_socket_poll_t
{
    mongoc_socket_t* socket;
    int events;
    int revents;
}

mongoc_socket_t* mongoc_socket_accept (mongoc_socket_t* sock, long expire_at);
int mongoc_socket_bind (
    mongoc_socket_t* sock,
    const(sockaddr)* addr,
    mongoc_socklen_t addrlen);
int mongoc_socket_close (mongoc_socket_t* socket);
int mongoc_socket_connect (
    mongoc_socket_t* sock,
    const(sockaddr)* addr,
    mongoc_socklen_t addrlen,
    long expire_at);
char* mongoc_socket_getnameinfo (mongoc_socket_t* sock);
void mongoc_socket_destroy (mongoc_socket_t* sock);
int mongoc_socket_errno (mongoc_socket_t* sock);
int mongoc_socket_getsockname (
    mongoc_socket_t* sock,
    sockaddr* addr,
    mongoc_socklen_t* addrlen);
int mongoc_socket_listen (mongoc_socket_t* sock, uint backlog);
mongoc_socket_t* mongoc_socket_new (int domain, int type, int protocol);
ssize_t mongoc_socket_recv (
    mongoc_socket_t* sock,
    void* buf,
    size_t buflen,
    int flags,
    long expire_at);
int mongoc_socket_setsockopt (
    mongoc_socket_t* sock,
    int level,
    int optname,
    const(void)* optval,
    mongoc_socklen_t optlen);
ssize_t mongoc_socket_send (
    mongoc_socket_t* sock,
    const(void)* buf,
    size_t buflen,
    long expire_at);
ssize_t mongoc_socket_sendv (
    mongoc_socket_t* sock,
    mongoc_iovec_t* iov,
    size_t iovcnt,
    long expire_at);
bool mongoc_socket_check_closed (mongoc_socket_t* sock);
void mongoc_socket_inet_ntop (addrinfo* rp, char* buf, size_t buflen);
ssize_t mongoc_socket_poll (
    mongoc_socket_poll_t* sds,
    size_t nsds,
    int timeout);

/* MONGOC_SOCKET_H */

// from file mongoc-matcher.h:
/*
 * Copyright 2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_matcher_t;
alias mongoc_matcher_t = _mongoc_matcher_t;

mongoc_matcher_t* mongoc_matcher_new (
    const(bson_t)* query,
    bson_error_t* error);
bool mongoc_matcher_match (
    const(mongoc_matcher_t)* matcher,
    const(bson_t)* document);
void mongoc_matcher_destroy (mongoc_matcher_t* matcher);

/* MONGOC_MATCHER_H */

// from file mongoc-stream-tls-secure-channel.h:
/*
 * Copyright 2016 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/* MONGOC_ENABLE_SSL_SECURE_CHANNEL */
/* MONGOC_STREAM_TLS_SECURE_CHANNEL_H */

// from file mongoc-log.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum LOG_DOMAIN = "mongoc";

enum mongoc_log_level_t
{
    LEVEL_ERROR = 0,
    LEVEL_CRITICAL = 1,
    LEVEL_WARNING = 2,
    LEVEL_MESSAGE = 3,
    LEVEL_INFO = 4,
    LEVEL_DEBUG = 5,
    LEVEL_TRACE = 6
}

/**
 * mongoc_log_func_t:
 * @log_level: The level of the log message.
 * @log_domain: The domain of the log message, such as "client".
 * @message: The message generated.
 * @user_data: User data provided to mongoc_log_set_handler().
 *
 * This function prototype can be used to set a custom log handler for the
 * libmongoc library. This is useful if you would like to show them in a
 * user interface or alternate storage.
 */
alias mongoc_log_func_t = void function (mongoc_log_level_t log_level, const(char)* log_domain, const(char)* message, void* user_data);

/**
 * mongoc_log_set_handler:
 * @log_func: A function to handle log messages.
 * @user_data: User data for @log_func.
 *
 * Sets the function to be called to handle logging.
 */
void mongoc_log_set_handler (mongoc_log_func_t log_func, void* user_data);

/**
 * mongoc_log:
 * @log_level: The log level.
 * @log_domain: The log domain (such as "client").
 * @format: The format string for the log message.
 *
 * Logs a message using the currently configured logger.
 *
 * This method will hold a logging lock to prevent concurrent calls to the
 * logging infrastructure. It is important that your configured log function
 * does not re-enter the logging system or deadlock will occur.
 *
 */
void mongoc_log (
    mongoc_log_level_t log_level,
    const(char)* log_domain,
    const(char)* format,
    ...);

void mongoc_log_default_handler (
    mongoc_log_level_t log_level,
    const(char)* log_domain,
    const(char)* message,
    void* user_data);

/**
 * mongoc_log_level_str:
 * @log_level: The log level.
 *
 * Returns: The string representation of log_level
 */
const(char)* mongoc_log_level_str (mongoc_log_level_t log_level);

/**
 * mongoc_log_trace_enable:
 *
 * Enables tracing at runtime (if it has been enabled at compile time).
 */
void mongoc_log_trace_enable ();

/**
 * mongoc_log_trace_disable:
 *
 * Disables tracing at runtime (if it has been enabled at compile time).
 */
void mongoc_log_trace_disable ();

/* MONGOC_LOG_H */

// from file mongoc-gridfs.h:
/*
 * Copyright 2013 MongoDB Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_gridfs_t;
alias mongoc_gridfs_t = _mongoc_gridfs_t;

mongoc_gridfs_file_t* mongoc_gridfs_create_file_from_stream (
    mongoc_gridfs_t* gridfs,
    mongoc_stream_t* stream,
    mongoc_gridfs_file_opt_t* opt);
mongoc_gridfs_file_t* mongoc_gridfs_create_file (
    mongoc_gridfs_t* gridfs,
    mongoc_gridfs_file_opt_t* opt);
mongoc_gridfs_file_list_t* mongoc_gridfs_find (
    mongoc_gridfs_t* gridfs,
    const(bson_t)* query);
mongoc_gridfs_file_t* mongoc_gridfs_find_one (
    mongoc_gridfs_t* gridfs,
    const(bson_t)* query,
    bson_error_t* error);
mongoc_gridfs_file_list_t* mongoc_gridfs_find_with_opts (
    mongoc_gridfs_t* gridfs,
    const(bson_t)* filter,
    const(bson_t)* opts);
mongoc_gridfs_file_t* mongoc_gridfs_find_one_with_opts (
    mongoc_gridfs_t* gridfs,
    const(bson_t)* filter,
    const(bson_t)* opts,
    bson_error_t* error);
mongoc_gridfs_file_t* mongoc_gridfs_find_one_by_filename (
    mongoc_gridfs_t* gridfs,
    const(char)* filename,
    bson_error_t* error);
bool mongoc_gridfs_drop (mongoc_gridfs_t* gridfs, bson_error_t* error);
void mongoc_gridfs_destroy (mongoc_gridfs_t* gridfs);
mongoc_collection_t* mongoc_gridfs_get_files (mongoc_gridfs_t* gridfs);
mongoc_collection_t* mongoc_gridfs_get_chunks (mongoc_gridfs_t* gridfs);
bool mongoc_gridfs_remove_by_filename (
    mongoc_gridfs_t* gridfs,
    const(char)* filename,
    bson_error_t* error);

/* MONGOC_GRIDFS_H */

// from file mongoc-error.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


enum ERROR_API_VERSION_LEGACY = 1;
enum ERROR_API_VERSION_2 = 2;

enum mongoc_error_domain_t
{
    CLIENT = 1,
    STREAM = 2,
    PROTOCOL = 3,
    CURSOR = 4,
    QUERY = 5,
    INSERT = 6,
    SASL = 7,
    BSON = 8,
    MATCHER = 9,
    NAMESPACE = 10,
    COMMAND = 11,
    COLLECTION = 12,
    GRIDFS = 13,
    SCRAM = 14,
    SERVER_SELECTION = 15,
    WRITE_CONCERN = 16,
    SERVER = 17 /* Error API Version 2 only */
}

enum mongoc_error_code_t
{
    STREAM_INVALID_TYPE = 1,
    STREAM_INVALID_STATE = 2,
    STREAM_NAME_RESOLUTION = 3,
    STREAM_SOCKET = 4,
    STREAM_CONNECT = 5,
    STREAM_NOT_ESTABLISHED = 6,

    CLIENT_NOT_READY = 7,
    CLIENT_TOO_BIG = 8,
    CLIENT_TOO_SMALL = 9,
    CLIENT_GETNONCE = 10,
    CLIENT_AUTHENTICATE = 11,
    CLIENT_NO_ACCEPTABLE_PEER = 12,
    CLIENT_IN_EXHAUST = 13,

    PROTOCOL_INVALID_REPLY = 14,
    PROTOCOL_BAD_WIRE_VERSION = 15,

    CURSOR_INVALID_CURSOR = 16,

    QUERY_FAILURE = 17,

    BSON_INVALID = 18,

    MATCHER_INVALID = 19,

    NAMESPACE_INVALID = 20,
    NAMESPACE_INVALID_FILTER_TYPE = 21,

    COMMAND_INVALID_ARG = 22,

    COLLECTION_INSERT_FAILED = 23,
    COLLECTION_UPDATE_FAILED = 24,
    COLLECTION_DELETE_FAILED = 25,
    COLLECTION_DOES_NOT_EXIST = 26,

    GRIDFS_INVALID_FILENAME = 27,

    SCRAM_NOT_DONE = 28,
    SCRAM_PROTOCOL_ERROR = 29,

    QUERY_COMMAND_NOT_FOUND = 59,
    QUERY_NOT_TAILABLE = 13051,

    SERVER_SELECTION_BAD_WIRE_VERSION = 13052,
    SERVER_SELECTION_FAILURE = 13053,
    SERVER_SELECTION_INVALID_ID = 13054,

    GRIDFS_CHUNK_MISSING = 13055,
    GRIDFS_PROTOCOL_ERROR = 13056,

    /* Dup with query failure. */
    PROTOCOL_ERROR = 17,

    WRITE_CONCERN_ERROR = 64,

    DUPLICATE_KEY = 11000
}

/* MONGOC_ERRORS_H */

// from file mongoc-stream-tls-secure-transport.h:
/*
 * Copyright 2016 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/* MONGOC_ENABLE_SSL_SECURE_TRANSPORT */
/* MONGOC_STREAM_TLS_SECURE_TRANSPORT_H */

// from file mongoc-init.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


void mongoc_init ();
void mongoc_cleanup ();

/* MONGOC_INIT_H */

// from file mongoc-ssl.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


alias mongoc_ssl_opt_t = _mongoc_ssl_opt_t;

struct _mongoc_ssl_opt_t
{
    const(char)* pem_file;
    const(char)* pem_pwd;
    const(char)* ca_file;
    const(char)* ca_dir;
    const(char)* crl_file;
    bool weak_cert_validation;
    bool allow_invalid_hostname;
    void*[7] padding;
}

const(mongoc_ssl_opt_t)* mongoc_ssl_opt_get_default ();

/* MONGOC_SSL_H */

// from file mongoc-stream-socket.h:
/*
 * Copyright 2014 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


struct _mongoc_stream_socket_t;
alias mongoc_stream_socket_t = _mongoc_stream_socket_t;

mongoc_stream_t* mongoc_stream_socket_new (mongoc_socket_t* socket);
mongoc_socket_t* mongoc_stream_socket_get_socket (
    mongoc_stream_socket_t* stream);

/* MONGOC_STREAM_SOCKET_H */

// from file mongoc-flags.h:
/*
 * Copyright 2013 MongoDB, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/**
 * mongoc_delete_flags_t:
 * @MONGOC_DELETE_NONE: Specify no delete flags.
 * @MONGOC_DELETE_SINGLE_REMOVE: Only remove the first document matching the
 *    document selector.
 *
 * This type is only for use with deprecated functions and should not be
 * used in new code. Use mongoc_remove_flags_t instead.
 *
 * #mongoc_delete_flags_t are used when performing a delete operation.
 */
enum mongoc_delete_flags_t
{
    NONE = 0,
    SINGLE_REMOVE = 1
}

/**
 * mongoc_remove_flags_t:
 * @MONGOC_REMOVE_NONE: Specify no delete flags.
 * @MONGOC_REMOVE_SINGLE_REMOVE: Only remove the first document matching the
 *    document selector.
 *
 * #mongoc_remove_flags_t are used when performing a remove operation.
 */
enum mongoc_remove_flags_t
{
    NONE = 0,
    SINGLE_REMOVE = 1
}

/**
 * mongoc_insert_flags_t:
 * @MONGOC_INSERT_NONE: Specify no insert flags.
 * @MONGOC_INSERT_CONTINUE_ON_ERROR: Continue inserting documents from
 *    the insertion set even if one fails.
 *
 * #mongoc_insert_flags_t are used when performing an insert operation.
 */
enum mongoc_insert_flags_t
{
    NONE = 0,
    CONTINUE_ON_ERROR = 1
}

enum INSERT_NO_VALIDATE = 1U << 31;

/**
 * mongoc_query_flags_t:
 * @MONGOC_QUERY_NONE: No query flags supplied.
 * @MONGOC_QUERY_TAILABLE_CURSOR: Cursor will not be closed when the last
 *    data is retrieved. You can resume this cursor later.
 * @MONGOC_QUERY_SLAVE_OK: Allow query of replica slave.
 * @MONGOC_QUERY_OPLOG_REPLAY: Used internally by Mongo.
 * @MONGOC_QUERY_NO_CURSOR_TIMEOUT: The server normally times out idle
 *    cursors after an inactivity period (10 minutes). This prevents that.
 * @MONGOC_QUERY_AWAIT_DATA: Use with %MONGOC_QUERY_TAILABLE_CURSOR. Block
 *    rather than returning no data. After a period, time out.
 * @MONGOC_QUERY_EXHAUST: Stream the data down full blast in multiple
 *    "more" packages. Faster when you are pulling a lot of data and
 *    know you want to pull it all down.
 * @MONGOC_QUERY_PARTIAL: Get partial results from mongos if some shards
 *    are down (instead of throwing an error).
 *
 * #mongoc_query_flags_t is used for querying a Mongo instance.
 */
enum mongoc_query_flags_t
{
    NONE = 0,
    TAILABLE_CURSOR = 2,
    SLAVE_OK = 4,
    OPLOG_REPLAY = 8,
    NO_CURSOR_TIMEOUT = 16,
    AWAIT_DATA = 32,
    EXHAUST = 64,
    PARTIAL = 128
}

/**
 * mongoc_reply_flags_t:
 * @MONGOC_REPLY_NONE: No flags set.
 * @MONGOC_REPLY_CURSOR_NOT_FOUND: Cursor was not found.
 * @MONGOC_REPLY_QUERY_FAILURE: Query failed, error document provided.
 * @MONGOC_REPLY_SHARD_CONFIG_STALE: Shard configuration is stale.
 * @MONGOC_REPLY_AWAIT_CAPABLE: Wait for data to be returned until timeout
 *    has passed. Used with %MONGOC_QUERY_TAILABLE_CURSOR.
 *
 * #mongoc_reply_flags_t contains flags supplied by the Mongo server in reply
 * to a request.
 */
enum mongoc_reply_flags_t
{
    NONE = 0,
    CURSOR_NOT_FOUND = 1,
    QUERY_FAILURE = 2,
    SHARD_CONFIG_STALE = 4,
    AWAIT_CAPABLE = 8
}

/**
 * mongoc_update_flags_t:
 * @MONGOC_UPDATE_NONE: No update flags specified.
 * @MONGOC_UPDATE_UPSERT: Perform an upsert.
 * @MONGOC_UPDATE_MULTI_UPDATE: Continue updating after first match.
 *
 * #mongoc_update_flags_t is used when updating documents found in Mongo.
 */
enum mongoc_update_flags_t
{
    NONE = 0,
    UPSERT = 1,
    MULTI_UPDATE = 2
}

enum UPDATE_NO_VALIDATE = 1U << 31;

/* MONGOC_FLAGS_H */
