# add_field adds a ke y-value pair to the metadata objects generated by get_io_format
# Takes an input and output filter as parameters
# Capable of adding data to any of the objects in the metadata JSON (input, output, subrule, transform_path, etc)
# This function should be used for adding all metadata to your output - It scrubs illegal characters like | and \n
# Example function call: add_field(.input.field1; .output.subject)
def add_field($input_field; output_field):
    # input_field validation check
    if
        $input_field
    then
        # Convert input_field value as Json text string
        if
            ($input_field | type == "string")
        then
            # Strip out control codes and extended characters from input field value. This includes characters like: [\b \t \n \u000b \f \r \u000e \u000f]
            ($input_field | explode | map(select(. > 31)) | implode) as $strip_control
            |
            # Retain the | removal to support regex parsing in SIEM
            if ($strip_control | contains("|")) then ($strip_control | split("|") | join ("-")) as $strip_pipe else $strip_control as $strip_pipe end
            |
            # Cleanup completed
            output_field = $strip_pipe
        else
            output_field = $input_field
        end
    else
        .
    end
;


def sdp($message):
    # Lr Metadata Mapping - Input to Output
    if ($message.time | length) > 0 then add_field($message.time; .output.time) else . end |
    if ($message.timestamp.epoch | length) > 0 then add_field(($message.timestamp.epoch); .output.normal_msg_date) else . end |
    if ($message.timestamp.iso8601 | length) > 0 then add_field(($message.timestamp.iso8601 | fromdate); .output.normal_msg_date) else . end |
    if ($message.object | length) > 0 then add_field($message.object; .output.object) else . end |
    if ($message.objectname | length) > 0 then add_field($message.objectname; .output.objectname) else . end |
    if ($message.objecttype | length) > 0 then add_field($message.objecttype; .output.objecttype) else . end |
    if ($message.hash | length) > 0 then add_field($message.hash; .output.hash) else . end |
    if ($message.policy | length) > 0 then add_field($message.policy; .output.policy) else . end |
    if ($message.result | length) > 0 then add_field($message.result; .output.result) else . end |
    if ($message.url | length) > 0 then add_field($message.url; .output.url) else . end |
    if ($message.useragent | length) > 0 then add_field($message.useragent; .output.useragent) else . end |
    if ($message.responsecode | length) > 0 then add_field($message.responsecode; .output.responsecode) else . end |
    if ($message.subject | length) > 0 then add_field($message.subject; .output.subject) else . end |
    if ($message.version | length) > 0 then add_field($message.version; .output.version) else . end |
    if ($message.command | length) > 0 then add_field($message.command; .output.command) else . end |
    if ($message.reason | length) > 0 then add_field($message.reason; .output.reason) else . end |
    if ($message.action | length) > 0 then add_field($message.action?; .output.action) else . end |
    if ($message.status | length) > 0 then add_field($message.status; .output.status) else . end |
    if ($message.sessiontype | length) > 0 then add_field($message.sessiontype; .output.sessiontype) else . end |
    if ($message.process | length) > 0 then add_field($message.process?; .output.process) else . end   |
    if ($message.processid | length) > 0 then add_field($message.processid; .output.processid) else . end |
    if ($message.parentprocessid | length) > 0 then add_field($message.parentprocessid; .output.parentprocessid) else . end |
    if ($message.parentprocessname | length) > 0 then add_field($message.parentprocessname; .output.parentprocessname) else . end |
    if ($message.parentprocesspath | length) > 0 then add_field($message.parentprocesspath; .output.parentprocesspath) else . end |
    if ($message.quantity | length) > 0 then add_field($message.quantity; .output.quantity) else . end |
    if ($message.amount | length) > 0 then add_field($message.amount; .output.amount) else . end |
    if ($message.size | length) > 0 then add_field($message.size; .output.size) else . end |
    if ($message.rate | length) > 0 then add_field($message.rate; .output.rate) else . end |
    if ($message.minutes | length) > 0 then add_field($message.minutes; .output.minutes) else . end |
    if ($message.seconds | length) > 0 then add_field($message.seconds; .output.seconds) else . end |
    if ($message.milliseconds | length) > 0 then add_field($message.milliseconds; .output.milliseconds) else . end |    
    if ($message.session | length) > 0 then add_field($message.session; .output.session) else . end |
    if ($message.kilobytesin | length) > 0 then add_field($message.kilobytesin; .output.kilobytesin) else . end |
    if ($message.kilobytesout | length) > 0 then add_field($message.kilobytesout; .output.kilobytesin) else . end |
    if ($message.kilobytes | length) > 0 then add_field($message.kilobytes; .output.kilobytes) else . end |
    if ($message.packetsin | length) > 0 then add_field($message.packetsin; .output.packetsin) else . end |
    if ($message.packetsout | length) > 0 then add_field($message.packetsout; .output.packetsout) else . end |
    if ($message.severity | length) > 0 then add_field($message.severity; .output.severity) else . end |
    if ($message.vmid | length) > 0 then add_field($message.vmid; .output.vmid) else . end |
    if ($message.vendorinfo | length) > 0 then add_field($message.vendorinfo; .output.vendorinfo) else . end |
    if ($message.threatname | length) > 0 then add_field($message.threatname; .output.threatname) else . end |
    if ($message.threatid | length) > 0 then add_field($message.threatid; .output.threatid) else . end |
    if ($message.cve | length) > 0 then add_field($message.cve; .output.cve) else . end |
    if ($message.smac | length) > 0 then add_field($message.smac; .output.smac) else . end |
    if ($message.dmac | length) > 0 then add_field($message.dmac; .output.dmac) else . end |
    if ($message.sinterface | length) > 0 then add_field($message.sinterface; .output.sinterface) else . end |
    if ($message.dinterface | length) > 0 then add_field($message.dinterface; .output.dinterface) else . end |
    if ($message.sip | length) > 0 then add_field($message.sip; .output.sip) else . end |
    if ($message.dip | length) > 0 then add_field($message.dip; .output.dip) else . end |
    if ($message.snatip | length) > 0 then add_field($message.snatip; .output.snatip) else . end |
    if ($message.dnatip | length) > 0 then add_field($message.dnatip; .output.dnatip) else . end |
    if ($message.sname | length) > 0 then add_field($message.sname; .output.sname) else . end |
    if ($message.dname | length) > 0 then add_field($message.dname; .output.dname) else . end |
    if ($message.serialnumber | length) > 0 then add_field($message.serialnumber; .output.serialnumber) else . end |
    if ($message.login | length) > 0 then add_field($message.login; .output.login) else . end |
    if ($message.account | length) > 0 then add_field($message.account; .output.account) else . end |
    if ($message.sender | length) > 0 then add_field($message.sender; .output.sender) else . end |
    if ($message.recipient | length) > 0 then add_field($message.recipient; .output.recipient) else . end |
    if ($message.group | length) > 0 then add_field($message.group; .output.group) else . end |
    if ($message.domainimpacted | length) > 0 then add_field($message.domainimpacted; .output.domainimpacted) else . end |
    if ($message.domainorigin | length) > 0 then add_field($message.domainorigin; .output.domainorigin) else . end |
    if ($message.protnum | length) > 0 then add_field($message.protnum; .output.protnum) else . end |
    if ($message.protname | length) > 0 then add_field($message.protname; .output.protname) else . end |
    if ($message.sport | length) > 0 then add_field($message.sport; .output.sport) else . end |
    if ($message.dport | length) > 0 then add_field($message.dport; .output.dport) else . end |
    if ($message.snatport | length) > 0 then add_field($message.snatport; .output.snatport) else . end |
    if ($message.dnatport | length) > 0 then add_field($message.dnatport; .output.dnatport) else . end |
    if ($message.tag1 | length) > 0 then add_field($message.tag1; .output.tag1) else . end |
    if ($message.tag2 | length) > 0 then add_field($message.tag2; .output.tag2) else . end |
    if ($message.tag3 | length) > 0 then add_field($message.tag3; .output.tag3) else . end |
    if ($message.tag4 | length) > 0 then add_field($message.tag4; .output.tag4) else . end |
    if ($message.tag5 | length) > 0 then add_field($message.tag5; .output.tag5) else . end |
    if ($message.tag6 | length) > 0 then add_field($message.tag6; .output.tag6) else . end |
    if ($message.tag7 | length) > 0 then add_field($message.tag7; .output.tag7) else . end |
    if ($message.tag8 | length) > 0 then add_field($message.tag8; .output.tag8) else . end |
    if ($message.tag9 | length) > 0 then add_field($message.tag9; .output.tag9) else . end |
    if ($message.tag10 | length) > 0 then add_field($message.tag10; .output.tag10) else . end |
    if ($message.fullyqualifiedbeatname | length) > 0 then add_field($message.fullyqualifiedbeatname; .output.fullyqualifiedbeatname) else . end |
    if $message.original_message == "nullstring" then .output.original_message = "" elif ($message.original_message | length) > 0 then add_field(($message.original_message | tojson); .output.original_message) else . end |
    .
;
