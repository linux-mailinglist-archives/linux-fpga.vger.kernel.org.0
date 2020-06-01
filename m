Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815CF1EA5D5
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Jun 2020 16:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgFAO3D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Jun 2020 10:29:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:62426 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgFAO3C (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Jun 2020 10:29:02 -0400
IronPort-SDR: eDnQCW1ZJPylzRy/PZuasH8kUYZ2RezGGxuekTl02sUWtosyzedY+VF2cH6JCipIFBr1YxKeJQ
 owslxdDmX2Yw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 07:29:02 -0700
IronPort-SDR: m/qf58auNm/mbSFh5gqhgm3GvgebuupukiYVAL7YLqPllovK0QNpUp2ND0KOmQlCX5S2vV0QsF
 fpToKSsG/JHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="268336293"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2020 07:29:01 -0700
Subject: Re: [PATCHv2] fpga: stratix10-soc: remove the pre-set reconfiguration
 condition
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, Richard Gong <richard.gong@intel.com>
References: <1589553303-7341-1-git-send-email-richard.gong@linux.intel.com>
 <1d9b21df-7421-b25e-5139-f297e24d99d4@linux.intel.com>
 <20200531194927.GA1622@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <de692e12-5f50-8235-5af9-2d3f5e659ddb@linux.intel.com>
Date:   Mon, 1 Jun 2020 09:44:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200531194927.GA1622@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,


On 5/31/20 2:49 PM, Moritz Fischer wrote:
> On Fri, May 29, 2020 at 08:15:15AM -0500, Richard Gong wrote:
>> Hi Moritz,
>>
>> Sorry for asking.
>>
>> When you get chance, can you review my version 2 patch submitted on
>> 05/15/20?
>>
>> Regards,
>> Richard
>>
>> On 5/15/20 9:35 AM, richard.gong@linux.intel.com wrote:
>>> From: Richard Gong <richard.gong@intel.com>
>>>
>>> The reconfiguration mode is pre-set by driver as the full reconfiguration.
>>> As a result, user have to change code and recompile the drivers if he or
>>> she wants to perform a partial reconfiguration. Removing the pre-set
>>> reconfiguration condition so that user can select full or partial
>>> reconfiguration via overlay device tree without recompiling the drivers.
> 
> Can you help me understand? See comment below, I'm not sure how this
> change changes the behavior.

Flag COMMAND_RECONFIG_FLAG_PARTIAL is defined in Intel service layer 
driver (include/linux/firmware/intel/stratix10-svc-client.h) and the 
default value is zero. It is obvious that COMMAND_RECONFIG_FLAG_PARTIAL 
should be set to 1 to support partial reconfiguration.

Please discard this FPGA patch, I will submit a patch on Intel service 
layer driver.

Regards,
Richard

>>>
>>> Also add an error message if the configuration request is failure.
>>>
>>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>>> ---
>>> v2: define and use constant values
>>> ---
>>>    drivers/fpga/stratix10-soc.c | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>>> index 44b7c56..4d52a80 100644
>>> --- a/drivers/fpga/stratix10-soc.c
>>> +++ b/drivers/fpga/stratix10-soc.c
>>> @@ -14,9 +14,13 @@
>>>    /*
>>>     * FPGA programming requires a higher level of privilege (EL3), per the SoC
>>>     * design.
>>> + * SoC firmware supports full and partial reconfiguration.
> Consider:
> "The SoC firmware supports full and partial reconfiguration."
>>>     */
>>>    #define NUM_SVC_BUFS	4
>>>    #define SVC_BUF_SIZE	SZ_512K
>>> +#define FULL_RECONFIG_FLAG	0
>>> +#define PARTIAL_RECONFIG_FLAG	1
>>> +
>>>    /* Indicates buffer is in use if set */
>>>    #define SVC_BUF_LOCK	0
>>> @@ -182,12 +186,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>>>    	uint i;
>>>    	int ret;
>>> -	ctype.flags = 0;
>>>    	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>>>    		dev_dbg(dev, "Requesting partial reconfiguration.\n");
>>> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
>>> +		ctype.flags = PARTIAL_RECONFIG_FLAG;
>>>    	} else {
>>>    		dev_dbg(dev, "Requesting full reconfiguration.\n");
>>> +		ctype.flags = FULL_RECONFIG_FLAG;
>>>    	}
> Am I missing something here: Doesn't this do the same as before?
> 
> Before:
> If info->flags & FPGA_MGR_PARTIAL_RECONFIG -> ctype.flags = 0 |
> BIT(COMMAND_RECONFIG_FLAG_PARTIAL) -> 1
> and ctype->flags = FULL_RECONFIG -> 0 else.
> 
> Now:
> If info->flags & FPGA_MGR_PARTIAL_RECONFIG -> ctype.flags = PARTIAL_RECONFIG_FLAG -> 1
> ctype->flags = FULL_REECONFIG_FLAG -> 0 else.
> 
> Am I missing something here? If I don't set the flag for partial
> reconfig I'd end up with full reconfiguration in both cases?
> If I do set the flag, I get partial reconfiguration in both cases?
> 
>>>    	reinit_completion(&priv->status_return_completion);
>>> @@ -210,6 +214,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>>>    	ret = 0;
>>>    	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
>>> +		dev_err(dev, "RECONFIG_REQUEST failed\n");
>>>    		ret = -ETIMEDOUT;
>>>    		goto init_done;
>>>    	}
>>>
> 
> Thanks,
> Moritz
> 
