Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733733D7652
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhG0N1h (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 09:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237215AbhG0NYm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 09:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627392268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mVXn0p4nLajiF/pe1F+YII4d84HTSRTf1AKvRUszes=;
        b=ANphq4+KQsKfbT+GxM1Cegl6YjR4JcRJ/h0IxUo1FQXLOC1EqVYbZ/z2hCpStBb8C9cmDg
        S+Xib6b71aYF39xJtjr958LGCK8/5fc+mbiYnUKkwrR4lHFBMKFnbM0ObXeACHq/zj/Rfs
        y9YPBBnDjx0qE7V+pnKh+bhIPJQ1Cwc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-3C1Di9BLO1Wpy6e5u9tGyQ-1; Tue, 27 Jul 2021 09:24:27 -0400
X-MC-Unique: 3C1Di9BLO1Wpy6e5u9tGyQ-1
Received: by mail-qk1-f199.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so11643443qkd.0
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jul 2021 06:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7mVXn0p4nLajiF/pe1F+YII4d84HTSRTf1AKvRUszes=;
        b=tb59QlLO+GEfPd1ywTjd+LS/MLbJptZ5AtsjqoM+XUZPxGJq+6nLWZLvYzJc1jx75p
         nnX9ukPx12Kdnst0f7KZYAPhenZ/r7Unogr/Jw6bnwNSUyG9manOcrR8rhkbgA+jJHG+
         WfIKqbNgkEBJKdbnen/Sh4C+dluHWgUPf1zUM7JfmxsmmwUHCNg+aMAtoXOHeIBB7ifu
         Tstb41r3+DnmG7SE8cg78Vbi+lwCRoja/GJG10buzcH+9IwQt0UIAitCb01MtUa3Wsl8
         Uvk3y7k9omAR+7L1OGtpOSyLumVFs6Nbwi6bGqh2WftPJ32YfwEE613HNvu5JPEDYl/i
         Ik4w==
X-Gm-Message-State: AOAM530lPBHnHQDG4scDRzFU0J0X3zz4mH3sR09pW9qrGDFMX431bB2m
        b87D8oOfIxQLI6KRQycbvYJvnPKh1hRfv8HvNhAXoPholu+Io0HKohnYTKihI9IFPbwzb8p8NC2
        PQIiksB0Ne+zUDdeQxgLt6w==
X-Received: by 2002:a05:622a:1704:: with SMTP id h4mr12223833qtk.346.1627392266707;
        Tue, 27 Jul 2021 06:24:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm/1oHev51JIzXxOQcEl/XEPpL/OY5xqNEG4MzKYadsZ9vM2dnFddwBhdDcPGetb5q+fxV0Q==
X-Received: by 2002:a05:622a:1704:: with SMTP id h4mr12223814qtk.346.1627392266464;
        Tue, 27 Jul 2021 06:24:26 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a127sm1688566qkc.121.2021.07.27.06.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 06:24:26 -0700 (PDT)
Subject: Re: [RESEND PATCH v10 0/3] fpga: Use standard class dev_release
 function
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, "Wu, Hao" <hao.wu@intel.com>
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210726212750.121293-1-russell.h.weight@intel.com>
 <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com>
Date:   Tue, 27 Jul 2021 06:24:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/26/21 2:33 PM, Russ Weight wrote:
> Hi Moritz,
>
> I sent this version of the patchset out on July 8th. The only discussion has
> been around the compat-id structure. I think there is agreement that this can
> be treated separately. What are your thoughts? Do you think this patchset is
> ready?

While I agree the compat_id can be treated separately, i still have a 
problem with the 2 register functions.

In this discussion,

https://lore.kernel.org/linux-fpga/DM6PR11MB38194D113950FA4B75C7F2C485E49@DM6PR11MB3819.namprd11.prod.outlook.com/

*register_full(..., *info) becomes

*register(..., *info)

and

*register_simple() is moved out of the public api and becomes private to 
the subsystem.

Tom

>
> Thanks,
> - Russ
>
>
> On 7/26/21 2:27 PM, Russ Weight wrote:
>> The FPGA framework has a convention of using managed resource functions
>> to allow parent drivers to manage the data structures allocated by the
>> class drivers. They use an empty *_dev_release() function to satisfy the
>> class driver.
>>
>> This is inconsistent with linux driver model.
>>
>> These changes remove the managed resource functions and populate the class
>> dev_release callback functions. They also merge the create() and register()
>> functions into a single register() or register_full() function for each of
>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>
>> The new *register_full() functions accept an info data structure to provide
>> flexibility in passing optional parameters. The *register() functions
>> support the legacy parameter list for users that don't require the use of
>> optional parameters.
>>
>> For more context, refer to this email thread:
>>
>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>>
>> I turned on the configs assocated with each of the modified files, but I
>> must have been missing some dependencies, because not all of them compiled.
>> I did a run-time test specifically with the dfl-fme infrastructure. This
>> would have exercised the region, bridge, and fpga-mgr frameworks.
>>
>> Changelog v9 -> v10:
>>    - Fixed commit messages to reference register_full() instead of
>>      register_simple().
>>    - Removed the fpga_bridge_register_full() function, because there is
>>      not need for it yet. Updated the documentation and commit message
>>      accordingly.
>>    - Updated documentation to reference the fpga_manager_info and
>>      fpga_region_info structures.
>>
>> Changelog v8 -> v9:
>>    - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>>      register functions
>>    - Renamed fpga_*_register() to fpga_*_register_full()
>>    - Renamed fpga_*_register_simple() to fpga_*_register()
>>    - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>>    - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
>>
>> Changelog v7 -> v8:
>>    - Added reviewed-by tags.
>>    - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>>      fpga-bridge.rst, and fpga-region.rst.
>>
>> Changelog v6 -> v7:
>>    - Update the commit messages to describe the new parameters for the
>>      *register() functions and to mention the *register_simple() functions.
>>    - Fix function prototypes in header file to rename dev to parent.
>>    - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>>    - Some cleanup of comments.
>>    - Update function definitions/prototypes to apply const to the new info
>>      parameter.
>>    - Verify that info->br_ops is non-null in the fpga_bridge_register()
>>      function.
>>    - Verify a non-null info pointer in the fpga_region_register() function.
>>
>> Changelog v5 -> v6:
>>    - Moved FPGA manager/bridge/region optional parameters out of the ops
>>      structure and back into the FPGA class driver structure.
>>    - Changed fpga_*_register() function parameters to accept an info data
>>      structure to provide flexibility in passing optional parameters.
>>    - Added fpga_*_register_simple() functions to support current parameters
>>      for users that don't require use of optional parameters.
>>
>> Changelog v4 -> v5:
>>    - Rebased on top of recently accepted patches.
>>    - Removed compat_id from the fpga_mgr_register() parameter list
>>      and added it to the fpga_manager_ops structure. This also required
>>      dynamically allocating the dfl-fme-ops structure in order to add
>>      the appropriate compat_id.
>>    - Created the fpga_region_ops data structure which is optionally passed
>>      to fpga_region_register(). compat_id, the get_bridges() pointer, and
>>      the priv pointer are included in the fpga_region_ops structure.
>>
>> Changelog v3 -> v4:
>>    - Added the compat_id parameter to fpga_mgr_register() and
>>      devm_fpga_mgr_register() to ensure that the compat_id is set before
>>      the device_register() call.
>>    - Added the compat_id parameter to fpga_region_register() to ensure
>>      that the compat_id is set before the device_register() call.
>>    - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>>      the fpga_region_register() call to the correct location.
>>
>> Changelog v2 -> v3:
>>    - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>>      and fpga_region_register().
>>    - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>>      fpga_bridge_register(), and fpga_region_register().
>>    - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>>      of NULL.
>>
>> Changelog v1 -> v2:
>>    - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>>      class driver, adapted for the combined create/register functionality.
>>    - All previous callers of devm_fpga_mgr_register() will continue to call
>>      devm_fpga_mgr_register().
>>    - replaced unnecessary ternary operators in return statements with
>>      standard if conditions.
>>
>> Russ Weight (3):
>>    fpga: mgr: Use standard dev_release for class driver
>>    fpga: bridge: Use standard dev_release for class driver
>>    fpga: region: Use standard dev_release for class driver
>>
>>   Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>>   Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>>   Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>>   drivers/fpga/altera-cvp.c                     |  12 +-
>>   drivers/fpga/altera-fpga2sdram.c              |  12 +-
>>   drivers/fpga/altera-freeze-bridge.c           |  10 +-
>>   drivers/fpga/altera-hps2fpga.c                |  12 +-
>>   drivers/fpga/altera-pr-ip-core.c              |   7 +-
>>   drivers/fpga/altera-ps-spi.c                  |   9 +-
>>   drivers/fpga/dfl-fme-br.c                     |  10 +-
>>   drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>>   drivers/fpga/dfl-fme-region.c                 |  17 +-
>>   drivers/fpga/dfl.c                            |  12 +-
>>   drivers/fpga/fpga-bridge.c                    | 122 +++-------
>>   drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>>   drivers/fpga/fpga-region.c                    | 119 ++++------
>>   drivers/fpga/ice40-spi.c                      |   9 +-
>>   drivers/fpga/machxo2-spi.c                    |   9 +-
>>   drivers/fpga/of-fpga-region.c                 |  10 +-
>>   drivers/fpga/socfpga-a10.c                    |  16 +-
>>   drivers/fpga/socfpga.c                        |   9 +-
>>   drivers/fpga/stratix10-soc.c                  |  16 +-
>>   drivers/fpga/ts73xx-fpga.c                    |   9 +-
>>   drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>>   drivers/fpga/xilinx-spi.c                     |  11 +-
>>   drivers/fpga/zynq-fpga.c                      |  16 +-
>>   drivers/fpga/zynqmp-fpga.c                    |   9 +-
>>   include/linux/fpga/fpga-bridge.h              |  30 ++-
>>   include/linux/fpga/fpga-mgr.h                 |  62 +++--
>>   include/linux/fpga/fpga-region.h              |  36 ++-
>>   30 files changed, 383 insertions(+), 511 deletions(-)
>>

