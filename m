Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63D5EC25C
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Sep 2022 14:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiI0MRR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Sep 2022 08:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiI0MRH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Sep 2022 08:17:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EAA97EF7;
        Tue, 27 Sep 2022 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664281024; x=1695817024;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QXo6V+qO8Ns2LyPwemxbLMvrNu4V0W0g1GllJpDy0co=;
  b=CVHtrza+MEI7GAbbPvJVuuNTGK7p5JAzoRa7j/tbfQOm8fuPfdoUFk9m
   u5oidpc3jBQboZX9Hh6N/mrhNPaH6jO5dj20M5xkAD38+VK4nfxebHHJF
   1EenqRglvAfxHzbfiTmDO1aBmbPV+4FqJ/S9EYmrUDOrRqTWIcPNENpFL
   GyX9nZsc3yk495FpniUjG8Fl69ZsuqVxs93781qefd3KAIcD62dHstMho
   SN0c3o6ib5FBd2+T6qu/UeBJYApxOw7MKrqwN7ZMy3mRSGPiW3sNIyGv4
   yDIwu0HvV6DN31jmXevKRCaSba/ViliYsZLm5IVcgpTbOal3TT9rZRY5R
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="281021131"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="281021131"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:17:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="689973135"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="689973135"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:17:02 -0700
Date:   Tue, 27 Sep 2022 05:17:14 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 4/6] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <609e122-f6a0-c0c2-4168-4025dd96a1ac@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209270516220.2164321@rhweight-WRK1>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-5-matthew.gerlach@linux.intel.com> <a602677-78ac-23a0-1a63-96b325595998@linux.intel.com> <alpine.DEB.2.22.394.2209260734490.363733@rhweight-WRK1>
 <609e122-f6a0-c0c2-4168-4025dd96a1ac@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1124427466-1664281041=:2164321"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1124427466-1664281041=:2164321
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT



On Tue, 27 Sep 2022, Ilpo Järvinen wrote:

> On Mon, 26 Sep 2022, matthew.gerlach@linux.intel.com wrote:
>
>>
>>
>> On Fri, 23 Sep 2022, Ilpo Järvinen wrote:
>>
>>> On Fri, 23 Sep 2022, matthew.gerlach@linux.intel.com wrote:
>>>
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Define and use a DFHv1 parameter to add generic support for MSIX
>>>> interrupts for DFL devices.
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> ---
>>>> v2: fix kernel doc
>>>>     clarify use of DFH_VERSION field
>>>> ---
>>>>  drivers/fpga/dfl.c  | 60 +++++++++++++++++++++++++++++++++++++++++----
>>>>  include/linux/dfl.h | 14 +++++++++++
>>>>  2 files changed, 69 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>>>> index 1132f3c10440..dfd3f563c92d 100644
>>>> --- a/drivers/fpga/dfl.c
>>>> +++ b/drivers/fpga/dfl.c
>>>> @@ -941,23 +941,22 @@ static int parse_feature_irqs(struct
>>>> build_feature_devs_info *binfo,
>>>>  	void __iomem *base = binfo->ioaddr + ofst;
>>>>  	unsigned int i, ibase, inr = 0;
>>>>  	enum dfl_id_type type;
>>>> -	int virq;
>>>> +	int virq, off;
>>>>  	u64 v;
>>>>
>>>>  	type = feature_dev_id_type(binfo->feature_dev);
>>>>
>>>>  	/*
>>>>  	 * Ideally DFL framework should only read info from DFL header, but
>>>> -	 * current version DFL only provides mmio resources information for
>>>> +	 * current version, DFHv0, only provides mmio resources information
>>>> for
>>>>  	 * each feature in DFL Header, no field for interrupt resources.
>>>>  	 * Interrupt resource information is provided by specific mmio
>>>>  	 * registers of each private feature which supports interrupt. So in
>>>>  	 * order to parse and assign irq resources, DFL framework has to look
>>>>  	 * into specific capability registers of these private features.
>>>>  	 *
>>>> -	 * Once future DFL version supports generic interrupt resource
>>>> -	 * information in common DFL headers, the generic interrupt parsing
>>>> -	 * code will be added. But in order to be compatible to old version
>>>> +	 * DFHv1 supports generic interrupt resource information in DFHv1
>>>> +	 * parameter blocks. But in order to be compatible to old version
>>>>  	 * DFL, the driver may still fall back to these quirks.
>>>>  	 */
>>>>  	if (type == PORT_ID) {
>>>> @@ -981,6 +980,36 @@ static int parse_feature_irqs(struct
>>>> build_feature_devs_info *binfo,
>>>>  		}
>>>>  	}
>>>>
>>>> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
>>>> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
>>>> +
>>>> +		v = FIELD_GET(DFH_VERSION, readq(base));
>>>
>>> I'd call this variable version (or ver) if you want to store it but it
>>> would also fit to switch () line so that no extra variable is needed.
>>
>> I will change the v to dfh_ver to be clearer.  I want to store the value
>> because it is used in the default case in the error message.  The error
>> message helps to debug broken FPGA images.
>
> Right, I missed that (or didn't think it too much and all being called
> "v" didn't help either :-)).
>
>>>> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
>>>> +				off = dfl_find_param(base + DFHv1_PARAM_HDR,
>>>> ofst,
>>>> +						     DFHv1_PARAM_ID_MSIX);
>>>> +				if (off >= 0) {
>>>
>>> I'd reverse these 2 conditions and break when there's nothing to do.
>>
>> I'm not sure what you mean by reversing these conditions because a DFHv1 may
>> or may not have parameters (the first condition), and a DFHv1 may have
>> parameters but may not have a MSI-X parameter (the second condition).
>
> This is what I meant:
>
> 		if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v))
> 			break;
>
> 		off = dfl_find_param(...);
> 		if (off < 0)
> 			break;
>
> 		ibase = ...

I understand now.  This is a good suggestion because the resulting 
indentation is better.

Thanks,
Matthew


>
>
> -- 
> i.
>
>
>>>> +					ibase = readl(base + DFHv1_PARAM_HDR +
>>>> +						      off +
>>>> DFHv1_PARAM_MSIX_STARTV);
>>>> +					inr = readl(base + DFHv1_PARAM_HDR +
>>>> +						    off +
>>>> DFHv1_PARAM_MSIX_NUMV);
>>>> +					dev_dbg(binfo->dev, "start %d num %d
>>>> fid 0x%x\n",
>>>> +						ibase, inr, fid);
>>>> +				}
>>>> +			}
>>>> +			break;
>
--8323328-1124427466-1664281041=:2164321--
