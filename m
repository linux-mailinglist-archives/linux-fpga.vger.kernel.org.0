Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5839AE61
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 00:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFCWuw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Jun 2021 18:50:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:46600 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFCWuw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Jun 2021 18:50:52 -0400
IronPort-SDR: 8ovwd6lfeqAkIjzvJfFxhkd3HgE2SFQyWnotYmB/aS1ZpCRw7UrJbzzlYc/tl0mWu0Eogma0K5
 +fqoaumQQ63g==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="183856392"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="183856392"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 15:49:06 -0700
IronPort-SDR: XhUoAEFd0mdeRe8TyLLEK8PNXWY0Wqmb7/znHCFZMKAeH6JQ0H2+Eo8WMF2NaPLexF5XpJhf1t
 CnZ+9lAFMFtQ==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="400754339"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.7.200])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 15:49:05 -0700
Subject: Re: [PATCH v4 0/3] fpga: Use standard class dev_release function
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210528215755.839712-1-russell.h.weight@intel.com>
 <20210531152457.GB1929215@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <f33ba58a-ab35-85a6-e628-4a4b6e1a6208@intel.com>
Date:   Thu, 3 Jun 2021 15:49:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210531152457.GB1929215@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/31/21 8:24 AM, Xu Yilun wrote:
> On Fri, May 28, 2021 at 02:57:52PM -0700, Russ Weight wrote:
>> The FPGA framework has a convention of using managed resource
>> functions to allow parent drivers to manage the data structures
>> allocated by the class drivers. They use an empty *_dev_release()
>> function to satisfy the class driver.
>>
>> This is inconsistent with linux driver model.
>>
>> These changes remove the managed resource functions and populate
>> the class dev_release callback functions. They also merge the
>> create and register functions into a single register function for
>> each of the fpga-mgr, fpga-region, and fpga-bridge class drivers.
>>
>> For more context, refer to this email thread:
>>
>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>>
>> I turned on the configs assocated with each of the modified files,
>> but I must have been missing some dependencies, because not all
>> of them compiled. I did a run-time test specifically with the
>> dfl-fme infrastructure. This would have exercised the region,
>> bridge, and fpga-mgr frameworks.
>>
>> Changelog v3 -> v4:
>>   - Added the compat_id parameter to fpga_mgr_register() and
>>     devm_fpga_mgr_register() to ensure that the compat_id is set before
>>     the device_register() call.
>>   - Added the compat_id parameter to fpga_bridge_register() to ensure
> A typo                             ... fpga_region_register() ...
Thanks Yilun - I'll fix that.

- Russ
>
> Thanks,
> Yilun
>
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
>>  drivers/fpga/altera-pr-ip-core.c    |   9 +-
>>  drivers/fpga/altera-ps-spi.c        |  10 +-
>>  drivers/fpga/dfl-fme-br.c           |  10 +-
>>  drivers/fpga/dfl-fme-mgr.c          |  12 +-
>>  drivers/fpga/dfl-fme-region.c       |  12 +-
>>  drivers/fpga/dfl.c                  |  12 +-
>>  drivers/fpga/fpga-bridge.c          | 119 +++++---------------
>>  drivers/fpga/fpga-mgr.c             | 168 ++++++++--------------------
>>  drivers/fpga/fpga-region.c          | 106 ++++--------------
>>  drivers/fpga/ice40-spi.c            |  10 +-
>>  drivers/fpga/machxo2-spi.c          |  10 +-
>>  drivers/fpga/of-fpga-region.c       |  10 +-
>>  drivers/fpga/socfpga-a10.c          |  16 +--
>>  drivers/fpga/socfpga.c              |  10 +-
>>  drivers/fpga/stratix10-soc.c        |  15 +--
>>  drivers/fpga/ts73xx-fpga.c          |  10 +-
>>  drivers/fpga/xilinx-pr-decoupler.c  |  17 +--
>>  drivers/fpga/xilinx-spi.c           |  12 +-
>>  drivers/fpga/zynq-fpga.c            |  16 +--
>>  drivers/fpga/zynqmp-fpga.c          |  10 +-
>>  include/linux/fpga/fpga-bridge.h    |  12 +-
>>  include/linux/fpga/fpga-mgr.h       |  19 ++--
>>  include/linux/fpga/fpga-region.h    |  13 +--
>>  27 files changed, 210 insertions(+), 474 deletions(-)
>>
>> -- 
>> 2.25.1

