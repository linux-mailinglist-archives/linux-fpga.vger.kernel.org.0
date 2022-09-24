Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68E5E8CEE
	for <lists+linux-fpga@lfdr.de>; Sat, 24 Sep 2022 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiIXNA3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 24 Sep 2022 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiIXNA2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 24 Sep 2022 09:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2863770E74
        for <linux-fpga@vger.kernel.org>; Sat, 24 Sep 2022 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664024426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6VBsZTlTPMMCZ9hB1ioUDpa1bHhT3SIX3HM69t18nU=;
        b=Rmm4fQk30etSXDcDfRDTjh7tNL+lnB2R0HR/m8R7b2FIVdMmmznNTvZJCN/rt+omJ6vsN6
        pkmXjy6+XgW7OCXB4/gGLnjLX0w8k57FcWaSS3mLPPECb5wzy6mxFsn3dO1GNo6pUv7Eq2
        upDMMb516bRBssUeBlOw+NPXG8LdOMU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659--enxycm0OiKr4N9Mch6JlQ-1; Sat, 24 Sep 2022 09:00:24 -0400
X-MC-Unique: -enxycm0OiKr4N9Mch6JlQ-1
Received: by mail-ot1-f71.google.com with SMTP id a11-20020a9d6e8b000000b00656442abf2eso1114563otr.21
        for <linux-fpga@vger.kernel.org>; Sat, 24 Sep 2022 06:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y6VBsZTlTPMMCZ9hB1ioUDpa1bHhT3SIX3HM69t18nU=;
        b=O28jLkZDvlFAl3+5u/HjId3YhudIBf9qWWWsBS/8pOESiz1xiCOMO4XhyeG2tIbzDE
         56YmCnEqZmvg67GD/RgtNdeM1+0VgLFbpfNVOU/5KKGDkms5PtHvmM4PUQBUm6uLnnm9
         F6CWeWBMq3tYq3cOzEsI1A1AxQbAlzl0G0noHhNbCoS7KapfU7iZvKReiFqeTcWYiJ6l
         DLXQJF4CJZHQFMC3WwtZnaQu6S74IPmPPv3Va9dsHhkJqq4UVtWeeUsfZn86ntMpDZNk
         wKM/ggg5yt1YdIkSCNSjYSYfTLaq0zoMAwhTsx5pFgUZKH5iLRLmj3vxbDTo8392a3zW
         Itvg==
X-Gm-Message-State: ACrzQf1/qwpdOylwpmwzNMk3tpttsKpZLBj0r3Tm8P9q5wbmvt5wK3pZ
        eA6hW+65nXNeuRwT7DNF//5ucujqgxmFBR1PoBD5QqT9xgUOVZSFVJok5jMxqJrH9YugDoea6QI
        vllKPAQ70xY0U5Vb63NhzYA==
X-Received: by 2002:a05:6808:2387:b0:350:28c5:335 with SMTP id bp7-20020a056808238700b0035028c50335mr10724241oib.18.1664024424114;
        Sat, 24 Sep 2022 06:00:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Plqizw1oIMnqphfxYycrv5+euohr0GRfxmVnkosA60BwHS3FdyHxgryWunmJR+0ojS5xXRw==
X-Received: by 2002:a05:6808:2387:b0:350:28c5:335 with SMTP id bp7-20020a056808238700b0035028c50335mr10724231oib.18.1664024423819;
        Sat, 24 Sep 2022 06:00:23 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id fo9-20020a0568709a0900b0012784cb563dsm6228176oab.22.2022.09.24.06.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 06:00:22 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] fpga: dfl: Move the DFH definitions
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianfei.zhang@intel.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Cc:     Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
 <20220923121745.129167-3-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <36342784-34c3-6a08-7cd4-eb185b61061a@redhat.com>
Date:   Sat, 24 Sep 2022 06:00:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220923121745.129167-3-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/23/22 5:17 AM, matthew.gerlach@linux.intel.com wrote:
> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
>
> Moving the DFH register offset and register definitions from
> drivers/fpga/dfl.h to include/linux/dfl.h. These definitions
> need to be accessed by dfl drivers that are outside of
> drivers/fpga.

This comment does not match what is done.

A move, a change in names and the introduction new defines.

I am not sure if moving these #defines is the best approach, the later 
use of the in the uart with FIELD_GET's i think should be wrapped as 
functions and these functions exported rather than the #defines.

So split this patch and justify why #defines are added to the user's 
includes.

Tom

>
> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2: remove extra space in commit
>      use uniform number of digits in constants
>      don't change copyright date because of removed content
> ---
>   drivers/fpga/dfl-afu-main.c |  4 ++--
>   drivers/fpga/dfl.c          |  2 +-
>   drivers/fpga/dfl.h          | 20 +-------------------
>   include/linux/dfl.h         | 33 ++++++++++++++++++++++++++++++++-
>   4 files changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 7f621e96d3b8..c26961ee33db 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -468,8 +468,8 @@ afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>   		return -EBUSY;
>   	}
>   
> -	guidl = readq(base + GUID_L);
> -	guidh = readq(base + GUID_H);
> +	guidl = readq(base + DFH_GUID_L);
> +	guidh = readq(base + DFH_GUID_H);
>   	mutex_unlock(&pdata->lock);
>   
>   	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b9aae85ba930..1132f3c10440 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1163,7 +1163,7 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>   	 * find and parse FIU's child AFU via its NEXT_AFU register.
>   	 * please note that only Port has valid NEXT_AFU pointer per spec.
>   	 */
> -	v = readq(binfo->ioaddr + NEXT_AFU);
> +	v = readq(binfo->ioaddr + DFH_NEXT_AFU);
>   
>   	offset = FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
>   	if (offset)
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 06cfcd5e84bb..e620fcb02b5a 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -17,6 +17,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/cdev.h>
>   #include <linux/delay.h>
> +#include <linux/dfl.h>
>   #include <linux/eventfd.h>
>   #include <linux/fs.h>
>   #include <linux/interrupt.h>
> @@ -53,28 +54,9 @@
>   #define PORT_FEATURE_ID_UINT		0x12
>   #define PORT_FEATURE_ID_STP		0x13
>   
> -/*
> - * Device Feature Header Register Set
> - *
> - * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> - * For AFUs, they have DFH + GUID as common header registers.
> - * For private features, they only have DFH register as common header.
> - */
> -#define DFH			0x0
> -#define GUID_L			0x8
> -#define GUID_H			0x10
> -#define NEXT_AFU		0x18
> -
> -#define DFH_SIZE		0x8
> -
>   /* Device Feature Header Register Bitfield */
> -#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
>   #define DFH_ID_FIU_FME		0
>   #define DFH_ID_FIU_PORT		1
> -#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
> -#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
> -#define DFH_EOL			BIT_ULL(40)		/* End of list */
> -#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
>   #define DFH_TYPE_AFU		1
>   #define DFH_TYPE_PRIVATE	3
>   #define DFH_TYPE_FIU		4
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 431636a0dc78..33d167c53b09 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -2,7 +2,7 @@
>   /*
>    * Header file for DFL driver and device API
>    *
> - * Copyright (C) 2020 Intel Corporation, Inc.
> + * Copyright (C) 2020-2022 Intel Corporation, Inc.
>    */
>   
>   #ifndef __LINUX_DFL_H
> @@ -11,6 +11,37 @@
>   #include <linux/device.h>
>   #include <linux/mod_devicetable.h>
>   
> +/*
> + * Device Feature Header Register Set
> + *
> + * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> + * For AFUs, they have DFH + GUID as common header registers.
> + * For private features, they only have DFH register as common header.
> + */
> +#define DFH			0x00
> +#define DFH_GUID_L		0x08
> +#define DFH_GUID_H		0x10
> +#define DFH_NEXT_AFU		0x18
> +
> +/*
> + * DFHv1 Register Offset definitons
> + * In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA
> + * as common header registers
> + */
> +#define DFHv1_CSR_ADDR		0x18  /* CSR Register start address */
> +#define DFHv1_CSR_SIZE_GRP	0x20  /* Size of Reg Block and Group/tag */
> +#define DFHv1_PARAM_HDR		0x28  /* Optional First Param header */
> +#define DFHv1_PARAM_DATA	0x08  /* Offset of Param data from Param header */
> +
> +#define DFH_SIZE		0x08
> +
> +/* Device Feature Header Register Bitfield */
> +#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
> +#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
> +#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
> +#define DFH_EOL			BIT_ULL(40)		/* End of list */
> +#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
> +
>   /**
>    * enum dfl_id_type - define the DFL FIU types
>    */

