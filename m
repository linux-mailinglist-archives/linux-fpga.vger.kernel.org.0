Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00D55AA83
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Jun 2022 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiFYN2w (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Jun 2022 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiFYN2s (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 25 Jun 2022 09:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7587E028
        for <linux-fpga@vger.kernel.org>; Sat, 25 Jun 2022 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656163725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ave09IOGGsVI7o5wbNdPR+5oXfThrVBWl1Nc/iKMVrU=;
        b=Hq7RmT+v+Pdh0cS8qfkDg6Dn2Dg4yNsaPF0rjJ95rDeBvSy0M4RwYdRJ2WwZTHvvzhoB/p
        g1oMwnyXxvI6NgqVA5JMsLRPBpd9xw5963i3K6KHMQ8jsUXxumDgSZZjkAOsVkY1O7t8ek
        vmGQTRCYbkXqX5tsiCE0BP+OaCiVUBw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-OD11hpRFMP-fVQUDpDIrbQ-1; Sat, 25 Jun 2022 09:28:44 -0400
X-MC-Unique: OD11hpRFMP-fVQUDpDIrbQ-1
Received: by mail-qv1-f71.google.com with SMTP id m12-20020a0cac4c000000b00470450cd18dso5226014qvb.8
        for <linux-fpga@vger.kernel.org>; Sat, 25 Jun 2022 06:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ave09IOGGsVI7o5wbNdPR+5oXfThrVBWl1Nc/iKMVrU=;
        b=ve14PWuwRvecfpHe50GOX2vEz6LFIs0CG6s28QFqsdTGRKXPGt+nkHYhbWyIQ5Sizx
         X2xW5j9g+6InTSaADx/Fvms7zwOQrdPyQzDIC/MmNzYuF0giMeV8oYI1Er+K2uQRQcY+
         8kXkIUahr5oaff7K1+R1JXlqkcMZmpojR96J2L3XUAjJEG50ezPC6oUDBKjBDPmsAAw5
         Scb10Io1Gu6uldfAz1CCA6lV39FH0oDA9k61JVBHYiaREKGKu5Uo6zOPxceQYkB8iP+P
         0kNjKFqwe4IqUkq89+dRkCYrX5Bs2E8y/g0RqwHycFJ0yBrYSABfGFTW4zAYKvCy4Vgk
         mECg==
X-Gm-Message-State: AJIora+ZFa6at16rzRAdhvDFeN729TVKSLfPa8lBuJZ+eAtDE/PeOCjf
        UF5+x514yELL1Y0HaCeDli7d6LtpW38OXovSv2lewGGThYJizy/b3j0mPP6Oe1WpuePe9rzsep+
        iLYgFmr3k+rgiNCmnzXgJ6A==
X-Received: by 2002:a05:620a:2807:b0:6a6:6ef1:fb9d with SMTP id f7-20020a05620a280700b006a66ef1fb9dmr2799993qkp.146.1656163723887;
        Sat, 25 Jun 2022 06:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umbOvkFH9zj98Ct7hnUPOcZ2hUgG9SnzFk1TnguB9l5RkrhwcTMbjtoBbjwby/Vu7lLH0CIw==
X-Received: by 2002:a05:620a:2807:b0:6a6:6ef1:fb9d with SMTP id f7-20020a05620a280700b006a66ef1fb9dmr2799976qkp.146.1656163723628;
        Sat, 25 Jun 2022 06:28:43 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id l14-20020ac8148e000000b002f9399ccefasm3289481qtj.34.2022.06.25.06.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 06:28:43 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] mfd: intel-m10-bmc: rename the local variables
To:     Tianfei Zhang <tianfei.zhang@intel.com>, yilun.xu@intel.com,
        lee.jones@linaro.org
Cc:     hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com
References: <20220624092229.45854-1-tianfei.zhang@intel.com>
 <20220624092229.45854-2-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e6e5547e-d4d4-03a5-43cd-90922f9d1959@redhat.com>
Date:   Sat, 25 Jun 2022 06:28:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220624092229.45854-2-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/24/22 2:22 AM, Tianfei Zhang wrote:
> It had better use ddata for local variables which
> directly interacts with dev_get_drvdata()/dev_set_drvdata().

This is a cleanup, not related to the patchset, it should be split from 
the patchset.

Tom

>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/mfd/intel-m10-bmc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 8db3bcf5fccc..7e521df29c72 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -86,15 +86,15 @@ static DEVICE_ATTR_RO(bmcfw_version);
>   static ssize_t mac_address_show(struct device *dev,
>   				struct device_attribute *attr, char *buf)
>   {
> -	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
>   	unsigned int macaddr_low, macaddr_high;
>   	int ret;
>   
> -	ret = m10bmc_sys_read(max10, M10BMC_MAC_LOW, &macaddr_low);
> +	ret = m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
>   	if (ret)
>   		return ret;
>   
> -	ret = m10bmc_sys_read(max10, M10BMC_MAC_HIGH, &macaddr_high);
> +	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
>   	if (ret)
>   		return ret;
>   
> @@ -111,11 +111,11 @@ static DEVICE_ATTR_RO(mac_address);
>   static ssize_t mac_count_show(struct device *dev,
>   			      struct device_attribute *attr, char *buf)
>   {
> -	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
>   	unsigned int macaddr_high;
>   	int ret;
>   
> -	ret = m10bmc_sys_read(max10, M10BMC_MAC_HIGH, &macaddr_high);
> +	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
>   	if (ret)
>   		return ret;
>   

