Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829223A1B23
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFIQlo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 12:41:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:35668 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFIQln (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 12:41:43 -0400
IronPort-SDR: DNWfAtdZpbS4p57tTtiyCcegvgoIYkP9Sv8Wm2QKjchsURJPEd4kNH9CDXP2Tmy7/Gv8tRRtuo
 MJa8u740Optg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202087755"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="202087755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:39:49 -0700
IronPort-SDR: Eg/D1ECSmKovdkqWtLFz6R8s8T/Dq3Gh6rmCTPiUsyXH60vpNqLkmSp0Vrx3DzlnoH7b92OsBS
 I3S6fRpuhGvQ==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="552734788"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.251.20.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:39:48 -0700
Subject: Re: [PATCH v1 2/5] fpga: altera-pr-ip: Remove fpga_mgr_unregister()
 call
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210609004925.238044-1-russell.h.weight@intel.com>
 <20210609004925.238044-3-russell.h.weight@intel.com>
 <20210609153725.GB1994229@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <a764584a-a1f8-88dd-2728-9e4092784717@intel.com>
Date:   Wed, 9 Jun 2021 09:25:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609153725.GB1994229@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/9/21 8:37 AM, Xu Yilun wrote:
> On Tue, Jun 08, 2021 at 05:49:22PM -0700, Russ Weight wrote:
>> The altera-pr-ip driver uses the devm_fpga_mgr_register() call, so it is
>> unnecessary to call fpga_mgr_unregister(). Also, mgr is no longer stored
>> in the dev.driver_data, so remove the call to dev_get_drvdata().
>>
>> alt_pr_unregister() is now an empty function, but is left intact because
>> it is an exported symbol.
> I don't see this function be called anywhere, so could we just remove
> it?
>
> Any impact we remove an exported symbol that is not used?

Only if there are out-of-tree drivers that use it. What do other's think? Can we remove this?

- Russ
>
> Thanks,
> Yilun
>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>>  drivers/fpga/altera-pr-ip-core.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
>> index 5b130c4d9882..c150a084e440 100644
>> --- a/drivers/fpga/altera-pr-ip-core.c
>> +++ b/drivers/fpga/altera-pr-ip-core.c
>> @@ -201,11 +201,7 @@ EXPORT_SYMBOL_GPL(alt_pr_register);
>>  
>>  void alt_pr_unregister(struct device *dev)
>>  {
>> -	struct fpga_manager *mgr = dev_get_drvdata(dev);
>> -
>>  	dev_dbg(dev, "%s\n", __func__);
>> -
>> -	fpga_mgr_unregister(mgr);
>>  }
>>  EXPORT_SYMBOL_GPL(alt_pr_unregister);
>>  
>> -- 
>> 2.25.1

