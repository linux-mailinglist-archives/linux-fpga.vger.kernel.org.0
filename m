Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB23B4BBB78
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Feb 2022 15:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiBRO4a (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Feb 2022 09:56:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiBRO42 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Feb 2022 09:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14AD1580CF
        for <linux-fpga@vger.kernel.org>; Fri, 18 Feb 2022 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645196164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ldn/wyFUYS9oX2H4KZV4SRGFhvLNkEJlNBHlweSE44=;
        b=ZGJ6uKfop4GVTHnZqrhHQhp3RCzj2MiKOFHTiwphtj1caj4hla0uu227MojdUTUJLInGS3
        ABPX0tVStqI+JMidxPy2rY7UJySDx9KawhaTQMv44hiZq+edczVIeYdTwNxlvG7pkW3PIb
        d3eZNS/cJ86gYyTXvc1fZnqreDcmLnw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-P_QTXr7TMPa64I6Ersszqw-1; Fri, 18 Feb 2022 09:56:03 -0500
X-MC-Unique: P_QTXr7TMPa64I6Ersszqw-1
Received: by mail-qk1-f200.google.com with SMTP id k23-20020a05620a139700b0062cda5c6cecso2219896qki.6
        for <linux-fpga@vger.kernel.org>; Fri, 18 Feb 2022 06:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4ldn/wyFUYS9oX2H4KZV4SRGFhvLNkEJlNBHlweSE44=;
        b=CRAonA6XGo7MaWQkESXv7WRQNEBnMBdbG4GRpRa+C6jLc6uctZ7azM7uz5gyBOndv+
         sq18AEvJXY9+FFpwgmIV6LPDradXpcPw81RnUy1hIWXw/uj0JpWHOvcQ/jhg4Qm61F94
         PZYPgyas/4dvvyq0gVMj4yWGFezsSVyCmiF3t6AsU9l25slN6opVOUiunZ6xuMQqTkC8
         G4HvPfJQXljKtA20kz+scb2eyuwlp1+k347r1TyZSS2aKSrOWVZoIbX1b6cSOfFwIK4h
         /iJfw5pNURHV/OAEvx2IFOhF30iuOwus0tBiCdhKH/y0J8ZuHUrjKy96a0gVmkszBdDC
         IWMw==
X-Gm-Message-State: AOAM533xx67fgfkn5oUljBV9t+bivAE3BhCVg8iCito6YtB4hhyfP26h
        ccwN0zEc2iMZjSKQFR3EIH6CZi5WpAZXPg1Ohin4dcZSRdyUS2sg4TWxY2AWQDMN5sDHDqV3riu
        KA58nuCz+zLkOk/vINKr0/A==
X-Received: by 2002:ac8:5c8f:0:b0:2dd:b404:bd94 with SMTP id r15-20020ac85c8f000000b002ddb404bd94mr1693248qta.50.1645196162498;
        Fri, 18 Feb 2022 06:56:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8JBQaaH0N3aIPc7v5Iu6VHkGq5FX+w6ES4TNS3Zwc4jIuKXDTgK1I/UV9BSzRxEBdFdrTJA==
X-Received: by 2002:ac8:5c8f:0:b0:2dd:b404:bd94 with SMTP id r15-20020ac85c8f000000b002ddb404bd94mr1693178qta.50.1645196161706;
        Fri, 18 Feb 2022 06:56:01 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w3sm25923138qta.13.2022.02.18.06.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 06:56:01 -0800 (PST)
Subject: Re: [PATCH v1 4/7] fpga: dfl: fix VF creation when ports have no
 local BAR space
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-5-tianfei.zhang@intel.com>
 <c527e9c7-4588-463b-8a6b-3db68d003d7a@redhat.com>
 <BN9PR11MB54830E0D185101B6B1517113E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1281cbc7-7a1f-da84-3713-0d81982379ab@redhat.com>
Date:   Fri, 18 Feb 2022 06:55:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54830E0D185101B6B1517113E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2/18/22 12:14 AM, Zhang, Tianfei wrote:
>
>> -----Original Message-----
>> From: Tom Rix <trix@redhat.com>
>> Sent: Tuesday, February 15, 2022 11:51 PM
>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Subject: Re: [PATCH v1 4/7] fpga: dfl: fix VF creation when ports have no local
>> BAR space
>>
>>
>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> When a port is not connected to the same PCIe endpoint as the FME, the
>>> port does not need to be released before being virtualized.  Fix VF
>>> creation code to handle this new use
>> Similar, how does this fit in with iofs, this looks like it would not be valid for the
>> existing cards
> IOFS introducing multiple methods for PR and AFU access.
> 1. Legacy Model.
> 2. Micro-Personas in AFU.
> 3. Multiple VFs per PR slot.
>
> For 1 and 2 model, there are 1:1 mapping between Port device and PR slot (or entire AFU). In virtualization,
> it should release the Port device firstly and then assign to VM. In this models, the DFL driver will track  that
> the number of port devices has released (cdev->released_port_num in dfl_fpga_cdev_config_ports_vf() function)
> are equal with the numbers of SRIOV or not. But in model 3, it has multiple VFs per PR slot, and assign the VF to VM
> without release the port device, so the tracking mechanism of cdev->released_port_num is not workable on new

If ->release_port_num is not workable, then it needs to be generalized.

Refactor to handle all the cases.

Tom

> model. This patch want to handle this new model during VF creation.
>
>>> case.
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>> ---
>>>    drivers/fpga/dfl.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c index
>>> 26f8cf890700..cfc539a656f0 100644
>>> --- a/drivers/fpga/dfl.c
>>> +++ b/drivers/fpga/dfl.c
>>> @@ -1705,15 +1705,22 @@
>> EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_pf);
>>>    int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
>>>    {
>>>    	struct dfl_feature_platform_data *pdata;
>>> -	int ret = 0;
>>> +	int ret = 0, port_count = 0;
>>>
>>>    	mutex_lock(&cdev->lock);
>>> +
>>> +	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
>>> +		if (pdata->dev)
>> This looks wrong,
>>
>> pdata->dev is dereferenced below, if there is a case were (!pdata->dev)
>> here there would be crash later.
>>
>>> +			continue;
>>> +		port_count++;
>> how does this work when only some of the ports are handled in the new way ?
> This code want to handle the " Multiple VFs per PR slot" model as I mentioned above.
> In new model, the port_count want to count that how many port devices have released.
> This code looks not good readability, I try to re-write it.
>
>> Tom
>>
>>> +	}
>>> +
>>>    	/*
>>>    	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
>>>    	 * device, so if released port number doesn't match VF device number,
>>>    	 * then reject the request with -EINVAL error code.
>>>    	 */
>>> -	if (cdev->released_port_num != num_vfs) {
>>> +	if (port_count && cdev->released_port_num != num_vfs) {
>>>    		ret = -EINVAL;
>>>    		goto done;
>>>    	}

