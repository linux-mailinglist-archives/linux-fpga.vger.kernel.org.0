Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7887F31BBAF
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Feb 2021 15:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBOO6F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 15 Feb 2021 09:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhBOO5x (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613400979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrRM1QxfnrMrYFQsps5k5W6ePiGa4SMjmwwhDFeB+aw=;
        b=d4aeNR5ibW4LJitWEeqgydYRWo+7pz8/NQbCweW2nfr4S80k2wDTvcuD/ZbHKwgjeamlUH
        /eWyQrxd2lSyT8hcDZ45kFmveUE4yww7JB43v5b4oDdu3OHUJEeASd9Vn9tNX4dL8j2rLD
        qLQZ8CgUjCfkHQ/rC3/X4hbau305zsI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-cKC23pliMqC0hDPICCPccg-1; Mon, 15 Feb 2021 09:56:18 -0500
X-MC-Unique: cKC23pliMqC0hDPICCPccg-1
Received: by mail-qt1-f198.google.com with SMTP id k90so5412222qte.4
        for <linux-fpga@vger.kernel.org>; Mon, 15 Feb 2021 06:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JrRM1QxfnrMrYFQsps5k5W6ePiGa4SMjmwwhDFeB+aw=;
        b=jy2eA81fDDaGa9bmTXUMt4CTAL5RA6qQVklv41A5ES1frBxtaCv0LgAARtouaqksnN
         Ho0rv2O8gz9E9qdU9QSxvYc3fXnPkhW61nEGgi3NZPbzdP40+spQzu6tk9t+zOMQtWaQ
         wPNlaR5L/3BAyCjdb4zt/Bh8DPajbC/qgG6uREmJz9a2Ye1azU0OlS/w4ZmOdDbjzmuf
         tNUjW/amcacQTOeJVR0KqBH4VolF6FnJBwst1qHWfnZmoizKWkgYcWrib2ISrGfU/XEs
         L5pj4iwOwljVDf0/HEuRDu2kdP5+wLcKdweAVtzRTV52BQCtar5diK8B0Hrll1vtzOcr
         p2UQ==
X-Gm-Message-State: AOAM531AsrlPRRTpfGYQr7iHsFyG0gnYaC3wsJ9dpmTI3HBBxze8cvol
        4epwaDddiSnBANoxAaInYa4eh5pMmrlgWw7t0nzazZnkIzDw9d1khLtF2+9VQyw8t1ppsNYicy8
        idKqvS2eO3I3HonMDdwqbJg==
X-Received: by 2002:a37:4c09:: with SMTP id z9mr8851898qka.9.1613400976737;
        Mon, 15 Feb 2021 06:56:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAbZIRzXhEKW5+XNMv3+ptZvSCtEfKDkun5PSz6GwXN+Gen4qxjlQDPRfDrdOZ0yYIUswT7g==
X-Received: by 2002:a37:4c09:: with SMTP id z9mr8851879qka.9.1613400976502;
        Mon, 15 Feb 2021 06:56:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d22sm11361098qtp.34.2021.02.15.06.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 06:56:16 -0800 (PST)
Subject: Re: [PATCH v9 0/7] FPGA Security Manager Class Driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210105225924.14573-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a9705da0-1ed0-8d9a-8eea-f04d7b9b471c@redhat.com>
Date:   Mon, 15 Feb 2021 06:56:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210105225924.14573-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Russ, Moritz

This patchset still applies.

Updating the fpga is a fairly important feature.

Are there any dependencies we are waiting on ?

Tom

On 1/5/21 2:59 PM, Russ Weight wrote:
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

