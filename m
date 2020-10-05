Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B244E284072
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 22:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgJEUNk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 16:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729424AbgJEUNj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 16:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601928818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BvD0x1LGXOPbfpL7zHAR3R8a6UNGvp1JCYrSTWMOaE=;
        b=LU8DQhofLh/8sv+KNTsYsZdoho5PGdjKaBdYKtOLtq/krhFb719zkguTV/VQ0umzzLMJH3
        O+uXGY/NfSajwlzbmCUMxJISUGtj51jkhLIuuipdtZqacJTRxmL0F5kPjl9VZBOUWtCF+v
        X/rBtSU0NJW8pNp64SsrbvZynZptIs4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-MPH1rcaTOeiaTpU_eJE-iA-1; Mon, 05 Oct 2020 16:13:37 -0400
X-MC-Unique: MPH1rcaTOeiaTpU_eJE-iA-1
Received: by mail-qk1-f197.google.com with SMTP id 196so7574452qkn.6
        for <linux-fpga@vger.kernel.org>; Mon, 05 Oct 2020 13:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5BvD0x1LGXOPbfpL7zHAR3R8a6UNGvp1JCYrSTWMOaE=;
        b=BdQ5wVt26UUSWTLV4qU/BFWBOKZdbrvVjzO8PcuUpwUFy6NrVLPLjqGCnOPPrTq9Me
         neDqHWSYmtCp0n5FrLFct/MG5SYGT+yOUUj0LDZy7ynUStJQgsEFskHP/w/yJA7XNV12
         PVlaDtMn5xj9/DYvuR2c6Uh3OekDz9yNcbb/yYPRZ51/ZEUfTPxuZ4b9Ee9dwrbiQ76u
         PS1+hz3MvXp9qNRK3qJsZUwltFwtYwuFjgCSuapw2LHc4HHR8HZfDM0tzomPbcMmFaHZ
         4EgXiAzr0IHoYImpNKys5f5fJUk6kHZ792NJ8xjyEXKWCOAvjL6GT8ex8/H9CLlWJ/Tq
         nyfA==
X-Gm-Message-State: AOAM5302fla9D1gt9az3W1UQ3SGb07jfV5xmWs0l4/UdO+VOcCIxjix8
        nL6qH3uF9qxY9i9p5aulefMNjsBcQ8NIdC6XR2n4ij1RInVg1exIx3WxvH+4o/1Vl4YPkuJX3jF
        KxxIWT1e/qbXgO1pxr5Ji2g==
X-Received: by 2002:aed:2489:: with SMTP id t9mr1658733qtc.358.1601928816606;
        Mon, 05 Oct 2020 13:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIkeczNA3zabL1KGQ5svsN/WDxZgNZb02q2MIfAkohl7n+auh0JUVGTFSaFYKRlVl3FU0Mfw==
X-Received: by 2002:aed:2489:: with SMTP id t9mr1658711qtc.358.1601928816372;
        Mon, 05 Oct 2020 13:13:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z69sm920748qkb.7.2020.10.05.13.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 13:13:35 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] fpga: fpga-mgr: altera-pr-ip: Simplify
 registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201005173735.162408-1-mdf@kernel.org>
 <20201005173735.162408-11-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3c9f78f1-a4b0-c1b8-61a1-93e9b7b57999@redhat.com>
Date:   Mon, 5 Oct 2020 13:13:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201005173735.162408-11-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/5/20 10:37 AM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.

Should change old commit message to something about removing symbol

alt_pr_platform_remove

Otherwise fine.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Changes from v1:
> - Removed part that removes unused symbol
>
> ---
>  drivers/fpga/altera-pr-ip-core-plat.c | 10 ----------
>  drivers/fpga/altera-pr-ip-core.c      |  4 +---
>  2 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
> index 99b9cc0e70f0..b008a6b8d2d3 100644
> --- a/drivers/fpga/altera-pr-ip-core-plat.c
> +++ b/drivers/fpga/altera-pr-ip-core-plat.c
> @@ -28,15 +28,6 @@ static int alt_pr_platform_probe(struct platform_device *pdev)
>  	return alt_pr_register(dev, reg_base);
>  }
>  
> -static int alt_pr_platform_remove(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -
> -	alt_pr_unregister(dev);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id alt_pr_of_match[] = {
>  	{ .compatible = "altr,a10-pr-ip", },
>  	{},
> @@ -46,7 +37,6 @@ MODULE_DEVICE_TABLE(of, alt_pr_of_match);
>  
>  static struct platform_driver alt_pr_platform_driver = {
>  	.probe = alt_pr_platform_probe,
> -	.remove = alt_pr_platform_remove,
>  	.driver = {
>  		.name	= "alt_a10_pr_ip",
>  		.of_match_table = alt_pr_of_match,
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index 2cf25fd5e897..5b130c4d9882 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -195,9 +195,7 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>  	if (!mgr)
>  		return -ENOMEM;
>  
> -	dev_set_drvdata(dev, mgr);
> -
> -	return fpga_mgr_register(mgr);
> +	return devm_fpga_mgr_register(dev, mgr);
>  }
>  EXPORT_SYMBOL_GPL(alt_pr_register);
>  

