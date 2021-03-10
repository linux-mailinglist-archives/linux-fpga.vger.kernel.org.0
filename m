Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553D5333359
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Mar 2021 03:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhCJCvk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Mar 2021 21:51:40 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:56209 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhCJCvP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Mar 2021 21:51:15 -0500
Received: by mail-pj1-f50.google.com with SMTP id bt4so737253pjb.5;
        Tue, 09 Mar 2021 18:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mbwVpoz1DQIkoT/p72Ric3YKtpuiNSl2U1hzqJm79zc=;
        b=rdmFkjvJ7EC3FTNlIaRERfWFQmcsGv9T5pjb+f2WznJ8DnIPOtIDr1cpXwn/6eqxvf
         mHhi02yGsT2kOj6MpTbVDuaJs1sY7xQ8z3rabSgnn6QTv1qNT4o8+QTdzL0iLTpRE16b
         z++8ADV1+X2lz+IbnI8r4x9atYzOYFiSMSz5rjEyvsLpTO1qjJzpp6W02PtE2DwbVAIY
         9W9Twr9p4ryLI5FitbPYSV15o997jtJ1lJ/t6OOG4cI4G1WsWmbgsxgdGhtwzRx4U8q9
         j+Q4fh4ut4VKE9a+E4BwzAj3uNFZb35To7UDnpj54G4FMw1KsjmE9eifRUknpqWTFJpN
         j7ig==
X-Gm-Message-State: AOAM533WVlz9im1qrMfzQbQXc4WwEhW3jWxXesdM72NGirR20YhHBGfc
        ZJVM/UJw0A8BkOzCsso9R5eMbZ5DPbw=
X-Google-Smtp-Source: ABdhPJz2os2vn/MnDLi0l6SYsc5QJ3MkXszvP5w4+0qMIaSJ1t02etCjhmpKi8pkR+Cf9rmahVUaAw==
X-Received: by 2002:a17:90a:598e:: with SMTP id l14mr1067504pji.187.1615344664255;
        Tue, 09 Mar 2021 18:51:04 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s19sm11491096pfh.168.2021.03.09.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:51:03 -0800 (PST)
Date:   Tue, 9 Mar 2021 18:51:02 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
Subject: Re: [PATCH v10 0/7] FPGA Security Manager Class Driver
Message-ID: <YEg0FqjHk2icadah@epycbox.lan>
References: <20210309003540.197600-1-russell.h.weight@intel.com>
 <6f891032-8f73-5926-c137-279c2dd93041@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f891032-8f73-5926-c137-279c2dd93041@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,
On Tue, Mar 09, 2021 at 08:03:09AM -0800, Tom Rix wrote:
> Moritz,
> 
> This and the next patchset apply to today's char-misc-next.
> 
> However they conflicts with other in flight linux-fpga patchsets.
> 
> Since I believe these patchsets came first, I think they should have preference.

I'm not sure what the ask here is, do you expect me to back out the
applied patches?

Conflicts will happen, it's part of working with git.

> This feature of updating is needed for the basic operation of the fpga.
> 
> Tom
> 
> On 3/8/21 4:35 PM, Russ Weight wrote:
> > The FPGA Security Manager class driver provides a common
> > API for user-space tools to manage updates for secure FPGA
> > devices. Device drivers that instantiate the FPGA Security
> > Manager class driver will interact with a HW secure update
> > engine in order to transfer new FPGA and BMC images to FLASH so
> > that they will be automatically loaded when the FPGA card reboots.
> >
> > A significant difference between the FPGA Manager and the FPGA 
> > Security Manager is that the FPGA Manager does a live update (Partial
> > Reconfiguration) to a device whereas the FPGA Security Manager
> > updates the FLASH images for the Static Region and the BMC so that
> > they will be loaded the next time the FPGA card boots. Security is
> > enforced by hardware and firmware. The security manager interacts
> > with the firmware to initiate an update, pass in the necessary data,
> > and collect status on the update.
> >
> > The n3000bmc-secure driver is the first driver to use the FPGA
> > Security Manager. This driver was previously submitted in the same
> > patch set, but has been split out into a separate patch set starting
> > with V2. Future devices will also make use of this common API for
> > secure updates.
> >
> > In addition to managing secure updates of the FPGA and BMC images,
> > the FPGA Security Manager update process may also be used to
> > program root entry hashes and cancellation keys for the FPGA static
> > region, the FPGA partial reconfiguration region, and the BMC.
> > The image files are self-describing, and contain a header describing
> > the image type.
> >
> > Secure updates make use of the request_firmware framework, which
> > requires that image files are accessible under /lib/firmware. A request
> > for a secure update returns immediately, while the update itself
> > proceeds in the context of a kernel worker thread. Sysfs files provide
> > a means for monitoring the progress of a secure update and for
> > retrieving error information in the event of a failure.
> >
> > The API includes a "name" sysfs file to export the name of the parent
> > driver. It also includes an "update" sub-directory containing files that
> > that can be used to instantiate and monitor a secure update.
> >
> > Changelog v9 -> v10:
> >   - Rebased to 5.12-rc2 next
> >   - Updated Date and KernelVersion in ABI documentation
> >
> > Changelog v8 -> v9:
> >   - Rebased patches for 5.11-rc2
> >   - Updated Date and KernelVersion in ABI documentation
> >
> > Changelog v7 -> v8:
> >   - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst
> >
> > Changelog v6 -> v7:
> >   - Changed dates in documentation file to December 2020
> >   - Changed filename_store() to use kmemdup_nul() instead of
> >     kstrndup() and changed the count to not assume a line-return.
> >
> > Changelog v5 -> v6:
> >   - Removed sysfs support and documentation for the display of the
> >     flash count, root entry hashes, and code-signing-key cancelation
> >     vectors from the class driver. This information can vary by device
> >     and will instead be displayed by the device-specific parent driver.
> >
> > Changelog v4 -> v5:
> >   - Added the devm_fpga_sec_mgr_unregister() function, following recent
> >     changes to the fpga_manager() implementation.
> >   - Changed most of the *_show() functions to use sysfs_emit()
> >     instead of sprintf(
> >   - When checking the return values for functions of type enum
> >     fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
> >
> > Changelog v3 -> v4:
> >   - This driver is generic enough that it could be used for non Intel
> >     FPGA devices. Changed from "Intel FPGA Security Manager" to FPGA
> >     Security Manager" and removed unnecessary references to "Intel".
> >   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> >     Note that this also affects some filenames.
> >
> > Changelog v2 -> v3:
> >   - Use dev_err() to report invalid progress in sec_progress()
> >   - Use dev_err() to report invalid error code in sec_error()
> >   - Modified sysfs handler check in check_sysfs_handler() to make
> >     it more readable.
> >   - Removed unnecessary "goto done"
> >   - Added a comment to explain imgr->driver_unload in
> >     ifpga_sec_mgr_unregister()
> >
> > Changelog v1 -> v2:
> >   - Separated out the MAX10 BMC Security Engine to be submitted in
> >     a separate patch-set.
> >   - Bumped documentation dates and versions
> >   - Split ifpga_sec_mgr_register() into create() and register() functions
> >   - Added devm_ifpga_sec_mgr_create()
> >   - Added Documentation/fpga/ifpga-sec-mgr.rst 
> >   - Changed progress state "read_file" to "reading"
> >   - Added sec_error() function (similar to sec_progress())
> >   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
> >   - Removed typedefs for imgr ops
> >   - Removed explicit value assignments in enums
> >   - Other minor code cleanup per review comments 
> >
> > Russ Weight (7):
> >   fpga: sec-mgr: fpga security manager class driver
> >   fpga: sec-mgr: enable secure updates
> >   fpga: sec-mgr: expose sec-mgr update status
> >   fpga: sec-mgr: expose sec-mgr update errors
> >   fpga: sec-mgr: expose sec-mgr update size
> >   fpga: sec-mgr: enable cancel of secure update
> >   fpga: sec-mgr: expose hardware error info
> >
> >  .../ABI/testing/sysfs-class-fpga-sec-mgr      |  81 +++
> >  Documentation/fpga/fpga-sec-mgr.rst           |  44 ++
> >  Documentation/fpga/index.rst                  |   1 +
> >  MAINTAINERS                                   |   9 +
> >  drivers/fpga/Kconfig                          |   9 +
> >  drivers/fpga/Makefile                         |   3 +
> >  drivers/fpga/fpga-sec-mgr.c                   | 652 ++++++++++++++++++
> >  include/linux/fpga/fpga-sec-mgr.h             | 100 +++
> >  8 files changed, 899 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >  create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
> >  create mode 100644 drivers/fpga/fpga-sec-mgr.c
> >  create mode 100644 include/linux/fpga/fpga-sec-mgr.h
> >
> 
