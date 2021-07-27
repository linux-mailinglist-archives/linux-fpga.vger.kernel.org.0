Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FDD3D7C7B
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 19:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhG0Row (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 13:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229727AbhG0Row (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 13:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627407891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5CVBUUII+0nUEAKYwViDGWFBGxm4MHJvcU9FI0Cfiw=;
        b=XQc/gPaI7JEPJX1pw0/pHWv94UsYd6txFYsio+wi/7TFwTqaGMM1OnIegqn0PK7fPqkuX7
        G0+bsVqyGcB7qcAxjBH+xVUWFTyJFSiVSSQ0H/yPG8o/R8ltsCxoU8q+UpfFv+s/xPppP6
        X2mEfU/FgoDA94Lh8e886ajA0LHS0J0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-Lg7gIyoGNLGLITvnZmr7ZA-1; Tue, 27 Jul 2021 13:44:50 -0400
X-MC-Unique: Lg7gIyoGNLGLITvnZmr7ZA-1
Received: by mail-qk1-f198.google.com with SMTP id x12-20020a05620a14acb02903b8f9d28c19so12035786qkj.23
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jul 2021 10:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V5CVBUUII+0nUEAKYwViDGWFBGxm4MHJvcU9FI0Cfiw=;
        b=F8f7qc+PLmMSG/mw99+lSxhedYrQq1lTziakBnLmDAOZWbZ/2VaOP3Y/U/KihMwWt1
         bS054Sz7srh+D0XgzLvGTLET6QCGAfE3wSznzINTfy5tBsIXXxydBls8oRKzAOWtEtIi
         +dKK7foa3s4c2g4OnfKMIqUqWdcMbUtfrhDbRbmoi8psSp/dH3QMP86NYWvlryOrvh0F
         5xmQm+0HvlLEgX/4MScjrVKzn2gqqs0ucHDkuNyw9jpH2t6rbLyF+seyrTRAhc4EAhri
         wltBg1bMzE0lZJ3zzdzqjsNAdyJD8ax6rpDjCBU9Kmq48uDiGTf9cklVRkhBZl1ms+ye
         Peow==
X-Gm-Message-State: AOAM532MCtRhnBH7pnaDspMTvRPb8bwQ4Z/P9uyyNVJqQxKvg4tbJEg9
        kSdJPn9c3Pw95o6WOlbRbWCkr5YaYFXrmL63KMJA9z14Nb0oEqweSg0THyFU+hzOWQprghStijG
        DtfMZ94hKnL6OHCH3+cJThQ==
X-Received: by 2002:a37:6516:: with SMTP id z22mr23752952qkb.203.1627407890314;
        Tue, 27 Jul 2021 10:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWIoBvxWL8yWn9O3P+XTDWF/HYZU4SQp5aB0J8rrBGsVZIFawGnAqqUk1toxXhCkA79VK4JA==
X-Received: by 2002:a37:6516:: with SMTP id z22mr23752931qkb.203.1627407890113;
        Tue, 27 Jul 2021 10:44:50 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 67sm2026926qkm.134.2021.07.27.10.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 10:44:49 -0700 (PDT)
Subject: Re: [RESEND PATCH v10 0/3] fpga: Use standard class dev_release
 function
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, "Wu, Hao" <hao.wu@intel.com>
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210726212750.121293-1-russell.h.weight@intel.com>
 <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
 <661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com>
 <f8c391e2-987a-916a-a0e9-7795f71ec76d@intel.com>
 <8584c933-4482-446a-761c-9a5d511a81c5@redhat.com>
 <add87155-6417-fd08-c3c5-b39e7b9662df@intel.com>
 <c3c17e6e-9a57-eb90-fe00-c442c59ad921@redhat.com>
 <b5519458-af01-43ee-2873-2092d552b060@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <61debd50-c75f-2adb-5465-b9525704e0df@redhat.com>
Date:   Tue, 27 Jul 2021 10:44:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b5519458-af01-43ee-2873-2092d552b060@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/27/21 10:16 AM, Russ Weight wrote:
>
> On 7/27/21 9:55 AM, Tom Rix wrote:
>> On 7/27/21 9:38 AM, Russ Weight wrote:
>>> On 7/27/21 9:22 AM, Tom Rix wrote:
>>>> On 7/27/21 9:15 AM, Russ Weight wrote:
>>>>> On 7/27/21 6:24 AM, Tom Rix wrote:
>>>>>> On 7/26/21 2:33 PM, Russ Weight wrote:
>>>>>>> Hi Moritz,
>>>>>>>
>>>>>>> I sent this version of the patchset out on July 8th. The only discussion has
>>>>>>> been around the compat-id structure. I think there is agreement that this can
>>>>>>> be treated separately. What are your thoughts? Do you think this patchset is
>>>>>>> ready?
>>>>>> While I agree the compat_id can be treated separately, i still have a problem with the 2 register functions.
>>>>>>
>>>>>> In this discussion,
>>>>>>
>>>>>> https://lore.kernel.org/linux-fpga/DM6PR11MB38194D113950FA4B75C7F2C485E49@DM6PR11MB3819.namprd11.prod.outlook.com/
>>>>>>
>>>>>> *register_full(..., *info) becomes
>>>>>>
>>>>>> *register(..., *info)
>>>>>>
>>>>>> and
>>>>>>
>>>>>> *register_simple() is moved out of the public api and becomes private to the subsystem.
>>>>> Somehow I missed that part of the email. I'm not sure I understand the part about
>>>>> register_simple() "becomes private to the subsystem". Most users would call the simple
>>>>> version of the API. Is the proposal to replicate the register_simple() interface
>>>>> for each driver that calls it?
>>>> Still use *register_simple() internally, so most of your patchset is unchanged.
>>>>
>>>> Move it out the public api. include/linux/fpga-mgr.h into someplace appropriate in drivers/fpga/
>>> Ok - I'll do another spin of the patch set.
>>>
>>> Just to be clear, *register_full() gets renamed back to *register(). The current *register()
>>> goes back to *register_simple(). *register_simple() is an exported symbol, but the function
>>> prototype moves out of the public header file into private header file under drivers/fpga.
>> Mostly.
>>
>> If register_simple does not need to be exported, it shouldn't be.
> If *register_simple() is to reside in the fpga_mgr or fpga_region module and be
> called by other modules, then it has to be exported... unless it is defined as a
> static function in a header file. Shall I go that route instead? I could create
> a new drivers/fpga/fpga.h file and add the *register_simple() functions there.
> Or I could create separate drivers/fpga/fpga-mgr.h and drivers/fpga/fpga-region.h
> header files with one static function each.

good point, exporting ok

Tom

>
> - Russ
>
>> Tom
>>
>>> - Russ
>>>
>>>> Tom
>>>>
>>>>>> Tom
>>>>>>
>>>>>>> Thanks,
>>>>>>> - Russ
>>>>>>>
>>>>>>>
>>>>>>> On 7/26/21 2:27 PM, Russ Weight wrote:
>>>>>>>> The FPGA framework has a convention of using managed resource functions
>>>>>>>> to allow parent drivers to manage the data structures allocated by the
>>>>>>>> class drivers. They use an empty *_dev_release() function to satisfy the
>>>>>>>> class driver.
>>>>>>>>
>>>>>>>> This is inconsistent with linux driver model.
>>>>>>>>
>>>>>>>> These changes remove the managed resource functions and populate the class
>>>>>>>> dev_release callback functions. They also merge the create() and register()
>>>>>>>> functions into a single register() or register_full() function for each of
>>>>>>>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>>>>>>>
>>>>>>>> The new *register_full() functions accept an info data structure to provide
>>>>>>>> flexibility in passing optional parameters. The *register() functions
>>>>>>>> support the legacy parameter list for users that don't require the use of
>>>>>>>> optional parameters.
>>>>>>>>
>>>>>>>> For more context, refer to this email thread:
>>>>>>>>
>>>>>>>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>>>>>>>>
>>>>>>>> I turned on the configs assocated with each of the modified files, but I
>>>>>>>> must have been missing some dependencies, because not all of them compiled.
>>>>>>>> I did a run-time test specifically with the dfl-fme infrastructure. This
>>>>>>>> would have exercised the region, bridge, and fpga-mgr frameworks.
>>>>>>>>
>>>>>>>> Changelog v9 -> v10:
>>>>>>>>       - Fixed commit messages to reference register_full() instead of
>>>>>>>>         register_simple().
>>>>>>>>       - Removed the fpga_bridge_register_full() function, because there is
>>>>>>>>         not need for it yet. Updated the documentation and commit message
>>>>>>>>         accordingly.
>>>>>>>>       - Updated documentation to reference the fpga_manager_info and
>>>>>>>>         fpga_region_info structures.
>>>>>>>>
>>>>>>>> Changelog v8 -> v9:
>>>>>>>>       - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>>>>>>>>         register functions
>>>>>>>>       - Renamed fpga_*_register() to fpga_*_register_full()
>>>>>>>>       - Renamed fpga_*_register_simple() to fpga_*_register()
>>>>>>>>       - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>>>>>>>>       - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
>>>>>>>>
>>>>>>>> Changelog v7 -> v8:
>>>>>>>>       - Added reviewed-by tags.
>>>>>>>>       - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>>>>>>>>         fpga-bridge.rst, and fpga-region.rst.
>>>>>>>>
>>>>>>>> Changelog v6 -> v7:
>>>>>>>>       - Update the commit messages to describe the new parameters for the
>>>>>>>>         *register() functions and to mention the *register_simple() functions.
>>>>>>>>       - Fix function prototypes in header file to rename dev to parent.
>>>>>>>>       - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>>>>>>>>       - Some cleanup of comments.
>>>>>>>>       - Update function definitions/prototypes to apply const to the new info
>>>>>>>>         parameter.
>>>>>>>>       - Verify that info->br_ops is non-null in the fpga_bridge_register()
>>>>>>>>         function.
>>>>>>>>       - Verify a non-null info pointer in the fpga_region_register() function.
>>>>>>>>
>>>>>>>> Changelog v5 -> v6:
>>>>>>>>       - Moved FPGA manager/bridge/region optional parameters out of the ops
>>>>>>>>         structure and back into the FPGA class driver structure.
>>>>>>>>       - Changed fpga_*_register() function parameters to accept an info data
>>>>>>>>         structure to provide flexibility in passing optional parameters.
>>>>>>>>       - Added fpga_*_register_simple() functions to support current parameters
>>>>>>>>         for users that don't require use of optional parameters.
>>>>>>>>
>>>>>>>> Changelog v4 -> v5:
>>>>>>>>       - Rebased on top of recently accepted patches.
>>>>>>>>       - Removed compat_id from the fpga_mgr_register() parameter list
>>>>>>>>         and added it to the fpga_manager_ops structure. This also required
>>>>>>>>         dynamically allocating the dfl-fme-ops structure in order to add
>>>>>>>>         the appropriate compat_id.
>>>>>>>>       - Created the fpga_region_ops data structure which is optionally passed
>>>>>>>>         to fpga_region_register(). compat_id, the get_bridges() pointer, and
>>>>>>>>         the priv pointer are included in the fpga_region_ops structure.
>>>>>>>>
>>>>>>>> Changelog v3 -> v4:
>>>>>>>>       - Added the compat_id parameter to fpga_mgr_register() and
>>>>>>>>         devm_fpga_mgr_register() to ensure that the compat_id is set before
>>>>>>>>         the device_register() call.
>>>>>>>>       - Added the compat_id parameter to fpga_region_register() to ensure
>>>>>>>>         that the compat_id is set before the device_register() call.
>>>>>>>>       - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>>>>>>>>         the fpga_region_register() call to the correct location.
>>>>>>>>
>>>>>>>> Changelog v2 -> v3:
>>>>>>>>       - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>>>>>>>>         and fpga_region_register().
>>>>>>>>       - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>>>>>>>>         fpga_bridge_register(), and fpga_region_register().
>>>>>>>>       - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>>>>>>>>         of NULL.
>>>>>>>>
>>>>>>>> Changelog v1 -> v2:
>>>>>>>>       - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>>>>>>>>         class driver, adapted for the combined create/register functionality.
>>>>>>>>       - All previous callers of devm_fpga_mgr_register() will continue to call
>>>>>>>>         devm_fpga_mgr_register().
>>>>>>>>       - replaced unnecessary ternary operators in return statements with
>>>>>>>>         standard if conditions.
>>>>>>>>
>>>>>>>> Russ Weight (3):
>>>>>>>>       fpga: mgr: Use standard dev_release for class driver
>>>>>>>>       fpga: bridge: Use standard dev_release for class driver
>>>>>>>>       fpga: region: Use standard dev_release for class driver
>>>>>>>>
>>>>>>>>      Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>>>>>>>>      Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>>>>>>>>      Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>>>>>>>>      drivers/fpga/altera-cvp.c                     |  12 +-
>>>>>>>>      drivers/fpga/altera-fpga2sdram.c              |  12 +-
>>>>>>>>      drivers/fpga/altera-freeze-bridge.c           |  10 +-
>>>>>>>>      drivers/fpga/altera-hps2fpga.c                |  12 +-
>>>>>>>>      drivers/fpga/altera-pr-ip-core.c              |   7 +-
>>>>>>>>      drivers/fpga/altera-ps-spi.c                  |   9 +-
>>>>>>>>      drivers/fpga/dfl-fme-br.c                     |  10 +-
>>>>>>>>      drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>>>>>>>>      drivers/fpga/dfl-fme-region.c                 |  17 +-
>>>>>>>>      drivers/fpga/dfl.c                            |  12 +-
>>>>>>>>      drivers/fpga/fpga-bridge.c                    | 122 +++-------
>>>>>>>>      drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>>>>>>>>      drivers/fpga/fpga-region.c                    | 119 ++++------
>>>>>>>>      drivers/fpga/ice40-spi.c                      |   9 +-
>>>>>>>>      drivers/fpga/machxo2-spi.c                    |   9 +-
>>>>>>>>      drivers/fpga/of-fpga-region.c                 |  10 +-
>>>>>>>>      drivers/fpga/socfpga-a10.c                    |  16 +-
>>>>>>>>      drivers/fpga/socfpga.c                        |   9 +-
>>>>>>>>      drivers/fpga/stratix10-soc.c                  |  16 +-
>>>>>>>>      drivers/fpga/ts73xx-fpga.c                    |   9 +-
>>>>>>>>      drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>>>>>>>>      drivers/fpga/xilinx-spi.c                     |  11 +-
>>>>>>>>      drivers/fpga/zynq-fpga.c                      |  16 +-
>>>>>>>>      drivers/fpga/zynqmp-fpga.c                    |   9 +-
>>>>>>>>      include/linux/fpga/fpga-bridge.h              |  30 ++-
>>>>>>>>      include/linux/fpga/fpga-mgr.h                 |  62 +++--
>>>>>>>>      include/linux/fpga/fpga-region.h              |  36 ++-
>>>>>>>>      30 files changed, 383 insertions(+), 511 deletions(-)
>>>>>>>>

