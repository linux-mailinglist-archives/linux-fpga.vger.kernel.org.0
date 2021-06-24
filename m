Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026DC3B33B0
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhFXQRA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 12:17:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:8714 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232012AbhFXQQz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jun 2021 12:16:55 -0400
IronPort-SDR: KfPlgT6pGZOH8dAHer+aFaqafBCmNAv/rUbcxP/fu0Kyow61lfN9FTMmP2CG9/is5pliXiQxzj
 BoOpLGcRFQWw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="268638047"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="268638047"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 09:14:30 -0700
IronPort-SDR: Lvj7D2catDIlgkTrAzXuJ0tWCjsbuZ+l0BghRyisX58BDOCVjK730gxbzQrEYZBNAc2M42WOpa
 DZzylLBynOhQ==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="406694441"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.11.192])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 09:14:29 -0700
Subject: Re: [PATCH v7 0/3] fpga: Use standard class dev_release function
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210623011151.481244-1-russell.h.weight@intel.com>
 <20210624012312.GD4910@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <39daf6c7-de33-1c3a-adfb-3fa645bee112@intel.com>
Date:   Thu, 24 Jun 2021 09:13:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210624012312.GD4910@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Good catch. I'll update the documentation, add the reviewed-by tags, and resubmit.

- Russ

On 6/23/21 6:23 PM, Xu Yilun wrote:
> Sorry, I missed another one. The Documentations in
> Documentation/driver-api/fpga should be updated.
>
> Thanks,
> Yilun
>
> On Tue, Jun 22, 2021 at 06:11:48PM -0700, Russ Weight wrote:
>> The FPGA framework has a convention of using managed resource functions
>> to allow parent drivers to manage the data structures allocated by the
>> class drivers. They use an empty *_dev_release() function to satisfy the
>> class driver.
>>
>> This is inconsistent with linux driver model.
>>
>> These changes remove the managed resource functions and populate the class
>> dev_release callback functions. They also merge the create() and register()
>> functions into a single register() or register_simple() function for each of
>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>
>> The new *register() functions accept an info data structure to provide
>> flexibility in passing optional parameters. The *register_simple()
>> functions support the legacy parameter list for users that don't require
>> the use of optional parameters.
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
>> Changelog v6 -> v7:
>>   - Update the commit messages to describe the new parameters for the
>>     *register() functions and to mention the *register_simple() functions.
>>   - Fix function prototypes in header file to rename dev to parent.
>>   - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>>   - Some cleanup of comments.
>>   - Update function defintions/prototypes to apply const to the new info
>>     parameter.
>>   - Verify that info->br_ops is non-null in the fpga_bridge_register()
>>     function.
>>   - Verify a non-null info pointer in the fpga_region_register() function.
>>
>> Changelog v5 -> v6:
>>   - Moved FPGA manager/bridge/region optional parameters out of the ops
>>     structure and back into the FPGA class driver structure.
>>   - Changed fpga_*_register() function parameters to accept an info data
>>     structure to provide flexibility in passing optional parameters.
>>   - Added fpga_*_register_simple() functions to support current parameters
>>     for users that don't require use of optional parameters.
>>
>> Changelog v4 -> v5:
>>   - Rebased on top of recently accepted patches.
>>   - Removed compat_id from the fpga_mgr_register() parameter list
>>     and added it to the fpga_manager_ops structure. This also required
>>     dynamically allocating the dfl-fme-ops structure in order to add
>>     the appropriate compat_id.
>>   - Created the fpga_region_ops data structure which is optionally passed
>>     to fpga_region_register(). compat_id, the get_bridges() pointer, and
>>     the priv pointer are included in the fpga_region_ops structure.
>>
>> Changelog v3 -> v4:
>>   - Added the compat_id parameter to fpga_mgr_register() and
>>     devm_fpga_mgr_register() to ensure that the compat_id is set before
>>     the device_register() call.
>>   - Added the compat_id parameter to fpga_region_register() to ensure
>>     that the compat_id is set before the device_register() call.
>>   - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>>     the fpga_region_register() call to the correct location.
>>
>> Changelog v2 -> v3:
>>   - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>>     and fpga_region_register().
>>   - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>>     fpga_bridge_register(), and fpga_region_register().
>>   - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>>     of NULL.
>>
>> Changelog v1 -> v2:
>>   - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>>     class driver, adapted for the combined create/register functionality.
>>   - All previous callers of devm_fpga_mgr_register() will continue to call
>>     devm_fpga_mgr_register().
>>   - replaced unnecessary ternary operators in return statements with
>>     standard if conditions.
>>
>> Russ Weight (3):
>>   fpga: mgr: Use standard dev_release for class driver
>>   fpga: bridge: Use standard dev_release for class driver
>>   fpga: region: Use standard dev_release for class driver
>>
>>  drivers/fpga/altera-cvp.c           |  12 +-
>>  drivers/fpga/altera-fpga2sdram.c    |  12 +-
>>  drivers/fpga/altera-freeze-bridge.c |  10 +-
>>  drivers/fpga/altera-hps2fpga.c      |  12 +-
>>  drivers/fpga/altera-pr-ip-core.c    |   8 +-
>>  drivers/fpga/altera-ps-spi.c        |   9 +-
>>  drivers/fpga/dfl-fme-br.c           |  10 +-
>>  drivers/fpga/dfl-fme-mgr.c          |  22 ++-
>>  drivers/fpga/dfl-fme-region.c       |  17 ++-
>>  drivers/fpga/dfl.c                  |  12 +-
>>  drivers/fpga/fpga-bridge.c          | 138 +++++++-----------
>>  drivers/fpga/fpga-mgr.c             | 214 ++++++++++++----------------
>>  drivers/fpga/fpga-region.c          | 121 ++++++----------
>>  drivers/fpga/ice40-spi.c            |   9 +-
>>  drivers/fpga/machxo2-spi.c          |  10 +-
>>  drivers/fpga/of-fpga-region.c       |  11 +-
>>  drivers/fpga/socfpga-a10.c          |  16 +--
>>  drivers/fpga/socfpga.c              |   9 +-
>>  drivers/fpga/stratix10-soc.c        |  16 +--
>>  drivers/fpga/ts73xx-fpga.c          |   9 +-
>>  drivers/fpga/xilinx-pr-decoupler.c  |  17 +--
>>  drivers/fpga/xilinx-spi.c           |  11 +-
>>  drivers/fpga/zynq-fpga.c            |  16 +--
>>  drivers/fpga/zynqmp-fpga.c          |   9 +-
>>  include/linux/fpga/fpga-bridge.h    |  33 +++--
>>  include/linux/fpga/fpga-mgr.h       |  62 +++++---
>>  include/linux/fpga/fpga-region.h    |  36 +++--
>>  27 files changed, 371 insertions(+), 490 deletions(-)
>>
>> -- 
>> 2.25.1

