Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B164B71C7
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Feb 2022 17:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiBOQKG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 11:10:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbiBOQKF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 11:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C68939AD9C
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644941393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bcIcETvSlPf3OlzpU/yW8tdxkR8GvRw96tnUizl6xXs=;
        b=HuHtK//3ZQpIc4LsN4s0i/T77Idq6bkUVVYLwJCvObT/M3zez3wf33iwrMBbfOceDw7Cwm
        5OyxTJ9fvuexFS0QZTlniwhgC3PHGOuNmajJ+gKrM0EFJ8trL41Ufl+GH6WCOaH5E9qPYz
        cNk5kGIsyst0GKirX9GyT0T6LQJKeiw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-hYg4P1UjOdSAmF7lUQsPUQ-1; Tue, 15 Feb 2022 11:09:52 -0500
X-MC-Unique: hYg4P1UjOdSAmF7lUQsPUQ-1
Received: by mail-oi1-f199.google.com with SMTP id q10-20020a056808200a00b002cefffffe5eso4862417oiw.11
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 08:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bcIcETvSlPf3OlzpU/yW8tdxkR8GvRw96tnUizl6xXs=;
        b=uy5RanA7O5v6exEhfkmdY41TDZ6lKZMvp2WqiqxrKySjnv037r95YB98AiPU8Xch8A
         BO/t5cddztZVoIrCzYTU8xJWuanc7rJAtPRCOBe49oehC6mUPsEzMmOCn4xIweetsUb+
         oqhh585JYeUPE1UZQcGk6e1WlXVMSXhBehU7OiNUvCPiO4uDpTgegE9wS0nC4aS597l7
         mrHVBJX/I8l3gylbouc+CACG8Tan0HIGMcMOCYrKEWtoqnEADSbequi0RE/Abv6ky412
         BhJ2DRo1RwoQiqhcWsU5iSCE3dMnr7Z01K2Tu4syCejksKjzXwf5XA5kfttawYOq9nKS
         6luA==
X-Gm-Message-State: AOAM533ZZbtSFUD4GsRIZyxdfY11YzT58ty95CCgpwhV6mJrMwEaOs0o
        jESiy8pb0XxP7O370iuc63c5MF49LGyU6yZI+eF/KJKjKuja3c/nc7bT4OZ5gvxkutRfX/2sqUy
        G07uZjjS7XRFXiu8YmzHPKQ==
X-Received: by 2002:a05:6808:1647:: with SMTP id az7mr1864895oib.44.1644941391753;
        Tue, 15 Feb 2022 08:09:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwev/0bdfzhXzkz4NGi0esA4iqcPc0qa9laUz9bKob2D1v1DR8Wy/5YIceKRy1HZKCBLBb8Sw==
X-Received: by 2002:a05:6808:1647:: with SMTP id az7mr1864879oib.44.1644941391490;
        Tue, 15 Feb 2022 08:09:51 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m14sm15080864ooj.22.2022.02.15.08.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:09:50 -0800 (PST)
Subject: Re: [PATCH v1 6/7] fpga: dfl: Handle dfl's starting with AFU
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-7-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <773f3851-f2d3-36e6-afab-a3cf73644b87@redhat.com>
Date:   Tue, 15 Feb 2022 08:09:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-7-tianfei.zhang@intel.com>
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


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Allow for a Device Feature List (DFL) to start with
> a Device Feature Header (DFH) of type Accelerator Function Unit (AFU)
> by doing nothing.  This allows for PCIe VFs to be created.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl-pci.c |  7 ++++++-
>   drivers/fpga/dfl.c     | 23 ++++++++++++++---------
>   2 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 8abd9b408403..83b604d6dbe6 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -277,7 +277,12 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>   
>   		dfl_fpga_enum_info_add_dfl(info, start, len);
>   	} else {
> -		ret = -ENODEV;
> +		v = readq(base + DFH);

This isn't likely to work on older cards.

Is there there a version to key off of ?

Tom

> +		if (FIELD_GET(DFH_TYPE, v) != DFH_TYPE_AFU) {
> +			dev_info(&pcidev->dev, "Unknown feature type 0x%llx id 0x%llx\n",
> +				 FIELD_GET(DFH_TYPE, v), FIELD_GET(DFH_ID, v));
> +			ret = -ENODEV;
> +		}
>   	}
>   
>   	/* release I/O mappings for next step enumeration */
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index a5263ac258c5..25bd24a4cca0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -900,9 +900,11 @@ static void build_info_free(struct build_feature_devs_info *binfo)
>   		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
>   			    binfo->feature_dev->id);
>   
> -		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> -			list_del(&finfo->node);
> -			kfree(finfo);
> +		if (!list_empty(&binfo->sub_features)) {
> +			list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> +				list_del(&finfo->node);
> +				kfree(finfo);
> +			}
>   		}
>   	}
>   
> @@ -1437,6 +1439,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>   
>   	binfo->dev = info->dev;
>   	binfo->cdev = cdev;
> +	INIT_LIST_HEAD(&binfo->sub_features);
>   
>   	binfo->nr_irqs = info->nr_irqs;
>   	if (info->nr_irqs)
> @@ -1446,12 +1449,14 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>   	 * start enumeration for all feature devices based on Device Feature
>   	 * Lists.
>   	 */
> -	list_for_each_entry(dfl, &info->dfls, node) {
> -		ret = parse_feature_list(binfo, dfl->start, dfl->len);
> -		if (ret) {
> -			remove_feature_devs(cdev);
> -			build_info_free(binfo);
> -			goto unregister_region_exit;
> +	if (!list_empty(&info->dfls)) {
> +		list_for_each_entry(dfl, &info->dfls, node) {
> +			ret = parse_feature_list(binfo, dfl->start, dfl->len);
> +			if (ret) {
> +				remove_feature_devs(cdev);
> +				build_info_free(binfo);
> +				goto unregister_region_exit;
> +			}
>   		}
>   	}
>   

