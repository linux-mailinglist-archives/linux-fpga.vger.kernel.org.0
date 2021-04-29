Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE836E3F4
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Apr 2021 06:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhD2ELf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Apr 2021 00:11:35 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:36487 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhD2ELd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Apr 2021 00:11:33 -0400
Received: by mail-pf1-f169.google.com with SMTP id c3so26452093pfo.3
        for <linux-fpga@vger.kernel.org>; Wed, 28 Apr 2021 21:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4FurIoL8xPmMvWIacoA3k6ppfPiWhEhMgrSFdLPlI4o=;
        b=ZLHo64lQ3rxPPkreynMcsNXOx65UeTZQxTYuj/t0gYTh7HUgjUZZrrr3lxDJd5zG9U
         vF/sgvAoPIibmfmNRPsWmy1jUZvrn1AkUhLftl9eO9pRqEOSm1MaPlKLApA5a7JQQB9b
         b4q0ZHwNK++IbXj1MWQw/TA/gCvt2gTrkC1LEKmhuYdJmR8ErRODaQDhKCYSsYOBETOF
         H6J80PjxmcnGXZTcIHRfNu5AiWZ6sH7m68pOXnxf9vuFmwdG6IG1yL9WZvYhXRvp9mqG
         gxjKtxl9/xK1xKXP+J9Cj752Prwy2skGQVzZjImTnmUbYJ5h0kEjEqiENaVpjxjbhmdq
         oDOw==
X-Gm-Message-State: AOAM533AeoaEE60vPsy98J4tTC5of48AEXRGYqVs2XxnTwgsOm29sILo
        6BieOrAWEIBkc6limg5yqDA=
X-Google-Smtp-Source: ABdhPJxuAxsSl63z567AGSpryU9F4Srg9H43tB8lvsu6bJ62GeCvDwPegW9HL8/g82FmQlcK+74tGA==
X-Received: by 2002:a63:2686:: with SMTP id m128mr1257658pgm.406.1619669430095;
        Wed, 28 Apr 2021 21:10:30 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id v8sm1009704pff.220.2021.04.28.21.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 21:10:29 -0700 (PDT)
Date:   Wed, 28 Apr 2021 21:10:29 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: RFC: Integrating secure update functions into the FPGA Manager
Message-ID: <YIoxtaudnbYySm1P@archbook>
References: <60ff2054-8ee1-7bc8-7981-9249e3ee42c7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60ff2054-8ee1-7bc8-7981-9249e3ee42c7@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Wed, Apr 07, 2021 at 04:56:29PM -0700, Russ Weight wrote:
> Hi Moritz,
> 
> Please see below my analysis of the effort to integrate secure functions
> into the FPGA Manager. I have recommendations interspersed below. The
> bottom line is that it seems like there is very little opportunity to
> share code. I could try to rewrite the fpga_mgr_load() related functions
> to accommodate worker threads, cancellation, and progress updates, but I'm
> not sure there is enough value-add to justify the the additional complexity,
> especially for the scatter-gather versions. The other options is to just
> port the secure-manager functions into the FPGA Manager.
> 
> - Russ
> 
> =======================================================================
> 
> This is a comparison of the FPGA Security Manager patch-set with the
> current FPGA Manager. Recommendations are provided on how to the extend
> the FPGA Manager to support the Security Manager functions.
> 
> Purpose of the FPGA Security Manager Class Driver
> =================================================
> 
> The security manager provides a common user API (via sysfs) for transferring
> an opaque image to the card BMC for validation and disposition with a
> completion time of up to 40 minutes. A separate trigger function (image_load)
> can be used to activate a previously transferred image (e.g. FPGA Static
> Region or BMC image).
> 
> Note that secure updates have no notion of Regions, Bridges or FPGA
> running state.

Not needed.
> 
> A successful merge of the Security Manager with the FPGA Manager would include
> an extension of the FPGA Manager API to provide sysfs nodes to support secure
> updates.

Yes.
> 
> The FPGA Security Manager API
> =============================
> 
> Image Update (transfer data to Card BMC for validation & storage)
>   WO: filename, cancel
>   RO: name, status, error, hw_errinfo, remaining_size
> 
> Image Load (trigger BMC, FPGA, or FW load from FLASH)
>   RO: available_images  # Images that can be loaded/activated
>   WO: image_load:       # Trigger an image load
> 
> 
> Merging Security Manager and FPGA Manager functions (organized by sysfs-node)
> =============================================================================
> 
> The "name" sysfs node has essentially the same purpose, so no change is
> required.
> 
> The sec-mgr "status" is similar to fpga-mgr "state"
> The sec-mgr "error" is simliar to fpga-mgr "status"
> 
> All others are unique to the security manager.
> 
> * RECOMMENDATION: The secure-update sysfs files should be grouped together
> * in "secure-update" sysfs directory to clearly associate them with the
> * secure update process and separate them from the other driver functions.

SGTM.
> 
> The sec-mgr sysfs status file has some similarity to the fpga-mgr sysfs
> state file:
> 
>     Sec-Mgr status             FPGA-Mgr state
>     --------------             --------------
>                             FPGA_MGR_STATE_UNKNOWN
>                             FPGA_MGR_STATE_POWER_OFF
>                             FPGA_MGR_STATE_POWER_UP
>                             FPGA_MGR_STATE_RESET
> FPGA_SEC_PROG_IDLE
> FPGA_SEC_PROG_READING       FPGA_MGR_STATE_FIRMWARE_REQ
>                             FPGA_MGR_STATE_FIRMWARE_REQ_ERR
> FPGA_SEC_PROG_PREPARING     FPGA_MGR_STATE_WRITE_INIT
>                             FPGA_MGR_STATE_WRITE_INIT_ERR
> FPGA_SEC_PROG_WRITING       FPGA_MGR_STATE_WRITE
>                             FPGA_MGR_STATE_WRITE_ERR
> FPGA_SEC_PROG_PROGRAMMING   FPGA_MGR_STATE_WRITE_COMPLETE
>                             FPGA_MGR_STATE_WRITE_COMPLETE_ERR
>                             FPGA_MGR_STATE_OPERATING
> FPGA_SEC_PROG_IDLE
> 
> The sec-mgr sysfs error file seems to be similar in purpose to the
> fpga-mgr sysfs status file, but there is no overlap in the actual
> error codes.
> 
> * RECOMMENDATION: there is not enough similarity between the status/state and
> * error/status nodes to try to share them. If all of the other secure-update
> * related nodes are grouped together in a secure-update directory, it would
> * probably create confusion to try to share the state and status files that
> * are in a different location.

Yes.
> 
> sysfs: filename
> ===============
> 
> In the current security manager patches, writing the name of an image file
> to "filename" is roughly equivalent to creating a worker thread and having it
> call fpga_mgr_load() with info->firmware_name set to the image file name.
> 
> The update sequences are similar:
> 
>     Sec-Mgr ops flow        FPGA-Mgr ops flow
>     ================        =================
>     prepare()               write_init()
>     # Loop on 16KB blocks   write()
>       write_blk()
>     poll_complete()         write_complete()
> 
> In the worst case, we have seen n3000 FPGA image updates take up to 40
> minutes. The remaining_size is updated between each 16KB block to
> allow users to monitor the progress of the data transfer. The sec-mgr
> also checks for a cancel flag between each 16KB write and between
> each stage of the update.
> 
> The fpga_mgr has a "buffer" flow and a "scatter-gather" flow. The sec-mgr
> flow is always started via sysfs and uses request_firmware(), so it only
> needs one (buffer) flow.
> 
> * RECOMMENDATION: keep the update functions separate. Although they are
> * similar, the fpga-mgr updates are simpler and more readable as they
> * are. The sec-mgr update is done via kernel worker thread and is a little
> * more complicated with support for maintaining the remaining size and
> * with support for cancellation. There currently no need for a scatter-gather
> * secure update implementation since secure updates use request_firmware.
> 
> Note that the sec-mgr supports additional ops:
>     cancel()         : send cancel-request to lower-level driver
>     cleanup()        : optional: called if and only if the prepare op succeeds
>     get_hw_errinfo() : optional: provides device-specific 64-bit error info
> 
> sysfs: cancel, status, error, hw_errinfo, remaining_size
> ========================================================
> 
> * RECOMMENDATION: There are no equivalent features in fpga-mgr. Port
> * these each from the security manager to the FPGA Manager.

SGTM.
> 
> sysfs: available_images, load_image
> ===================================
> 
>   available_images: RO: list device-specific keywords that can be used
>                     to trigger an image to be loaded/activated. eg.
>                     fpga_factory, fpga_user1, fpga_user2, bmc_factory.
> 
>   load_image:       WO: trigger the load/activation of an image from FLASH
> 
> * RECOMMENDATION: Nothing similar in fpga-mgr. Port functionality to the
> * FPGA Manager
> 
> Conclusion
> ==========
> 
> The purpose of the secure-update support is to provide a common user API
> for loading an opaque image to a device with completion times of up to 40
> minutes. The FPGA Manager can be extended to include the sysfs nodes
> required for a secure update. There is very little opportunity for shared
> code between the current FPGA Manager and the secure update support.  For
> the most part, this would be an addition of new functionality.

Sounds good to me overall, sorry for the late response.

- Moritz
