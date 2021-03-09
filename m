Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1866C332B64
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Mar 2021 17:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhCIQDU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Mar 2021 11:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbhCIQDP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Mar 2021 11:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615305795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYg1gHZN0k3Hh29ugFnGHp9mEpEu717dG5YVfPU7oC4=;
        b=ivVJ5dHCCkwDdLzw3gfhJVSiAV9HLja408cG43InJubZSteTYCFoWENoCeKhQMRKK1ryo7
        CuEOn0WnRpbR7602lRcFnMWkcxVeSjwdleRCQs/C2Km4C+gkQJ+yZS/9dBRQl8XFgJfZ9F
        M+YEY7YQehNtbSkzGiAZHnHHulkGsKY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-beroUoxzPOG3baj4kshgkQ-1; Tue, 09 Mar 2021 11:03:13 -0500
X-MC-Unique: beroUoxzPOG3baj4kshgkQ-1
Received: by mail-qt1-f199.google.com with SMTP id 16so10786001qtw.1
        for <linux-fpga@vger.kernel.org>; Tue, 09 Mar 2021 08:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KYg1gHZN0k3Hh29ugFnGHp9mEpEu717dG5YVfPU7oC4=;
        b=kjxzDCcPaHXAkn4epcVVpIw+a1+Kk/yOsIfnLOBE20lhaii9R82mg9qqzozcX1IRjd
         DlQQ2oKO8/zsyJRr5jT/QYkqDBI24QNT84zR4hAJ/V/j8HG5OyFeVZPD9lDmUVE/r9Yx
         Ftyjf4AP/2dX8jqfmuGxzx5q45vRcKD+BAiuql0yh2xIuXy26Yx0b800Y80MhenRKIgl
         /VnCPJEpcH51Vv+ZrfDh56nD69wOeoHv5JZSQMy+fgPQtw0TDGwRHcGdbf43U7NJdrvg
         FmztSEQJEhUS6Zz3yurHAYc4g5zYBokn15x0Y3UusPbPvI0twAyELNaPCpBXnE3W0ZS9
         WXCA==
X-Gm-Message-State: AOAM533wDTFv13l+cSYW4UugHvn/Nno0FwkifacFcO3LdU488H7Dd533
        ANxYfvRIns6G6iYfdYHtX2GwWNOdcOw6C8QlQ+w/+u4zna2SryXhqHMInePE01jHimaym2RE3mK
        96HgRUaiG5ZUvu6hIprX5xQ==
X-Received: by 2002:ae9:e015:: with SMTP id m21mr6912508qkk.420.1615305792728;
        Tue, 09 Mar 2021 08:03:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSj6MusZROOJaXHCTGCL7TjFOdxpp84rYPJJYpZ8gwWRvfjE6K7IIpuAPl6CITIybTuO36Yg==
X-Received: by 2002:ae9:e015:: with SMTP id m21mr6912480qkk.420.1615305792387;
        Tue, 09 Mar 2021 08:03:12 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 17sm10259391qky.7.2021.03.09.08.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 08:03:11 -0800 (PST)
Subject: Re: [PATCH v10 0/7] FPGA Security Manager Class Driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210309003540.197600-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6f891032-8f73-5926-c137-279c2dd93041@redhat.com>
Date:   Tue, 9 Mar 2021 08:03:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309003540.197600-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Moritz,

This and the next patchset apply to today's char-misc-next.

However they conflicts with other in flight linux-fpga patchsets.

Since I believe these patchsets came first, I think they should have preference.

This feature of updating is needed for the basic operation of the fpga.

Tom

On 3/8/21 4:35 PM, Russ Weight wrote:
> The FPGA Security Manager class driver provides a common
> API for user-space tools to manage updates for secure FPGA
> devices. Device drivers that instantiate the FPGA Security
> Manager class driver will interact with a HW secure update
> engine in order to transfer new FPGA and BMC images to FLASH so
> that they will be automatically loaded when the FPGA card reboots.
>
> A significant difference between the FPGA Manager and the FPGA 
> Security Manager is that the FPGA Manager does a live update (Partial
> Reconfiguration) to a device whereas the FPGA Security Manager
> updates the FLASH images for the Static Region and the BMC so that
> they will be loaded the next time the FPGA card boots. Security is
> enforced by hardware and firmware. The security manager interacts
> with the firmware to initiate an update, pass in the necessary data,
> and collect status on the update.
>
> The n3000bmc-secure driver is the first driver to use the FPGA
> Security Manager. This driver was previously submitted in the same
> patch set, but has been split out into a separate patch set starting
> with V2. Future devices will also make use of this common API for
> secure updates.
>
> In addition to managing secure updates of the FPGA and BMC images,
> the FPGA Security Manager update process may also be used to
> program root entry hashes and cancellation keys for the FPGA static
> region, the FPGA partial reconfiguration region, and the BMC.
> The image files are self-describing, and contain a header describing
> the image type.
>
> Secure updates make use of the request_firmware framework, which
> requires that image files are accessible under /lib/firmware. A request
> for a secure update returns immediately, while the update itself
> proceeds in the context of a kernel worker thread. Sysfs files provide
> a means for monitoring the progress of a secure update and for
> retrieving error information in the event of a failure.
>
> The API includes a "name" sysfs file to export the name of the parent
> driver. It also includes an "update" sub-directory containing files that
> that can be used to instantiate and monitor a secure update.
>
> Changelog v9 -> v10:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
>
> Changelog v8 -> v9:
>   - Rebased patches for 5.11-rc2
>   - Updated Date and KernelVersion in ABI documentation
>
> Changelog v7 -> v8:
>   - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst
>
> Changelog v6 -> v7:
>   - Changed dates in documentation file to December 2020
>   - Changed filename_store() to use kmemdup_nul() instead of
>     kstrndup() and changed the count to not assume a line-return.
>
> Changelog v5 -> v6:
>   - Removed sysfs support and documentation for the display of the
>     flash count, root entry hashes, and code-signing-key cancelation
>     vectors from the class driver. This information can vary by device
>     and will instead be displayed by the device-specific parent driver.
>
> Changelog v4 -> v5:
>   - Added the devm_fpga_sec_mgr_unregister() function, following recent
>     changes to the fpga_manager() implementation.
>   - Changed most of the *_show() functions to use sysfs_emit()
>     instead of sprintf(
>   - When checking the return values for functions of type enum
>     fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
>
> Changelog v3 -> v4:
>   - This driver is generic enough that it could be used for non Intel
>     FPGA devices. Changed from "Intel FPGA Security Manager" to FPGA
>     Security Manager" and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>     Note that this also affects some filenames.
>
> Changelog v2 -> v3:
>   - Use dev_err() to report invalid progress in sec_progress()
>   - Use dev_err() to report invalid error code in sec_error()
>   - Modified sysfs handler check in check_sysfs_handler() to make
>     it more readable.
>   - Removed unnecessary "goto done"
>   - Added a comment to explain imgr->driver_unload in
>     ifpga_sec_mgr_unregister()
>
> Changelog v1 -> v2:
>   - Separated out the MAX10 BMC Security Engine to be submitted in
>     a separate patch-set.
>   - Bumped documentation dates and versions
>   - Split ifpga_sec_mgr_register() into create() and register() functions
>   - Added devm_ifpga_sec_mgr_create()
>   - Added Documentation/fpga/ifpga-sec-mgr.rst 
>   - Changed progress state "read_file" to "reading"
>   - Added sec_error() function (similar to sec_progress())
>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
>   - Removed typedefs for imgr ops
>   - Removed explicit value assignments in enums
>   - Other minor code cleanup per review comments 
>
> Russ Weight (7):
>   fpga: sec-mgr: fpga security manager class driver
>   fpga: sec-mgr: enable secure updates
>   fpga: sec-mgr: expose sec-mgr update status
>   fpga: sec-mgr: expose sec-mgr update errors
>   fpga: sec-mgr: expose sec-mgr update size
>   fpga: sec-mgr: enable cancel of secure update
>   fpga: sec-mgr: expose hardware error info
>
>  .../ABI/testing/sysfs-class-fpga-sec-mgr      |  81 +++
>  Documentation/fpga/fpga-sec-mgr.rst           |  44 ++
>  Documentation/fpga/index.rst                  |   1 +
>  MAINTAINERS                                   |   9 +
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/fpga-sec-mgr.c                   | 652 ++++++++++++++++++
>  include/linux/fpga/fpga-sec-mgr.h             | 100 +++
>  8 files changed, 899 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>  create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
>  create mode 100644 drivers/fpga/fpga-sec-mgr.c
>  create mode 100644 include/linux/fpga/fpga-sec-mgr.h
>

