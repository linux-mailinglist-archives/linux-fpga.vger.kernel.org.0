Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13FB3578AE
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 01:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhDGX4m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Apr 2021 19:56:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:17720 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhDGX4m (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Apr 2021 19:56:42 -0400
IronPort-SDR: Ti1fEK4jfRV4V1+RPhaBBQdefF4rUCp94R/TTbkO1z7HPpSMrxT7/xYBLdE7z/xQ56dDDBy7MX
 Oio6EELgcgJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="254762316"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="254762316"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 16:56:31 -0700
IronPort-SDR: t5CiwFz5Lu+BNxSS40652eecGSams4gItonXqwSAVftqVDrk9zPY7Xt8kUk728G67LLRJS9ABl
 gfykdcabkWOw==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="380024511"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.251.24.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 16:56:31 -0700
To:     Moritz Fischer <mdf@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
From:   Russ Weight <russell.h.weight@intel.com>
Subject: RFC: Integrating secure update functions into the FPGA Manager
Message-ID: <60ff2054-8ee1-7bc8-7981-9249e3ee42c7@intel.com>
Date:   Wed, 7 Apr 2021 16:56:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

Please see below my analysis of the effort to integrate secure functions
into the FPGA Manager. I have recommendations interspersed below. The
bottom line is that it seems like there is very little opportunity to
share code. I could try to rewrite the fpga_mgr_load() related functions
to accommodate worker threads, cancellation, and progress updates, but I'm
not sure there is enough value-add to justify the the additional complexity,
especially for the scatter-gather versions. The other options is to just
port the secure-manager functions into the FPGA Manager.

- Russ

=======================================================================

This is a comparison of the FPGA Security Manager patch-set with the
current FPGA Manager. Recommendations are provided on how to the extend
the FPGA Manager to support the Security Manager functions.

Purpose of the FPGA Security Manager Class Driver
=================================================

The security manager provides a common user API (via sysfs) for transferring
an opaque image to the card BMC for validation and disposition with a
completion time of up to 40 minutes. A separate trigger function (image_load)
can be used to activate a previously transferred image (e.g. FPGA Static
Region or BMC image).

Note that secure updates have no notion of Regions, Bridges or FPGA
running state.

A successful merge of the Security Manager with the FPGA Manager would include
an extension of the FPGA Manager API to provide sysfs nodes to support secure
updates.

The FPGA Security Manager API
=============================

Image Update (transfer data to Card BMC for validation & storage)
  WO: filename, cancel
  RO: name, status, error, hw_errinfo, remaining_size

Image Load (trigger BMC, FPGA, or FW load from FLASH)
  RO: available_images  # Images that can be loaded/activated
  WO: image_load:       # Trigger an image load


Merging Security Manager and FPGA Manager functions (organized by sysfs-node)
=============================================================================

The "name" sysfs node has essentially the same purpose, so no change is
required.

The sec-mgr "status" is similar to fpga-mgr "state"
The sec-mgr "error" is simliar to fpga-mgr "status"

All others are unique to the security manager.

* RECOMMENDATION: The secure-update sysfs files should be grouped together
* in "secure-update" sysfs directory to clearly associate them with the
* secure update process and separate them from the other driver functions.

The sec-mgr sysfs status file has some similarity to the fpga-mgr sysfs
state file:

    Sec-Mgr status             FPGA-Mgr state
    --------------             --------------
                            FPGA_MGR_STATE_UNKNOWN
                            FPGA_MGR_STATE_POWER_OFF
                            FPGA_MGR_STATE_POWER_UP
                            FPGA_MGR_STATE_RESET
FPGA_SEC_PROG_IDLE
FPGA_SEC_PROG_READING       FPGA_MGR_STATE_FIRMWARE_REQ
                            FPGA_MGR_STATE_FIRMWARE_REQ_ERR
FPGA_SEC_PROG_PREPARING     FPGA_MGR_STATE_WRITE_INIT
                            FPGA_MGR_STATE_WRITE_INIT_ERR
FPGA_SEC_PROG_WRITING       FPGA_MGR_STATE_WRITE
                            FPGA_MGR_STATE_WRITE_ERR
FPGA_SEC_PROG_PROGRAMMING   FPGA_MGR_STATE_WRITE_COMPLETE
                            FPGA_MGR_STATE_WRITE_COMPLETE_ERR
                            FPGA_MGR_STATE_OPERATING
FPGA_SEC_PROG_IDLE

The sec-mgr sysfs error file seems to be similar in purpose to the
fpga-mgr sysfs status file, but there is no overlap in the actual
error codes.

* RECOMMENDATION: there is not enough similarity between the status/state and
* error/status nodes to try to share them. If all of the other secure-update
* related nodes are grouped together in a secure-update directory, it would
* probably create confusion to try to share the state and status files that
* are in a different location.

sysfs: filename
===============

In the current security manager patches, writing the name of an image file
to "filename" is roughly equivalent to creating a worker thread and having it
call fpga_mgr_load() with info->firmware_name set to the image file name.

The update sequences are similar:

    Sec-Mgr ops flow        FPGA-Mgr ops flow
    ================        =================
    prepare()               write_init()
    # Loop on 16KB blocks   write()
      write_blk()
    poll_complete()         write_complete()

In the worst case, we have seen n3000 FPGA image updates take up to 40
minutes. The remaining_size is updated between each 16KB block to
allow users to monitor the progress of the data transfer. The sec-mgr
also checks for a cancel flag between each 16KB write and between
each stage of the update.

The fpga_mgr has a "buffer" flow and a "scatter-gather" flow. The sec-mgr
flow is always started via sysfs and uses request_firmware(), so it only
needs one (buffer) flow.

* RECOMMENDATION: keep the update functions separate. Although they are
* similar, the fpga-mgr updates are simpler and more readable as they
* are. The sec-mgr update is done via kernel worker thread and is a little
* more complicated with support for maintaining the remaining size and
* with support for cancellation. There currently no need for a scatter-gather
* secure update implementation since secure updates use request_firmware.

Note that the sec-mgr supports additional ops:
    cancel()         : send cancel-request to lower-level driver
    cleanup()        : optional: called if and only if the prepare op succeeds
    get_hw_errinfo() : optional: provides device-specific 64-bit error info

sysfs: cancel, status, error, hw_errinfo, remaining_size
========================================================

* RECOMMENDATION: There are no equivalent features in fpga-mgr. Port
* these each from the security manager to the FPGA Manager.

sysfs: available_images, load_image
===================================

  available_images: RO: list device-specific keywords that can be used
                    to trigger an image to be loaded/activated. eg.
                    fpga_factory, fpga_user1, fpga_user2, bmc_factory.

  load_image:       WO: trigger the load/activation of an image from FLASH

* RECOMMENDATION: Nothing similar in fpga-mgr. Port functionality to the
* FPGA Manager

Conclusion
==========

The purpose of the secure-update support is to provide a common user API
for loading an opaque image to a device with completion times of up to 40
minutes. The FPGA Manager can be extended to include the sysfs nodes
required for a secure update. There is very little opportunity for shared
code between the current FPGA Manager and the secure update support.  For
the most part, this would be an addition of new functionality.


