#!/usr/bin/env python3

import pyhid_usb_relay
relay = pyhid_usb_relay.find()      # should now succeed
relay.set_state(1, True)            # CH1 ON
relay.set_state(2, True)           # CH2 OFF
