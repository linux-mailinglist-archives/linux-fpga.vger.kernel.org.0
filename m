Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70E286C3C
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Oct 2020 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgJHAt7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Oct 2020 20:49:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:21171 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgJHAt7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Oct 2020 20:49:59 -0400
IronPort-SDR: wgfVcC2ryUD7/IkKSTsM1YgQ8gknRTqKx5Hl5OE5qUsGgFnR/NyPIZCFVds1viMBTh3Sd5Hjex
 vVeJZDPONZng==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152126872"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="152126872"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:49:58 -0700
IronPort-SDR: 0q2KiPmRhO0lC5TrrHYq2J66yICSdxdAgTLhWiqbaqBMCnnaSvSpuoqdFeBoliCjM/IcmarfON
 t5+3/siYkslg==
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="461592760"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.251.1.22])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:49:57 -0700
Subject: Re: [PATCH v2 1/6] mfd: intel-m10-bmc: support for MAX10 BMC Security
 Engine
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-2-russell.h.weight@intel.com>
 <20201007070059.GB1763265@dell>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <c50c30b7-0693-3ff1-8d79-5d311d3831bd@intel.com>
Date:   Wed, 7 Oct 2020 17:49:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007070059.GB1763265@dell>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/7/20 12:00 AM, Lee Jones wrote:
> On Fri, 02 Oct 2020, Russ Weight wrote:
>
>> Add macros and definitions required by the MAX10 BMC
>> Security Engine driver.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v2:
>>   - These functions and macros were previously distributed among
>>     the patches that needed them. They are now grouped together
>>     in a single patch containing changes to the Intel MAX10 BMC
>>     driver.
>>   - Added DRBL_ prefix to some definitions
>>   - Some address definitions were moved here from the .c files that
>>     use them.
>> ---
>>  include/linux/mfd/intel-m10-bmc.h | 134 ++++++++++++++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>
>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>> index c8ef2f1654a4..880f907302eb 100644
>> --- a/include/linux/mfd/intel-m10-bmc.h
>> +++ b/include/linux/mfd/intel-m10-bmc.h
>> @@ -13,6 +13,9 @@
>>   * m10bmc_raw_read - read m10bmc register per addr
>> + * m10bmc_raw_bulk_read - bulk read max10 registers per addr
>> + * m10bmc_raw_bulk_write - bulk write max10 registers per addr
>> + * m10bmc_raw_update_bits - update max10 register per addr
>>   * m10bmc_sys_read - read m10bmc system register per offset
>> + * m10bmc_sys_update_bits - update max10 system register per offset
>>   */
> FWIW, I *hate* abstraction for the sake of abstraction.
>
> Please just use the Regmap API in-place instead.
>
I was following the discussion on the Max10 BMC driver to determine which way to go:

https://marc.info/?l=linux-kernel&m=159964043207829&w=2

My understanding was that the existing function wrappers were accepted because:

(1) The functions are adding dev_err() calls that would have to be replicated
for each call if we don't create a new function.
(2) The _sys_ macros are adding a base address offset, which facilitates
sharing code between multiple devices (although only the n3000 is supported with
the current patches).

Would you prefer that we handle these on a case by case basis? And only provide
wrappers for the ones that have high usage?

- Russ

