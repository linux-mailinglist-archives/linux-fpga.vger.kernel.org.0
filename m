Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D036FDFE
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Apr 2021 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhD3PpV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Apr 2021 11:45:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:16210 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhD3PpU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 30 Apr 2021 11:45:20 -0400
IronPort-SDR: 36/nYk4lAVC5POqGAeLUZw1EY57LPL8hq5DCc7vO8/0DxIPti63ZFUppl8yVcc/ZzN6Iv0+kKu
 Hmo5OyhPMS1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="197351179"
X-IronPort-AV: E=Sophos;i="5.82,263,1613462400"; 
   d="scan'208";a="197351179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 08:44:30 -0700
IronPort-SDR: 9VdMOuWG/2j6LPsytWXLCP60nNHiYTk+Ekbz/avucRXZ0MTf6rUuvlOpTcdaOh7LXukcLplbNG
 RI0eYwdCdosA==
X-IronPort-AV: E=Sophos;i="5.82,263,1613462400"; 
   d="scan'208";a="459490996"
Received: from wrajski-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.215.158])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 08:44:27 -0700
Subject: Re: RFC: Integrating secure update functions into the FPGA Manager
To:     Moritz Fischer <mdf@kernel.org>
Cc:     "Xu, Yilun" <yilun.xu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <60ff2054-8ee1-7bc8-7981-9249e3ee42c7@intel.com>
 <YIoxtaudnbYySm1P@archbook>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <2dea0699-eb3c-c11e-6c29-f88deeafd099@intel.com>
Date:   Fri, 30 Apr 2021 08:44:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIoxtaudnbYySm1P@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Moritz,


On 4/28/21 9:10 PM, Moritz Fischer wrote:
> Hi Russ,
>
> On Wed, Apr 07, 2021 at 04:56:29PM -0700, Russ Weight wrote:
>> Hi Moritz,
>>
>> Please see below my analysis of the effort to integrate secure functions
>> into the FPGA Manager. I have recommendations interspersed below. The
>> bottom line is that it seems like there is very little opportunity to
>> share code. I could try to rewrite the fpga_mgr_load() related functions
>> to accommodate worker threads, cancellation, and progress updates, but I'm
>> not sure there is enough value-add to justify the the additional complexity,
>> especially for the scatter-gather versions. The other options is to just
>> port the secure-manager functions into the FPGA Manager.
>>
>> - Russ
>>
>> =======================================================================
>>
>> This is a comparison of the FPGA Security Manager patch-set with the
>> current FPGA Manager. Recommendations are provided on how to the extend
>> the FPGA Manager to support the Security Manager functions.
>>
>> Purpose of the FPGA Security Manager Class Driver
>> =================================================
>>
>> The security manager provides a common user API (via sysfs) for transferring
>> an opaque image to the card BMC for validation and disposition with a
>> completion time of up to 40 minutes. A separate trigger function (image_load)
>> can be used to activate a previously transferred image (e.g. FPGA Static
>> Region or BMC image).
>>
>> Note that secure updates have no notion of Regions, Bridges or FPGA
>> running state.
> Not needed.
>> A successful merge of the Security Manager with the FPGA Manager would include
>> an extension of the FPGA Manager API to provide sysfs nodes to support secure
>> updates.
> Yes.
>> The FPGA Security Manager API
>> =============================
>>
>> Image Update (transfer data to Card BMC for validation & storage)
>>   WO: filename, cancel
>>   RO: name, status, error, hw_errinfo, remaining_size
>>
>> Image Load (trigger BMC, FPGA, or FW load from FLASH)
>>   RO: available_images  # Images that can be loaded/activated
>>   WO: image_load:       # Trigger an image load
>>
>>
>> Merging Security Manager and FPGA Manager functions (organized by sysfs-node)
>> =============================================================================
>>
>> The "name" sysfs node has essentially the same purpose, so no change is
>> required.
>>
>> The sec-mgr "status" is similar to fpga-mgr "state"
>> The sec-mgr "error" is simliar to fpga-mgr "status"
>>
>> All others are unique to the security manager.
>>
>> * RECOMMENDATION: The secure-update sysfs files should be grouped together
>> * in "secure-update" sysfs directory to clearly associate them with the
>> * secure update process and separate them from the other driver functions.
> SGTM.
>> The sec-mgr sysfs status file has some similarity to the fpga-mgr sysfs
>> state file:
>>
>>     Sec-Mgr status             FPGA-Mgr state
>>     --------------             --------------
>>                             FPGA_MGR_STATE_UNKNOWN
>>                             FPGA_MGR_STATE_POWER_OFF
>>                             FPGA_MGR_STATE_POWER_UP
>>                             FPGA_MGR_STATE_RESET
>> FPGA_SEC_PROG_IDLE
>> FPGA_SEC_PROG_READING       FPGA_MGR_STATE_FIRMWARE_REQ
>>                             FPGA_MGR_STATE_FIRMWARE_REQ_ERR
>> FPGA_SEC_PROG_PREPARING     FPGA_MGR_STATE_WRITE_INIT
>>                             FPGA_MGR_STATE_WRITE_INIT_ERR
>> FPGA_SEC_PROG_WRITING       FPGA_MGR_STATE_WRITE
>>                             FPGA_MGR_STATE_WRITE_ERR
>> FPGA_SEC_PROG_PROGRAMMING   FPGA_MGR_STATE_WRITE_COMPLETE
>>                             FPGA_MGR_STATE_WRITE_COMPLETE_ERR
>>                             FPGA_MGR_STATE_OPERATING
>> FPGA_SEC_PROG_IDLE
>>
>> The sec-mgr sysfs error file seems to be similar in purpose to the
>> fpga-mgr sysfs status file, but there is no overlap in the actual
>> error codes.
>>
>> * RECOMMENDATION: there is not enough similarity between the status/state and
>> * error/status nodes to try to share them. If all of the other secure-update
>> * related nodes are grouped together in a secure-update directory, it would
>> * probably create confusion to try to share the state and status files that
>> * are in a different location.
> Yes.
>> sysfs: filename
>> ===============
>>
>> In the current security manager patches, writing the name of an image file
>> to "filename" is roughly equivalent to creating a worker thread and having it
>> call fpga_mgr_load() with info->firmware_name set to the image file name.
>>
>> The update sequences are similar:
>>
>>     Sec-Mgr ops flow        FPGA-Mgr ops flow
>>     ================        =================
>>     prepare()               write_init()
>>     # Loop on 16KB blocks   write()
>>       write_blk()
>>     poll_complete()         write_complete()
>>
>> In the worst case, we have seen n3000 FPGA image updates take up to 40
>> minutes. The remaining_size is updated between each 16KB block to
>> allow users to monitor the progress of the data transfer. The sec-mgr
>> also checks for a cancel flag between each 16KB write and between
>> each stage of the update.
>>
>> The fpga_mgr has a "buffer" flow and a "scatter-gather" flow. The sec-mgr
>> flow is always started via sysfs and uses request_firmware(), so it only
>> needs one (buffer) flow.
>>
>> * RECOMMENDATION: keep the update functions separate. Although they are
>> * similar, the fpga-mgr updates are simpler and more readable as they
>> * are. The sec-mgr update is done via kernel worker thread and is a little
>> * more complicated with support for maintaining the remaining size and
>> * with support for cancellation. There currently no need for a scatter-gather
>> * secure update implementation since secure updates use request_firmware.
>>
>> Note that the sec-mgr supports additional ops:
>>     cancel()         : send cancel-request to lower-level driver
>>     cleanup()        : optional: called if and only if the prepare op succeeds
>>     get_hw_errinfo() : optional: provides device-specific 64-bit error info
>>
>> sysfs: cancel, status, error, hw_errinfo, remaining_size
>> ========================================================
>>
>> * RECOMMENDATION: There are no equivalent features in fpga-mgr. Port
>> * these each from the security manager to the FPGA Manager.
> SGTM.
>> sysfs: available_images, load_image
>> ===================================
>>
>>   available_images: RO: list device-specific keywords that can be used
>>                     to trigger an image to be loaded/activated. eg.
>>                     fpga_factory, fpga_user1, fpga_user2, bmc_factory.
>>
>>   load_image:       WO: trigger the load/activation of an image from FLASH
>>
>> * RECOMMENDATION: Nothing similar in fpga-mgr. Port functionality to the
>> * FPGA Manager
>>
>> Conclusion
>> ==========
>>
>> The purpose of the secure-update support is to provide a common user API
>> for loading an opaque image to a device with completion times of up to 40
>> minutes. The FPGA Manager can be extended to include the sysfs nodes
>> required for a secure update. There is very little opportunity for shared
>> code between the current FPGA Manager and the secure update support.  For
>> the most part, this would be an addition of new functionality.
> Sounds good to me overall, sorry for the late response.

Thanks for the feedback Mortiz. Have you had a chance to look at the follow-up
patch that I sent out? Between the cover letter and the RFC patch itself it
gives a better idea of what a merged version of the driver would look like
and raises some questions about how tightly the new functionality should be
integrated with the fpga manager.

https://marc.info/?l=linux-fpga&m=161841884401312&w=2
https://marc.info/?l=linux-fpga&m=161884993123556&w=2

Thanks,
- Russ
>
> - Moritz

