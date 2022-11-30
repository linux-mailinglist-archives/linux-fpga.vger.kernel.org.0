Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3E63DBDB
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Nov 2022 18:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiK3RVl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Nov 2022 12:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiK3RVk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Nov 2022 12:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCEF2EF
        for <linux-fpga@vger.kernel.org>; Wed, 30 Nov 2022 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669828837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfQ7QiYfoE52xD4bGT55kmCqWuS4ZEeF86n+w8XG+J4=;
        b=dXgmza30lt62vsM26Usw6+OAIpUVoQR0WIVf3w88lmYdkSmnNzph0LQyjY0j0m/sga6is7
        ymLNO3Q7WiQ56hHw04Wtlkm6OIOVLylY7QySd3NMyPTgO+joqNg/Usw/dUYKS4/IMj0eXA
        GrQJX2FprZUaGxkUZff5IiJ+vBN0UAc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-BoKd0n_9Nri1jtQ1E6dg7Q-1; Wed, 30 Nov 2022 12:20:36 -0500
X-MC-Unique: BoKd0n_9Nri1jtQ1E6dg7Q-1
Received: by mail-qt1-f198.google.com with SMTP id ay12-20020a05622a228c00b003a52bd33749so29288958qtb.8
        for <linux-fpga@vger.kernel.org>; Wed, 30 Nov 2022 09:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfQ7QiYfoE52xD4bGT55kmCqWuS4ZEeF86n+w8XG+J4=;
        b=l0o+jnWrwmyyj+Mwj+3U0/5GWNEyE8s0C+r1pMqxejMOJuv2Wjxi8DgfOyiOz9JxL+
         y9VR7ArKmjlmobXoNJ17Niqle/TAS9tTfZUcVn5MTtHJlz6uiQ+a+Wd4MZc71QeWrosU
         7RW0LRO84q7p9rvZyOYK1Jhrio3pLCWin1/8mh7Blp/rYq+4gKBP8126A/Y/7Gl/4EMq
         x1iOzwHLCQCPp1lYP6eCUC/cfaVq/cQgXxjq6CergtpCRzy7H7pubPq5emvkeIO7bwWu
         zgEgpuHCM4eCBKqivfSQaC5mn1CkZKM7yoGOtJzpch/+cChLwTrOiamum8nLYGcxPU20
         uDpA==
X-Gm-Message-State: ANoB5pk+dulfC6mbDjnxPJMXIeAO3oaoke1b9qfdz37jg5CV8jO0HL4y
        wI3da1RG6gNhV1gAVMjFoAWR6YKKHCC/VSluEldC2ZAb7zDWWDzR57uByxlVJxgtcrcpwLjbHIb
        HpZnAa9eRzUYbJ7aIRMoV
X-Received: by 2002:a05:620a:488a:b0:6f1:187c:8f79 with SMTP id ea10-20020a05620a488a00b006f1187c8f79mr54581822qkb.593.1669828836037;
        Wed, 30 Nov 2022 09:20:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf49GCx1/laAUqNn7mO4+ckiGxudVpsJ4syaVLU2WQZPInCZ5ZPiOQmmgbJIPYZ+XjnCfR89xA==
X-Received: by 2002:a05:620a:488a:b0:6f1:187c:8f79 with SMTP id ea10-20020a05620a488a00b006f1187c8f79mr54581789qkb.593.1669828835765;
        Wed, 30 Nov 2022 09:20:35 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-28-144.cust.vodafonedsl.it. [2.34.28.144])
        by smtp.gmail.com with ESMTPSA id l5-20020a05620a28c500b006cf19068261sm1539708qkp.116.2022.11.30.09.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 09:20:35 -0800 (PST)
Message-ID: <0f28f75d-ac27-1f3d-2531-6b0f7504db85@redhat.com>
Date:   Wed, 30 Nov 2022 18:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] fpga: m10bmc-sec: Fix probe rollback
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20221130091158.4732-1-ilpo.jarvinen@linux.intel.com>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20221130091158.4732-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2022-11-30 10:11, Ilpo Järvinen wrote:
> Handle probe error rollbacks properly to avoid leaks.
> 
> Fixes: 5cd339b370e2 ("fpga: m10bmc-sec: add max10 secure update functions")

Reviewed-by: Marco Pagani <marpagan@redhat.com>

> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 79d48852825e..03f1bd81c434 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -574,20 +574,27 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>  	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
>  			sec->fw_name_id);
>  	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
> -	if (!sec->fw_name)
> -		return -ENOMEM;
> +	if (!sec->fw_name) {
> +		ret = -ENOMEM;
> +		goto fw_name_fail;
> +	}
>  
>  	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
>  				       &m10bmc_ops, sec);
>  	if (IS_ERR(fwl)) {
>  		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
> -		kfree(sec->fw_name);
> -		xa_erase(&fw_upload_xa, sec->fw_name_id);
> -		return PTR_ERR(fwl);
> +		ret = PTR_ERR(fwl);
> +		goto fw_uploader_fail;
>  	}
>  
>  	sec->fwl = fwl;
>  	return 0;
> +
> +fw_uploader_fail:
> +	kfree(sec->fw_name);
> +fw_name_fail:
> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
> +	return ret;
>  }
>  
>  static int m10bmc_sec_remove(struct platform_device *pdev)

