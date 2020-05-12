Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10011D0033
	for <lists+linux-fpga@lfdr.de>; Tue, 12 May 2020 23:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgELVK4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 May 2020 17:10:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:20082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgELVK4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 May 2020 17:10:56 -0400
IronPort-SDR: NHbNQOOfFI1+ZAAMXkKHcu+SKYa6zi+v8/xL97dpvg8QnA7uPcGhWROU5BNNiFIG35PjtGGJ82
 F6Ft2Wv2pbUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 14:10:55 -0700
IronPort-SDR: ryy41q/cCF/rB0wFlMvt1vQzwChTsIBW/914zRGtLtlHuciZwNOl2FivjyGGl28QDa8o5hWmuW
 93zjV74AbCEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,385,1583222400"; 
   d="scan'208";a="437241109"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2020 14:10:54 -0700
Subject: Re: [PATCHv1] fpga: stratix10-soc: remove the pre-set reconfiguration
 condition
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, Richard Gong <richard.gong@intel.com>
References: <1589290051-30246-1-git-send-email-richard.gong@linux.intel.com>
 <20200512153514.GA125665@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <5c23279d-17be-f33c-469c-461219027465@linux.intel.com>
Date:   Tue, 12 May 2020 16:27:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200512153514.GA125665@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

On 5/12/20 10:35 AM, Moritz Fischer wrote:
> Hi Richard,
> 
> On Tue, May 12, 2020 at 08:27:31AM -0500, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> The reconfiguration mode is pre-set by driver as the full reconfiguration.
>> As a result, user have to change code and recompile the drivers if he or
>> she wants to perform a partial reconfiguration. Removing the pre-set
>> reconfiguration condition so that user can select full or partial
>> reconfiguration via overlay device tree without recompiling the drivers.
>>
>> Also add an error message if the configuration request is failure.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   drivers/fpga/stratix10-soc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>> index 44b7c56..2da8a40 100644
>> --- a/drivers/fpga/stratix10-soc.c
>> +++ b/drivers/fpga/stratix10-soc.c
>> @@ -182,12 +182,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>>   	uint i;
>>   	int ret;
>>   
>> -	ctype.flags = 0;
>>   	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>>   		dev_dbg(dev, "Requesting partial reconfiguration.\n");
>> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
>> +		ctype.flags = 1;
> Have you considered:
> 
> ctype.flags = BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> 
> instead (assuming 1, lines up with BIT(COMMAND_RECONFIG_FLAG_PARTIAL)?
> 
> If not: Can you define a constant?

How about change below?

+#define RECONFIG_FLAG_FULL             0
+#define RECONFIG_FLAG_PARTIAL          1
+
  /*
   * struct s10_svc_buf
   * buf:  virtual address of buf provided by service layer
@@ -184,10 +187,10 @@ static int s10_ops_write_init(struct fpga_manager 
*mgr,

         if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
                 dev_dbg(dev, "Requesting partial reconfiguration.\n");
-               ctype.flags = 1;
+               ctype.flags = RECONFIG_FLAG_PARTIAL;
         } else {
                 dev_dbg(dev, "Requesting full reconfiguration.\n");
-               ctype.flags = 0;
+               ctype.flags = RECONFIG_FLAG_FULL;
         }

The protocol between kernel driver and the firmware:
The reconfiguration flag for full or partial configuration. 0 is for 
full (default mode) and 1 for partial reconfiguration.

I will submit a new version.

Regards,
Richard

>>   	} else {
>>   		dev_dbg(dev, "Requesting full reconfiguration.\n");
>> +		ctype.flags = 0;
>>   	}
>>   
>>   	reinit_completion(&priv->status_return_completion);
>> @@ -210,6 +210,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>>   
>>   	ret = 0;
>>   	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
>> +		dev_err(dev, "RECONFIG_REQUEST failed\n");
>>   		ret = -ETIMEDOUT;
>>   		goto init_done;
>>   	}
>> -- 
>> 2.7.4
>>
> 
> Cheers,
> Moritz
> 
