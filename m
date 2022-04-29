Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028EB51493A
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Apr 2022 14:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359086AbiD2M1W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Apr 2022 08:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353159AbiD2M1U (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Apr 2022 08:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5754CC8BFD
        for <linux-fpga@vger.kernel.org>; Fri, 29 Apr 2022 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651235038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iq/HGTUEuDIYvjQxG6tT1C9QioXwhYqdZIKb2HytgqY=;
        b=CpGSxQjB3BlFo58IbznHBT8vcwAaz1eATGhVhM/s/EbD8EgQk6R0beJo+DQMnNBQKkgrog
        EGnxHV0PIFLwN3Jw1OYKkWhobFR549LxYTTAZTBB1bVZKePI/RIErkCpYWBgJA0K22pohC
        J9b706LgBBwMdscXEPr38L/PzunmmmI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-Ay4Q_MtfMPeqR_vCau8rFw-1; Fri, 29 Apr 2022 08:23:57 -0400
X-MC-Unique: Ay4Q_MtfMPeqR_vCau8rFw-1
Received: by mail-qv1-f70.google.com with SMTP id k10-20020ad45bea000000b0044c3ec9f75cso5855166qvc.4
        for <linux-fpga@vger.kernel.org>; Fri, 29 Apr 2022 05:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Iq/HGTUEuDIYvjQxG6tT1C9QioXwhYqdZIKb2HytgqY=;
        b=ogN1IdHVmVo2S51wCRbi+IeiHBrS+IKa5qUNEI9ynElkj3mp8NneX/TkFHf0R5Ue8O
         sP09xVW6WQ5t6nwkTk11eG5WZdN1zwBcxLXU0md/WES9fqTuU84EZtoKzOBW3aL0UXWZ
         wLr6FQjxxLPvf9p6nhhiw++1zXpPqWT/vOdSKNwypiXYeOrakYJ9NfwccIgDrPPHkdfw
         MePa6pB9bEYtysjyphBWR9ecFoy4QEqFOYvA9GdOy1uwxeus0o+bjwS3VlCgjL49832y
         3U7igSasyD93wKVV2uFKj6yZGNfc1ExAcE7Pm4FndVpi/Io/sRODZNeaHmXx7xodsS7M
         8Bfg==
X-Gm-Message-State: AOAM533hvn/et9mDkO4a0tGh7Xs71f3rP5wqSpkiCd2AqLUFByZx6HxZ
        Sjx9CmuOw8mJ+6w1OyB3nNllH6jeQvppU1J1R1kAZWTq4zO6OgA6/chT516l6jeO7zYToDCNn5l
        KoejCjpcf6RpydmRjR1NxRA==
X-Received: by 2002:a37:ba04:0:b0:69f:840c:b627 with SMTP id k4-20020a37ba04000000b0069f840cb627mr9937312qkf.285.1651235036852;
        Fri, 29 Apr 2022 05:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLIVdcXV1WqPzHlKJQANOcMOIrySvK7nYoaSfktcl+h9wZ9APF5knDfmrgNGkIJnQhWjWzag==
X-Received: by 2002:a37:ba04:0:b0:69f:840c:b627 with SMTP id k4-20020a37ba04000000b0069f840cb627mr9937301qkf.285.1651235036659;
        Fri, 29 Apr 2022 05:23:56 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a138e00b002f335c3dbf2sm1473751qtk.37.2022.04.29.05.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 05:23:56 -0700 (PDT)
Subject: Re: [PATCH v3] uio: dfl: add HSSI subsystem feature id
To:     Tianfei Zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220429005726.607804-1-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b3f0bc47-70ea-2da5-2891-3b01550c6da6@redhat.com>
Date:   Fri, 29 Apr 2022 05:23:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220429005726.607804-1-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/28/22 5:57 PM, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add the Device Feature List (DFL) feature id for the
> High Speed Serial Interface (HSSI) Subsystem to the
> table of ids supported by the uio_dfl driver.
>
> The HSSI Subsystem is a configurable set of IP blocks
> to be used as part of a Ethernet or PCS/FEC/PMA pipeline.
> Like the Ethernet group used by the N3000 card, the HSSI
> Subsystem does not fully implement a network device from
> a Linux netdev perspective and is controlled and monitored
> from user space software via the uio interface.

Generally you should include the url for the dfl definitions.

Can you add it here to the commit log ?

Otherwise fine.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v3: change the name of this feature id to HSSI_SUBSYS and rewrite
>      the git message.
> v2: add HSSI introduction and the git repo of Feature ID table.
> ---
>   drivers/uio/uio_dfl.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 89c0fc7b0cbc..8f39cc8bb034 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>   }
>   
>   #define FME_FEATURE_ID_ETH_GROUP	0x10
> +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
>   
>   static const struct dfl_device_id uio_dfl_ids[] = {
>   	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);

