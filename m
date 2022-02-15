Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448DB4B7245
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Feb 2022 17:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbiBOPvI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 10:51:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbiBOPvD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 10:51:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC3862CCA6
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644940248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLICeKJBXSwpSnP3JhYsPftkHusO2mSaNRauGzzS1kQ=;
        b=cpiynGExPK7YHoNeAPF3XLuvl+9/OoS2qkOK9Tgg2pK+Bu9Lq+BKiaI2iO3P6Bu96lYO6D
        FkTCxWyNHZONnH2AkurO65wTHPsToLQmUKNNNFhkl4AHO3tP2ZC2RNa0gdbJv7svqEiJcA
        dZ/JxCGRwoMsGFvN7lKQc00QbeNXU1M=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-oTLw2vEzN3iRmtKlFvO9Pw-1; Tue, 15 Feb 2022 10:50:44 -0500
X-MC-Unique: oTLw2vEzN3iRmtKlFvO9Pw-1
Received: by mail-oo1-f71.google.com with SMTP id h13-20020a4aa74d000000b002e99030d358so12844437oom.6
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 07:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dLICeKJBXSwpSnP3JhYsPftkHusO2mSaNRauGzzS1kQ=;
        b=x+AV9u/7qCfxI1XZC3Ylq5Fe/pqg1SxP2PEJaEz7qXNzz5rDBPN8LIOmRFPXxa3cpr
         e3Jm5Zgwj1J3j2BUpUYT3BAtRT1plAtp0Yi2hUXvJkSMsUb0wu0ANS19sRVac3tBXv7n
         neU1BVBcJKShJ8JPS/SkNtnft/maPPYUq7arZfwTIixD+kB4Hvg/fgL2lf2vTO6vml2q
         WJE6mn+JxrB9pjHNJUuXyGnAkc/mHhywtSoMtIQv5qr+mI6YcBg29ylbVexiSGdkwa+V
         fwIOZ50dY++hfxOqBodVKVAKYXsyKIzEOrMs+VRgyuarOTdjjoT/3RXBb6W5DNqNd6Vx
         HZEQ==
X-Gm-Message-State: AOAM530+mtmq3+8Yvf5EulYB+oTueLvtEUXpCCDcR0SQQY7aAIYxIeys
        MYSF7ZcWIrSpI4qKKbj/vCla9Oa742H8+2SxwjqycDuvG8cMwL0xIkw7A4iiOQvfIGiwSdEJQP4
        L0JX8/EgJ3KxPq4XOTxwrJw==
X-Received: by 2002:a9d:a28:: with SMTP id 37mr1098482otg.225.1644940243977;
        Tue, 15 Feb 2022 07:50:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbDHT+/ZKmI2sFiyJuItMHm4fmoZcrlrJeWNTWAPast7TEOmnI7Tbs6g1lSY552mvQQLiGwA==
X-Received: by 2002:a9d:a28:: with SMTP id 37mr1098472otg.225.1644940243774;
        Tue, 15 Feb 2022 07:50:43 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c14sm4375713ots.71.2022.02.15.07.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:50:42 -0800 (PST)
Subject: Re: [PATCH v1 4/7] fpga: dfl: fix VF creation when ports have no
 local BAR space
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-5-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c527e9c7-4588-463b-8a6b-3db68d003d7a@redhat.com>
Date:   Tue, 15 Feb 2022 07:50:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-5-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> When a port is not connected to the same PCIe endpoint as
> the FME, the port does not need to be released before being
> virtualized.  Fix VF creation code to handle this new use
Similar, how does this fit in with iofs, this looks like it would not be 
valid for the existing cards
> case.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 26f8cf890700..cfc539a656f0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1705,15 +1705,22 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_pf);
>   int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
>   {
>   	struct dfl_feature_platform_data *pdata;
> -	int ret = 0;
> +	int ret = 0, port_count = 0;
>   
>   	mutex_lock(&cdev->lock);
> +
> +	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> +		if (pdata->dev)

This looks wrong,

pdata->dev is dereferenced below, if there is a case were (!pdata->dev) 
here there would be crash later.

> +			continue;
> +		port_count++;

how does this work when only some of the ports are handled in the new way ?

Tom

> +	}
> +
>   	/*
>   	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
>   	 * device, so if released port number doesn't match VF device number,
>   	 * then reject the request with -EINVAL error code.
>   	 */
> -	if (cdev->released_port_num != num_vfs) {
> +	if (port_count && cdev->released_port_num != num_vfs) {
>   		ret = -EINVAL;
>   		goto done;
>   	}

