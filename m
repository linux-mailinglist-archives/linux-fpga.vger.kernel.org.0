Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404E62BA246
	for <lists+linux-fpga@lfdr.de>; Fri, 20 Nov 2020 07:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgKTG0a (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 20 Nov 2020 01:26:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36945 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgKTG02 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 20 Nov 2020 01:26:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id m9so6459141pgb.4;
        Thu, 19 Nov 2020 22:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3VBe9I6ZLvjv0+rw9dc7utKP5dO8QvFfLdr1B42slpA=;
        b=q0q77clooqHJDT7OXh1YAXYXmHvXPc5M6RbqoJfg7BKBI7FYxG/5utS+BX3PhuWwlW
         JgefFzPjaYfZCAvp2UxlRHURWgpeYE1UFzPwc77CBwDnZMa8xNYNvYxitEIW0o+04yyH
         +WeBhMa7vfKxV2rDscVTjgekCOLPTzrgF3tVni0aU2LQAIuodo81mZkVB2AvfMKxbrwG
         lJCMiAPUyhZlhWXdp83oubyBXHahK34Vu8Lmao336efrJ1K5zDiMv4OEYSgcHsx1uYDR
         H2uM9LNIbOZl3sEt1Zn8+4+G6AgPf7/OTi+rsqKbdfw8lMkkMKUSp9PhpSOn3ZaB+WSO
         rcXA==
X-Gm-Message-State: AOAM533gT2+vj2RDWG5s8LAxQQuNWkZkmcGdXiJK02OAmONOONwKobrU
        hKH6LDOg30H9G8PsXFZ+QO+V6uVSeiO1iA==
X-Google-Smtp-Source: ABdhPJwb7zSSXu/pUeAEtfulz9pGF2LNLNmLnDtuUGi4uNMYrIpTLlmqlw2jcgfFTT5FEDwv+QGMyA==
X-Received: by 2002:a17:90a:2e04:: with SMTP id q4mr8729613pjd.37.1605853587398;
        Thu, 19 Nov 2020 22:26:27 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x61sm2200747pjj.4.2020.11.19.22.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 22:26:26 -0800 (PST)
Date:   Thu, 19 Nov 2020 22:26:25 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v6 1/7] fpga: sec-mgr: fpga security manager class driver
Message-ID: <X7dhkWZmsfTXfpWd@epycbox.lan>
References: <20201106010905.11935-1-russell.h.weight@intel.com>
 <20201106010905.11935-2-russell.h.weight@intel.com>
 <X7GzpM95S5pdjNi/@epycbox.lan>
 <4368b462-3ead-d9f5-7d87-be4da390ee49@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4368b462-3ead-d9f5-7d87-be4da390ee49@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Thu, Nov 19, 2020 at 06:39:44PM -0800, Russ Weight wrote:
> 
> 
> On 11/15/20 3:03 PM, Moritz Fischer wrote:
> > Hi Russ,
> >
> > On Thu, Nov 05, 2020 at 05:08:59PM -0800, Russ Weight wrote:
> >> Create the FPGA Security Manager class driver. The security
> >> manager provides interfaces to manage secure updates for the
> >> FPGA and BMC images that are stored in FLASH. The driver can
> >> also be used to update root entry hashes and to cancel code
> >> signing keys. The image type is encoded in the image file
> >> and is decoded by the HW/FW secure update engine.
> >>
> >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> >> Reviewed-by: Tom Rix <trix@redhat.com>
> >> ---
> >> v6:
> >>   - Removed sysfs support and documentation for the display of the
> >>     flash count, root entry hashes, and code-signing-key cancelation
> >>     vectors.
> >> v5:
> >>   - Added the devm_fpga_sec_mgr_unregister() function, following recent
> >>     changes to the fpga_manager() implementation.
> >>   - Changed some *_show() functions to use sysfs_emit() instead of sprintf(
> >> v4:
> >>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
> >>     and removed unnecessary references to "Intel".
> >>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> >> v3:
> >>   - Modified sysfs handler check in check_sysfs_handler() to make
> >>     it more readable.
> >> v2:
> >>   - Bumped documentation dates and versions
> >>   - Added Documentation/fpga/ifpga-sec-mgr.rst 
> >>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
> >>   - Split ifpga_sec_mgr_register() into create() and register() functions
> >>   - Added devm_ifpga_sec_mgr_create()
> >>   - Removed typedefs for imgr ops
> >> ---
> >>  .../ABI/testing/sysfs-class-fpga-sec-mgr      |   5 +
> >>  Documentation/fpga/fpga-sec-mgr.rst           |  44 +++
> >>  Documentation/fpga/index.rst                  |   1 +
> >>  MAINTAINERS                                   |   9 +
> >>  drivers/fpga/Kconfig                          |   9 +
> >>  drivers/fpga/Makefile                         |   3 +
> >>  drivers/fpga/fpga-sec-mgr.c                   | 296 ++++++++++++++++++
> >>  include/linux/fpga/fpga-sec-mgr.h             |  44 +++
> >>  8 files changed, 411 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >>  create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
> >>  create mode 100644 drivers/fpga/fpga-sec-mgr.c
> >>  create mode 100644 include/linux/fpga/fpga-sec-mgr.h
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >> new file mode 100644
> >> index 000000000000..ecda22a3ff3b
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >> @@ -0,0 +1,5 @@
> >> +What: 		/sys/class/fpga_sec_mgr/fpga_secX/name
> >> +Date:		Oct 2020
> >> +KernelVersion:  5.11
> >> +Contact:	Russ Weight <russell.h.weight@intel.com>
> >> +Description:	Name of low level fpga security manager driver.
> >> diff --git a/Documentation/fpga/fpga-sec-mgr.rst b/Documentation/fpga/fpga-sec-mgr.rst
> >> new file mode 100644
> >> index 000000000000..26dac599ead7
> >> --- /dev/null
> >> +++ b/Documentation/fpga/fpga-sec-mgr.rst
> >> @@ -0,0 +1,44 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +========================================
> >> +FPGA Security Manager Class Driver
> >> +========================================
> >> +
> >> +The FPGA Security Manager class driver provides a common
> >> +API for user-space tools to manage updates for secure FPGA
> >> +devices. Device drivers that instantiate the Security
> >> +Manager class driver will interact with a HW secure update
> >> +engine in order to transfer new FPGA and BMC images to FLASH so
> >> +that they will be automatically loaded when the FPGA card reboots.
> >> +
> >> +A significant difference between the FPGA Manager and the FPGA
> >> +Security Manager is that the FPGA Manager does a live update (Partial
> >> +Reconfiguration) to a device, whereas the FPGA Security Manager
> >> +updates the FLASH images for the Static Region and the BMC so that
> >> +they will be loaded the next time the FPGA card boots. Security is
> >> +enforced by hardware and firmware. The security manager interacts
> >> +with the firmware to initiate an update, pass in the necessary data,
> >> +and collect status on the update.
> > I've always wondered if we could've made this a functionality of an FPGA
> > manager 'non-volatile' node or something.
> >
> > I guess there might be cases where you can only do either of them, i.e.
> > only update flash or only update at runtime.
> 
> Today, in light of Richard Gong's recent patch set, I took another look at
> the fpga manager, trying to determine what changes would need to be made in
> the fpga manager order to support secure updates. These are my observations:
> 
> (1) For the devices that I am working on, the lower-level drivers are
>     completely different for PR vs image updates to flash. As a result,
>     if we used the fpga-mgr, we would need to create different instances
>     of the fpga-mgr, one for PR and one for secure updates - each supported
>     by a different low-level driver.

I was mostly thinking about adding a somewhat similar API to the FPGA
manager (close to what you're doing), but as I said it was a suggestion.
> 
> (2) For secure updates, our worst case time is 40 minutes. I doubt that it
>     will ever be longer than that, but we need to support that case. For this
>     length of time, we feel that it is important to show some indication
>     of progress to the user during the update. To handle this, we
>     are using a write_blk() function to break up the writes so that the
>     class driver can provide updates during the data transfer (e.g. this
>     much is left to transfer). We have also "backgrounded" the kernel
>     process by spawning a kernel worker thread to do the update. The user,
>     or user-space code, can monitor the progress by polling for status
>     through sysfs.
> 
> (3) Also, because of the long updates, it seems necessary to provide a way
>     to cancel the update. For example, if the user accidentally specifies the
>     wrong image file, 40 minutes is too long to wait before they are able
>     to try again. We have provided a way to signal the worker thread to
>     abort when possible.
> 
> (4) Another observation is that we are using the same secure update mechanism
>     to program new root-entry-hashes and to cancel code-signing keys. The
>     image type is encoded in the file header. The payload is opaque to host
>     software, so this isn't an issue - just an observation.
>    
> So is it worth adding these additional features to the fpga-mgr? Or is it
> better to keep them separate? To me they seem different enough, that I think
> it would be cleaner to keep them separate.

Yeah, I think that's fine. Thanks for taking another look, though.

Cheers,
Moritz
