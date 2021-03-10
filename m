Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE13341C8
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Mar 2021 16:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhCJPm5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Mar 2021 10:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232808AbhCJPmt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Mar 2021 10:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615390969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLd7YxuLisgeRUxbPzIFodyEJnYjpZ+Zo18aKecQDow=;
        b=dSBh7EAKnbAYnkQWQc5fRYS96PNi1zpxjkXYd/EuH2iVd+k2q6OgPQpYjHI7y6Aidovnp9
        MpqWfM4f4QOOIc9dqcVygDmMjBgfNpxGUhg8UDS/ghNFqih74oIc+ggM86deoZuhuEcjcJ
        rquhI7CTA2bmiHCNrV8MZ+O1FQ/punQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-ue_AR_bcPcmImnHCAinJwA-1; Wed, 10 Mar 2021 10:42:44 -0500
X-MC-Unique: ue_AR_bcPcmImnHCAinJwA-1
Received: by mail-qt1-f200.google.com with SMTP id t19so13187214qta.2
        for <linux-fpga@vger.kernel.org>; Wed, 10 Mar 2021 07:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dLd7YxuLisgeRUxbPzIFodyEJnYjpZ+Zo18aKecQDow=;
        b=YwKPmhcmydsu8PS0xkCWSJWBoKF/6r237WhmYGJJBBVBShA48o9UZFQYvbHndbiZQ8
         xygW8emn/GqyGeHVhE02WzRbDvWK3IZ5mfWESl1hVEdIwBmYPdDfp0yDIWDP7leg/E8c
         hr+vaK1G+ZWgys82Qe/OUkqqyn6XPkT7dnjSy8TalMi3VWsvYJXdkIReyIj8KAxPYGpZ
         HtE5CVJ7n052NVW6GzBmp2ouWy9HzdgPmQLp7wS1u4rMn+4zC2Q5JExepHZbXqdsQ2+2
         qj84cVzimlXY3oeevRbf23ERBzEG+MjAyvqZY6W2+lBAkuM/7bkoWo5I2ptwJ+07gTgM
         MEuw==
X-Gm-Message-State: AOAM530ayKyt447tbUbUTUqieyAdweC92N1XIR30+hd1yLB8tMOh6wj7
        fl82lSzYHvTY9MyM6CiRjBKiTakMu56/Nt54DjM35Ha0VWUTC60bwDYuQgQnZ/WGyjBcpLQEs7q
        MiC7E9QHZaHn1rP9I55vldw==
X-Received: by 2002:a37:a390:: with SMTP id m138mr3072079qke.59.1615390964302;
        Wed, 10 Mar 2021 07:42:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4TaXS+E7SGYkRYZ9PXoFjhdjzRUsfb41eGx0DO5ucrDM8EYjgu4Gbh3/zAENKEQwBr/ZsKA==
X-Received: by 2002:a37:a390:: with SMTP id m138mr3072053qke.59.1615390964000;
        Wed, 10 Mar 2021 07:42:44 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w78sm12762078qkb.11.2021.03.10.07.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:42:43 -0800 (PST)
Subject: Re: [PATCH v10 0/7] FPGA Security Manager Class Driver
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210309003540.197600-1-russell.h.weight@intel.com>
 <6f891032-8f73-5926-c137-279c2dd93041@redhat.com>
 <YEg0FqjHk2icadah@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <70d84703-3ad1-7bfa-a480-8aaf42ff4a4a@redhat.com>
Date:   Wed, 10 Mar 2021 07:42:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEg0FqjHk2icadah@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/9/21 6:51 PM, Moritz Fischer wrote:
> Hi Tom,
> On Tue, Mar 09, 2021 at 08:03:09AM -0800, Tom Rix wrote:
>> Moritz,
>>
>> This and the next patchset apply to today's char-misc-next.
>>
>> However they conflicts with other in flight linux-fpga patchsets.
>>
>> Since I believe these patchsets came first, I think they should have preference.
> I'm not sure what the ask here is, do you expect me to back out the
> applied patches?
>
> Conflicts will happen, it's part of working with git.

When I say in-flight, I mean yet to be accepted patches.

I track these here

https://github.com/trixirt/linux-fpga/tree/fpga-testing


I am sure everyone wants their patch in 5.13, I am plugging for these because they are oldest and most useful.

This is an old patchset, from the changelog in this patchset it has been rebased for the last 2 releases without change.

AFAIK, the dfl fpga's bitstream can not be updated with the mainline kernel without these patches.

Since updating is why you would use an fpga, this is an important feature.


While I am plugging for 5.13

A fix for dfl port enable logic

https://lore.kernel.org/linux-fpga/20210303014543.68292-1-russell.h.weight@intel.com/

A patchset with a fix for stable

https://lore.kernel.org/linux-fpga/8fe75a64-0457-16ac-5049-ee8b756ae1ea@linux.intel.com/

Tom

>> This feature of updating is needed for the basic operation of the fpga.
>>
>> Tom
>>
>> On 3/8/21 4:35 PM, Russ Weight wrote:
>>> The FPGA Security Manager class driver provides a common
>>> API for user-space tools to manage updates for secure FPGA
>>> devices. Device drivers that instantiate the FPGA Security
>>> Manager class driver will interact with a HW secure update
>>> engine in order to transfer new FPGA and BMC images to FLASH so
>>> that they will be automatically loaded when the FPGA card reboots.
>>>
>>> A significant difference between the FPGA Manager and the FPGA 
>>> Security Manager is that the FPGA Manager does a live update (Partial
>>> Reconfiguration) to a device whereas the FPGA Security Manager
>>> updates the FLASH images for the Static Region and the BMC so that
>>> they will be loaded the next time the FPGA card boots. Security is
>>> enforced by hardware and firmware. The security manager interacts
>>> with the firmware to initiate an update, pass in the necessary data,
>>> and collect status on the update.
>>>
>>> The n3000bmc-secure driver is the first driver to use the FPGA
>>> Security Manager. This driver was previously submitted in the same
>>> patch set, but has been split out into a separate patch set starting
>>> with V2. Future devices will also make use of this common API for
>>> secure updates.
>>>
>>> In addition to managing secure updates of the FPGA and BMC images,
>>> the FPGA Security Manager update process may also be used to
>>> program root entry hashes and cancellation keys for the FPGA static
>>> region, the FPGA partial reconfiguration region, and the BMC.
>>> The image files are self-describing, and contain a header describing
>>> the image type.
>>>
>>> Secure updates make use of the request_firmware framework, which
>>> requires that image files are accessible under /lib/firmware. A request
>>> for a secure update returns immediately, while the update itself
>>> proceeds in the context of a kernel worker thread. Sysfs files provide
>>> a means for monitoring the progress of a secure update and for
>>> retrieving error information in the event of a failure.
>>>
>>> The API includes a "name" sysfs file to export the name of the parent
>>> driver. It also includes an "update" sub-directory containing files that
>>> that can be used to instantiate and monitor a secure update.
>>>
>>> Changelog v9 -> v10:
>>>   - Rebased to 5.12-rc2 next
>>>   - Updated Date and KernelVersion in ABI documentation
>>>
>>> Changelog v8 -> v9:
>>>   - Rebased patches for 5.11-rc2
>>>   - Updated Date and KernelVersion in ABI documentation
>>>
>>> Changelog v7 -> v8:
>>>   - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst
>>>
>>> Changelog v6 -> v7:
>>>   - Changed dates in documentation file to December 2020
>>>   - Changed filename_store() to use kmemdup_nul() instead of
>>>     kstrndup() and changed the count to not assume a line-return.
>>>
>>> Changelog v5 -> v6:
>>>   - Removed sysfs support and documentation for the display of the
>>>     flash count, root entry hashes, and code-signing-key cancelation
>>>     vectors from the class driver. This information can vary by device
>>>     and will instead be displayed by the device-specific parent driver.
>>>
>>> Changelog v4 -> v5:
>>>   - Added the devm_fpga_sec_mgr_unregister() function, following recent
>>>     changes to the fpga_manager() implementation.
>>>   - Changed most of the *_show() functions to use sysfs_emit()
>>>     instead of sprintf(
>>>   - When checking the return values for functions of type enum
>>>     fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
>>>
>>> Changelog v3 -> v4:
>>>   - This driver is generic enough that it could be used for non Intel
>>>     FPGA devices. Changed from "Intel FPGA Security Manager" to FPGA
>>>     Security Manager" and removed unnecessary references to "Intel".
>>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>     Note that this also affects some filenames.
>>>
>>> Changelog v2 -> v3:
>>>   - Use dev_err() to report invalid progress in sec_progress()
>>>   - Use dev_err() to report invalid error code in sec_error()
>>>   - Modified sysfs handler check in check_sysfs_handler() to make
>>>     it more readable.
>>>   - Removed unnecessary "goto done"
>>>   - Added a comment to explain imgr->driver_unload in
>>>     ifpga_sec_mgr_unregister()
>>>
>>> Changelog v1 -> v2:
>>>   - Separated out the MAX10 BMC Security Engine to be submitted in
>>>     a separate patch-set.
>>>   - Bumped documentation dates and versions
>>>   - Split ifpga_sec_mgr_register() into create() and register() functions
>>>   - Added devm_ifpga_sec_mgr_create()
>>>   - Added Documentation/fpga/ifpga-sec-mgr.rst 
>>>   - Changed progress state "read_file" to "reading"
>>>   - Added sec_error() function (similar to sec_progress())
>>>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
>>>   - Removed typedefs for imgr ops
>>>   - Removed explicit value assignments in enums
>>>   - Other minor code cleanup per review comments 
>>>
>>> Russ Weight (7):
>>>   fpga: sec-mgr: fpga security manager class driver
>>>   fpga: sec-mgr: enable secure updates
>>>   fpga: sec-mgr: expose sec-mgr update status
>>>   fpga: sec-mgr: expose sec-mgr update errors
>>>   fpga: sec-mgr: expose sec-mgr update size
>>>   fpga: sec-mgr: enable cancel of secure update
>>>   fpga: sec-mgr: expose hardware error info
>>>
>>>  .../ABI/testing/sysfs-class-fpga-sec-mgr      |  81 +++
>>>  Documentation/fpga/fpga-sec-mgr.rst           |  44 ++
>>>  Documentation/fpga/index.rst                  |   1 +
>>>  MAINTAINERS                                   |   9 +
>>>  drivers/fpga/Kconfig                          |   9 +
>>>  drivers/fpga/Makefile                         |   3 +
>>>  drivers/fpga/fpga-sec-mgr.c                   | 652 ++++++++++++++++++
>>>  include/linux/fpga/fpga-sec-mgr.h             | 100 +++
>>>  8 files changed, 899 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>>>  create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
>>>  create mode 100644 drivers/fpga/fpga-sec-mgr.c
>>>  create mode 100644 include/linux/fpga/fpga-sec-mgr.h
>>>

