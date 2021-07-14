Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E823C8920
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhGNQ7n (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Jul 2021 12:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhGNQ7n (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Jul 2021 12:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626281811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zbWJCL0TgyBMRA3bScV9yyO93M1zwRW3xmL+y0OXMTs=;
        b=Lv8mk5j7xsLkcXAzRy0RWD8Wh96LOHdAEQZuftg/pHpyIL9QCUTWgMwH4dF+wtyZwI/JK3
        acwMHGMDfvG92Bsoa3AA6x9zifaxKKryvbDu85ZBvBg63BORMdVKAq5lm0DCSMFLWBhdaY
        t8ed8uV3i6bATkyYQPyr1iXNv44uvQY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-6s2qjQ7ZPmChu7uEsTd6ag-1; Wed, 14 Jul 2021 12:56:49 -0400
X-MC-Unique: 6s2qjQ7ZPmChu7uEsTd6ag-1
Received: by mail-qv1-f71.google.com with SMTP id z1-20020a0cfec10000b02902dbb4e0a8f2so2095945qvs.6
        for <linux-fpga@vger.kernel.org>; Wed, 14 Jul 2021 09:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zbWJCL0TgyBMRA3bScV9yyO93M1zwRW3xmL+y0OXMTs=;
        b=C8T1m0fdowcC/XNeB9gYMo4fGLpzX/w+dbhXO/gTxSbywGl/15PseS0BixhzyOsy3m
         IibB4ssSUzpAMOLgxVGv9vYqVue3kaA0QCsZSZB26cLnpY82hSSYU068LNKMd8dJCuJi
         Ftgox+Q496p7+rudkMEdrWNa7NujZPRrWxn0LRx949c5raDIsb8hH3soH7joUWkCjgor
         hvhuiGaWI+TMVz5G2kW0Gvc0cExyBxmmVTl5PZ/o/K2wGdvwz3ip8a8H2fOei8FFBbf+
         pB0cozqsZ2NQ7kuRvB6msgQGQsZbx8Sx6GlatsmahOHLnyYEwnebn3peWRs4xBLtQ9oP
         xxtw==
X-Gm-Message-State: AOAM533ctla9mSZk2MInBsfMjiu+SJFDcsxe+4aEEDG/dslufkK/efOb
        QWbBYNh4ihYbOfvT52Zpzbc3hsSaMn7rlwWNsqgA4zf19bRHewyh9JV111WMItOHFQxu5wF2w4R
        7a5Rqj+2MCzvejBdMUJ+cCg==
X-Received: by 2002:a05:620a:19a6:: with SMTP id bm38mr10983321qkb.241.1626281809347;
        Wed, 14 Jul 2021 09:56:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiMepwG7bUrAY/U+UoDuF4KVHt4QpUHC200vZbz6g0hnqRm0zg3yGehAG1m/S2uYlBs3d6TA==
X-Received: by 2002:a05:620a:19a6:: with SMTP id bm38mr10983302qkb.241.1626281809104;
        Wed, 14 Jul 2021 09:56:49 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z188sm1315728qkd.68.2021.07.14.09.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 09:56:48 -0700 (PDT)
Subject: Re: [PATCH v10 0/3] fpga: Use standard class dev_release function
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210709004206.244607-1-russell.h.weight@intel.com>
 <347fc4ab-8749-045f-5e07-80ca76aa6925@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b9999736-3921-4574-032b-36126a2b4913@redhat.com>
Date:   Wed, 14 Jul 2021 09:56:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <347fc4ab-8749-045f-5e07-80ca76aa6925@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/14/21 8:50 AM, Russ Weight wrote:
> It seems like these patches are stalled on the compat_id question (in other emails). My
> two-cents: I don't see an issue with having two versions of the register functions, and
> I don't consider the issue important enough to force a move of the compat_id field. I
> think the compat_id issue should be considered separately.
>
> Are there any other concers for these patches?

I am fine with it other than the two register functions.

To compat_id or not and which order, I believe is Moritz's call.

I'm ok with doing compat_id later.

Tom

>
> - Russ
>
> On 7/8/21 5:42 PM, Russ Weight wrote:
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

