Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1269B4BBAA2
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Feb 2022 15:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiBROaL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Feb 2022 09:30:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiBROaK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Feb 2022 09:30:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 258335B880
        for <linux-fpga@vger.kernel.org>; Fri, 18 Feb 2022 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645194592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cre5M583hm0qhLExvImfc/VgDcRzV3gtvq6Dg7X1ldM=;
        b=H/GBBCvOGROrJPGmMC9QvXWee+S+GKDSoSknJqAwaOokvhxqgOiRdYSl0ENsFnTD2M0UXZ
        GFYCMHyP4M1NNozOPG0UEHxA1JydVdkKPiiBXf2k653XwTMwkE3O4pa9Aze3xrHd9Ur7X1
        Xer/7StNB88KjCBWd/AT0TAcKmaKfig=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-urPrsybBNZusqnHKtLMM_Q-1; Fri, 18 Feb 2022 09:29:51 -0500
X-MC-Unique: urPrsybBNZusqnHKtLMM_Q-1
Received: by mail-qv1-f69.google.com with SMTP id cs16-20020ad44c50000000b0042bfd7b5158so9017316qvb.3
        for <linux-fpga@vger.kernel.org>; Fri, 18 Feb 2022 06:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Cre5M583hm0qhLExvImfc/VgDcRzV3gtvq6Dg7X1ldM=;
        b=VTMxTAt2vAW0YKHFY94Daa4mWrCQH9EMKY7n+RmYw68narghwHIs+oobAc+x7BJn0H
         NS39fLsesJVnY83oKC2TVH4LBr94YJiaB9UHk6XkYeP70cDVKLy6N/lNP5ctXlO1nTam
         e8RpnbBJ3iHnlhnCJT+Vyc6psIdK4OdFPDej0qTlS/HgFqql8/hXTP+3d8cYXifiTWVf
         3jBNmX2sKunB8T/x245Xf4Sba3mDcRceHUt5IG0Rd3ooYl2w02er67wdQeZ4ahuA+tp2
         cm/uyI4dCaLzRRx73QcTCDLYF86nx1WZhrb/975F23w74GjTfYWeyd+oQfEDpE6ikcoS
         Y5Jg==
X-Gm-Message-State: AOAM5329Yn4WQqT3AHI5MESfXpOcoAqO5+mNt0tb13vSVjjYBSJ8MnLK
        mWiUOVZVW4Fm4nCmKllQUuJ8wR6tmMzf+fktzI7GNLo/WBv5nxA3I3aYtpqpZiqUhQcgiWYzzq7
        +9Iws9CbGoV5v6yDZCnfpSQ==
X-Received: by 2002:a0c:be8f:0:b0:42c:5083:c6d2 with SMTP id n15-20020a0cbe8f000000b0042c5083c6d2mr5952008qvi.86.1645194590525;
        Fri, 18 Feb 2022 06:29:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6spxCalP4ZsB+KSA5YXirNzgk82RqD8K1eLb67sD60cSs8GVpewcKL+2Q5q7aU7TWOZo3LA==
X-Received: by 2002:a0c:be8f:0:b0:42c:5083:c6d2 with SMTP id n15-20020a0cbe8f000000b0042c5083c6d2mr5951987qvi.86.1645194590259;
        Fri, 18 Feb 2022 06:29:50 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x13sm23119558qko.114.2022.02.18.06.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 06:29:49 -0800 (PST)
Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
 <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
 <BN9PR11MB54839B6D444DCEB7FD789F33E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <447ce66b-dea7-da2b-6879-e4d37a74ba7d@redhat.com>
Date:   Fri, 18 Feb 2022 06:29:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54839B6D444DCEB7FD789F33E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/22 10:53 PM, Zhang, Tianfei wrote:
>
>> -----Original Message-----
>> From: Tom Rix <trix@redhat.com>
>> Sent: Tuesday, February 15, 2022 10:49 PM
>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: corbet@lwn.net
>> Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq info
>>
>>
>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>> From: Tianfei Zhang <tianfei.zhang@intel.com>
>>>
>>> The feature ID of "Port User Interrupt" and the "PMCI Subsystem" are
>>> identical, 0x12, but one is for FME, other is for Port. It should
>>> check the feature type While parsing the irq info in
>>> parse_feature_irqs().
>> This seems like a bug fix and not part of iofs feature.
>>
>> Split this out of the patchset.

?

>>
>> This is a workaround a hardware problem, there should be some comments to
>> the effect that you can't trust _this_ or _that_ feature id and some special
>> handling earlier.
>>
>> The ambiguity of feature id is a problem, and this sort of bug will happen again.
>>
>> What can be done to prevent this in the future ?
> This patch is not workaround, this is a bug fix for DFL driver.
> The root cause is that DLF driver miss check the feature type while parsing the interrupt information,
> because some Feature IDs are identical between FME and Port, like PMCI in FME and "Port User Interrupt"
> in Port.
> The definition of Feature ID is here:
> https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-ids.rst
Helpful but hidden.  At least a link to this should be added to 
Documentation/fpga/dfl.rst.
>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>> ---
>>>    drivers/fpga/dfl.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c index
>>> 599bb21d86af..26f8cf890700 100644
>>> --- a/drivers/fpga/dfl.c
>>> +++ b/drivers/fpga/dfl.c
>>> @@ -940,9 +940,14 @@ static int parse_feature_irqs(struct
>> build_feature_devs_info *binfo,
>>>    {
>>>    	void __iomem *base = binfo->ioaddr + ofst;
>>>    	unsigned int i, ibase, inr = 0;
>>> +	enum dfl_id_type type;
>>>    	int virq;
>>>    	u64 v;
>>>
>>> +	type = feature_dev_id_type(binfo->feature_dev);
>>> +	if (type >= DFL_ID_MAX)
>>> +		return -EINVAL;
>>> +
>>>    	/*
>>>    	 * Ideally DFL framework should only read info from DFL header, but
>>>    	 * current version DFL only provides mmio resources information for
>>> @@ -959,16 +964,22 @@ static int parse_feature_irqs(struct
>> build_feature_devs_info *binfo,
>>>    	 */
>>>    	switch (fid) {
>>>    	case PORT_FEATURE_ID_UINT:
>>> +		if (type != PORT_ID)
>>> +			break;
>> Instead of embedding a break in the switch, break the switch into fme switch
>> and port switch
>>
>> if (type == PORT_ID)
>>
>>     port-switch
>>
>> else if (type == FME_ID
>>
>>     fme-switch
> Your suggestion is looks good  for me, I will change on next version.
>
>> Tom
>>
>>>    		v = readq(base + PORT_UINT_CAP);
>>>    		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>>>    		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>>>    		break;
>>>    	case PORT_FEATURE_ID_ERROR:
>>> +		if (type != PORT_ID)
>>> +			break;
>>>    		v = readq(base + PORT_ERROR_CAP);
>>>    		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>>>    		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>>>    		break;
>>>    	case FME_FEATURE_ID_GLOBAL_ERR:
>>> +		if (type != FME_ID)
>>> +			break;
>>>    		v = readq(base + FME_ERROR_CAP);
>>>    		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>>>    		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);

