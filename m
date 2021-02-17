Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427BE31D4A3
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Feb 2021 05:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhBQEgb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Feb 2021 23:36:31 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34980 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhBQEfY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 Feb 2021 23:35:24 -0500
Received: by mail-pl1-f173.google.com with SMTP id g20so6782417plo.2;
        Tue, 16 Feb 2021 20:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPAIMKuKvKEaHiQvXAcNDbDQ0OtzKGU/PgY56JPRvao=;
        b=eRhLulKJHoRvO0HQNePpV6veSQcUWw7OPmM3Gmg9jjBrO54wev/1bSCHWIYGwOjj4E
         M6m37OtjPBTN7tCcibK5VDe3WPv0M4wUPTiGImnh5aDAYDHH7fm1GXA1zwjkOwNbu84y
         PUDlO5xgU7N2pdb6zXwL2S28rQY/xesScH0yYT4MyQqUJoODM6uytG0u9yZlCDerpkkw
         jOb7M7jEjbv4dheMzHSA9O5pOu/HwsAmdWN97RQ8fjcecYLJgif2eyrbGLrw0JRJKXjU
         9d+Cbvb02E8xh67rDVixNLE6ot5nHg2/wRIHmnuyrfAXsV3vVltg7Ii12jiF5EhRh59O
         v9/A==
X-Gm-Message-State: AOAM530ycQZKuWmIo8/vfoJWHzse/KHf+tXadlnA291q0cFQWesghCdh
        PTfV3ISy1yVIvswm9OZPbZ1BF9m69ncjVQ==
X-Google-Smtp-Source: ABdhPJzIEwO60oDsi+w5F+xbgSrhdv3fo6P2LXM2ZmEgJLGfdzFj/PdvikKPiHbjkiLaBcwbmXtcAg==
X-Received: by 2002:a17:90a:c083:: with SMTP id o3mr7392132pjs.30.1613536445705;
        Tue, 16 Feb 2021 20:34:05 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y13sm526283pfc.28.2021.02.16.20.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 20:34:05 -0800 (PST)
Date:   Tue, 16 Feb 2021 20:34:03 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
Subject: Re: [PATCH v9 0/7] FPGA Security Manager Class Driver
Message-ID: <YCycu/QvjGxO0s1n@epycbox.lan>
References: <20210105225924.14573-1-russell.h.weight@intel.com>
 <a9705da0-1ed0-8d9a-8eea-f04d7b9b471c@redhat.com>
 <0a3274a4-607d-cce6-2000-b8ea89f03c48@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3274a4-607d-cce6-2000-b8ea89f03c48@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Tue, Feb 16, 2021 at 09:46:53AM -0800, Russ Weight wrote:
> I believe all of the dependencies have been accepted now.
> 
> - Russ

Sorry for dropping the ball on this, I'll get to this ASAP after -rc1 is
tagged.

> 
> On 2/15/21 6:56 AM, Tom Rix wrote:
> > Russ, Moritz
> >
> > This patchset still applies.
> >
> > Updating the fpga is a fairly important feature.
> >
> > Are there any dependencies we are waiting on ?
> >
> > Tom
> >
> > On 1/5/21 2:59 PM, Russ Weight wrote:
> >> The FPGA Security Manager class driver provides a common
> >> API for user-space tools to manage updates for secure FPGA
> >> devices. Device drivers that instantiate the FPGA Security
> >> Manager class driver will interact with a HW secure update
> >> engine in order to transfer new FPGA and BMC images to FLASH so
> >> that they will be automatically loaded when the FPGA card reboots.
> >>
> >> A significant difference between the FPGA Manager and the FPGA 
> >> Security Manager is that the FPGA Manager does a live update (Partial
> >> Reconfiguration) to a device whereas the FPGA Security Manager
> >> updates the FLASH images for the Static Region and the BMC so that
> >> they will be loaded the next time the FPGA card boots. Security is
> >> enforced by hardware and firmware. The security manager interacts
> >> with the firmware to initiate an update, pass in the necessary data,
> >> and collect status on the update.
> >>
> >> The n3000bmc-secure driver is the first driver to use the FPGA
> >> Security Manager. This driver was previously submitted in the same
> >> patch set, but has been split out into a separate patch set starting
> >> with V2. Future devices will also make use of this common API for
> >> secure updates.
> >>
> >> In addition to managing secure updates of the FPGA and BMC images,
> >> the FPGA Security Manager update process may also be used to
> >> program root entry hashes and cancellation keys for the FPGA static
> >> region, the FPGA partial reconfiguration region, and the BMC.
> >> The image files are self-describing, and contain a header describing
> >> the image type.
> >>
> >> Secure updates make use of the request_firmware framework, which
> >> requires that image files are accessible under /lib/firmware. A request
> >> for a secure update returns immediately, while the update itself
> >> proceeds in the context of a kernel worker thread. Sysfs files provide
> >> a means for monitoring the progress of a secure update and for
> >> retrieving error information in the event of a failure.
> >>
> >> The API includes a "name" sysfs file to export the name of the parent
> >> driver. It also includes an "update" sub-directory containing files that
> >> that can be used to instantiate and monitor a secure update.
> >>
> >> Changelog v8 -> v9:
> >>   - Rebased patches for 5.11-rc2
> >>   - Updated Date and KernelVersion in ABI documentation
> >>
> >> Changelog v7 -> v8:
> >>   - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst
> >>
> >> Changelog v6 -> v7:
> >>   - Changed dates in documentation file to December 2020
> >>   - Changed filename_store() to use kmemdup_nul() instead of
> >>     kstrndup() and changed the count to not assume a line-return.
> >>
> >> Changelog v5 -> v6:
> >>   - Removed sysfs support and documentation for the display of the
> >>     flash count, root entry hashes, and code-signing-key cancelation
> >>     vectors from the class driver. This information can vary by device
> >>     and will instead be displayed by the device-specific parent driver.
> >>
> >> Changelog v4 -> v5:
> >>   - Added the devm_fpga_sec_mgr_unregister() function, following recent
> >>     changes to the fpga_manager() implementation.
> >>   - Changed most of the *_show() functions to use sysfs_emit()
> >>     instead of sprintf(
> >>   - When checking the return values for functions of type enum
> >>     fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
> >>
> >> Changelog v3 -> v4:
> >>   - This driver is generic enough that it could be used for non Intel
> >>     FPGA devices. Changed from "Intel FPGA Security Manager" to FPGA
> >>     Security Manager" and removed unnecessary references to "Intel".
> >>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> >>     Note that this also affects some filenames.
> >>
> >> Changelog v2 -> v3:
> >>   - Use dev_err() to report invalid progress in sec_progress()
> >>   - Use dev_err() to report invalid error code in sec_error()
> >>   - Modified sysfs handler check in check_sysfs_handler() to make
> >>     it more readable.
> >>   - Removed unnecessary "goto done"
> >>   - Added a comment to explain imgr->driver_unload in
> >>     ifpga_sec_mgr_unregister()
> >>
> >> Changelog v1 -> v2:
> >>   - Separated out the MAX10 BMC Security Engine to be submitted in
> >>     a separate patch-set.
> >>   - Bumped documentation dates and versions
> >>   - Split ifpga_sec_mgr_register() into create() and register() functions
> >>   - Added devm_ifpga_sec_mgr_create()
> >>   - Added Documentation/fpga/ifpga-sec-mgr.rst 
> >>   - Changed progress state "read_file" to "reading"
> >>   - Added sec_error() function (similar to sec_progress())
> >>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
> >>   - Removed typedefs for imgr ops
> >>   - Removed explicit value assignments in enums
> >>   - Other minor code cleanup per review comments 
> >>
> >> Russ Weight (7):
> >>   fpga: sec-mgr: fpga security manager class driver
> >>   fpga: sec-mgr: enable secure updates
> >>   fpga: sec-mgr: expose sec-mgr update status
> >>   fpga: sec-mgr: expose sec-mgr update errors
> >>   fpga: sec-mgr: expose sec-mgr update size
> >>   fpga: sec-mgr: enable cancel of secure update
> >>   fpga: sec-mgr: expose hardware error info
> >>
> >>  .../ABI/testing/sysfs-class-fpga-sec-mgr      |  81 +++
> >>  Documentation/fpga/fpga-sec-mgr.rst           |  44 ++
> >>  Documentation/fpga/index.rst                  |   1 +
> >>  MAINTAINERS                                   |   9 +
> >>  drivers/fpga/Kconfig                          |   9 +
> >>  drivers/fpga/Makefile                         |   3 +
> >>  drivers/fpga/fpga-sec-mgr.c                   | 652 ++++++++++++++++++
> >>  include/linux/fpga/fpga-sec-mgr.h             | 100 +++
> >>  8 files changed, 899 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >>  create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
> >>  create mode 100644 drivers/fpga/fpga-sec-mgr.c
> >>  create mode 100644 include/linux/fpga/fpga-sec-mgr.h
> >>
> 

- Moritz
