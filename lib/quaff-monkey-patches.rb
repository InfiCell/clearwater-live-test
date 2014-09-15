STANDARD_SDP = "v=0\r
o=- 3547439529 3547439529 IN IP4 0.0.0.0\r
s=-\r
c=IN IP4 0.0.0.0\r
t=0 0\r
m=audio 6000 RTP/AVP 8 0\r
a=rtpmap:8 PCMA/8000\r
a=rtpmap:101 telephone-event/8000\r
a=fmtp:101 0-11,16\r
"

module Quaff
  class Call
    def send_invite_with_sdp
      send_request("INVITE", STANDARD_SDP, {"Content-Type" => "application/sdp"})
    end

    def send_200_with_sdp
      send_response("200", "OK", STANDARD_SDP, nil, {"Content-Type" => "application/sdp"})
    end

    def recv_200_and_notify
      resp1 = recv_any_of [200, "NOTIFY"]
      resp2 = recv_any_of [200, "NOTIFY"]

      notify = resp1.method ? resp1 : resp2
      return notify
    end
  end
end

