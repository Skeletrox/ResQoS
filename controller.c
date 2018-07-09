#include <stdio.h>
#include "apr_hash.h"
#include "ap_config.h"
#include "ap_provider.h"
#include "httpd.h"
#include "http_core.h"
#include "http_config.h"
#include "http_log.h"
#include "http_protocol.h"
#include "http_request.h"
#include <stdlib.h>
#include <string.h>


static int connect_handler(request_rec *r)
{
    /*
    * My my my, what have we here?
    */
    char clt_ip[30];
    char srv_ip[30];
    char new_string[100];
    ap_log_error(APLOG_MARK, APLOG_CRIT, 0, NULL, "This must be printed first %s", r->method);
    int clt_port = r->connection->client_addr->port;
    int srv_port = r->connection->local_addr->port;
    ap_log_error(APLOG_MARK, APLOG_CRIT, 0, NULL, "This must be printed next");
    char uri[100];
    strcpy(srv_ip, r->connection->local_ip);
    strcpy(clt_ip, r->connection->client_ip);
    ap_log_error(APLOG_MARK, APLOG_CRIT, 0, NULL, "This must be printed");
    strcpy(uri, r->unparsed_uri);
/*
    sprintf(new_string, "'{ \"lh\":\"%s\", \"lp\":%d, \"rh\":\"%s\", \"rp\":%d, \"uri\":\"%s\" }'", clt_ip, clt_port, srv_ip, srv_port, uri);
    char command[1000] = "curl -XPOST 10.42.0.1:8000/api/v1/createRules -H \"Content-Type: application/json\" -d ";
*/
    sprintf(new_string, "%s %d %s %d %s connect", clt_ip, clt_port, srv_ip, srv_port, uri);
    char command[1000] = /*"ssh -t admin@192.168.10.1 ./tc_script.sh "*/ "/home/admin/script.sh ";
    strcat(command, new_string);
    ap_log_error(APLOG_MARK, APLOG_CRIT, 0, NULL, "Hello there, %s:%d trying to connect to %s:%d, you are a bold one. Also, %s", clt_ip, clt_port,srv_ip, srv_port, command);
    system(command);
    /*
     * We do not care for this request. We decline to have anything to do with it.
     */
    return DECLINED;
}

static int goodbye_handler(request_rec *r) {
    /*
     * Goodbye, Moon Man.
     */
    char clt_ip[30];
    char srv_ip[30];
    char new_string[100];
    char uri[1000];
    strcpy(srv_ip, r->connection->local_ip);
    strcpy(clt_ip, r->connection->client_ip);
    strcpy(uri, r->unparsed_uri);
    int clt_port = r->connection->client_addr->port;
    int srv_port = r->connection->local_addr->port;
/*
    sprintf(new_string, "'{ \"lh\":\"%s\", \"lp\":%d, \"rh\":\"%s\", \"rp\":%d, \"uri\":\"%s\" }'", clt_ip, clt_port, srv_ip, srv_port, uri);
    char command[1000] = "curl -XPOST 10.42.0.1:8000/api/v1/deleteRules -H \"Content-Type: application/json\" -d ";
*/
    sprintf(new_string, "%s %d %s %d %s disconnect", clt_ip, clt_port, srv_ip, srv_port, uri);
    char command[1000] = /*"ssh -t admin@192.168.10.1 ./tc_script.sh "*/ "/home/admin/script.sh ";
    strcat(command, new_string);
    system(command);
    ap_log_error(APLOG_MARK, APLOG_CRIT, 0, NULL, "Hello there, %s:%d trying to disconnect from %s:%d, you are a bold one. Also, %s", clt_ip, clt_port,srv_ip, srv_port, command);
    return DECLINED;
}


static void register_hooks(apr_pool_t *pool)
{
    // Call the
    ap_hook_handler(connect_handler, NULL, NULL, APR_HOOK_FIRST);
    ap_hook_log_transaction(goodbye_handler, NULL, NULL, APR_HOOK_LAST);
}


module AP_MODULE_DECLARE_DATA   example_module =
{
    STANDARD20_MODULE_STUFF,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    register_hooks   /* Our hook registering function */
};
