Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A089E1E8370
	for <lists+linux-fpga@lfdr.de>; Fri, 29 May 2020 18:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgE2QS0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 May 2020 12:18:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:42733 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2QSZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 29 May 2020 12:18:25 -0400
IronPort-SDR: FqgEdUppQ8fTAbtJYZm8zGvNolVbhG7uYWXy3kzmxrlFE35NMi3lfSA11n1qNUGwwiksfUp0BX
 wSUdMs4ZLeuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 09:18:24 -0700
IronPort-SDR: nzZSX10Ee2HTJDPua8ovZ8AJhqNOZQ43/BsaMLEA7wjS8e+6IhO4k0L578H72tzdcisIH6Ue+Z
 YPf0yX7WQs1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="346311275"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.209.105.62])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2020 09:18:24 -0700
Subject: Re: [PATCHv2] fpga: stratix10-soc: remove the pre-set reconfiguration
 condition
To:     Richard Gong <richard.gong@linux.intel.com>, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, Richard Gong <richard.gong@intel.com>
References: <1589553303-7341-1-git-send-email-richard.gong@linux.intel.com>
 <1d9b21df-7421-b25e-5139-f297e24d99d4@linux.intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <3adbce08-78c3-7300-f2f8-1e12639af340@intel.com>
Date:   Fri, 29 May 2020 09:18:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1d9b21df-7421-b25e-5139-f297e24d99d4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Minor comment below.

- Russ

On 5/29/20 6:15 AM, Richard Gong wrote:
> Hi Moritz,
>
> Sorry for asking.
>
> When you get chance, can you review my version 2 patch submitted on 
> 05/15/20?
>
> Regards,
> Richard
>
> On 5/15/20 9:35 AM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> The reconfiguration mode is pre-set by driver as the full 
>> reconfiguration.
>> As a result, user have to change code and recompile the drivers if he or
>> she wants to perform a partial reconfiguration. Removing the pre-set
>> reconfiguration condition so that user can select full or partial
>> reconfiguration via overlay device tree without recompiling the drivers.
>>
>> Also add an error message if the configuration request is failure.
s/is failure/fails/
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v2: define and use constant values
>> ---
>>   drivers/fpga/stratix10-soc.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>> index 44b7c56..4d52a80 100644
>> --- a/drivers/fpga/stratix10-soc.c
>> +++ b/drivers/fpga/stratix10-soc.c
>> @@ -14,9 +14,13 @@
>>   /*
>>    * FPGA programming requires a higher level of privilege (EL3), per 
>> the SoC
>>    * design.
>> + * SoC firmware supports full and partial reconfiguration.
>>    */
>>   #define NUM_SVC_BUFS    4
>>   #define SVC_BUF_SIZE    SZ_512K
>> +#define FULL_RECONFIG_FLAG    0
>> +#define PARTIAL_RECONFIG_FLAG    1
>> +
>>     /* Indicates buffer is in use if set */
>>   #define SVC_BUF_LOCK    0
>> @@ -182,12 +186,12 @@ static int s10_ops_write_init(struct 
>> fpga_manager *mgr,
>>       uint i;
>>       int ret;
>>   -    ctype.flags = 0;
>>       if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>>           dev_dbg(dev, "Requesting partial reconfiguration.\n");
>> -        ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
>> +        ctype.flags = PARTIAL_RECONFIG_FLAG;
>>       } else {
>>           dev_dbg(dev, "Requesting full reconfiguration.\n");
>> +        ctype.flags = FULL_RECONFIG_FLAG;
>>       }
>> reinit_completion(&priv->status_return_completion);
>> @@ -210,6 +214,7 @@ static int s10_ops_write_init(struct fpga_manager 
>> *mgr,
>>         ret = 0;
>>       if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
>> +        dev_err(dev, "RECONFIG_REQUEST failed\n");
>>           ret = -ETIMEDOUT;
>>           goto init_done;
>>       }
>>
