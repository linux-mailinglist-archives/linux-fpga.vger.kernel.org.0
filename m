Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76C1DF418
	for <lists+linux-fpga@lfdr.de>; Sat, 23 May 2020 03:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbgEWBwf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 May 2020 21:52:35 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1583 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgEWBwf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 22 May 2020 21:52:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec881920000>; Fri, 22 May 2020 18:51:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 18:52:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 May 2020 18:52:34 -0700
Received: from [10.2.52.1] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 23 May
 2020 01:52:34 +0000
Subject: Re: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
Date:   Fri, 22 May 2020 18:52:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519201449.3136033-1-jhubbard@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590198674; bh=H0H4bnfmZctAlDk5DLSVcRpTFSw3qTsKUJh0ZTZurr0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=X2SnSaT7Sre/ZYhMC6y2b6BWRFVOldzacF6lVvqQ6bEN1JPnOQM4Pr8en2VFy77DJ
         bu48Qgw92YsFEu3twD2Zlq5M1hRCuvLBcu8WmT+mPDWqVkfK/lYqqp5hjG16VzwFRt
         9aXkfPEVxjvv//sTJZ5f3RQCkNiRMKhbunRzMyNub4PD4hzEGKUAGGDiOcQq3hSKAG
         LMffZkVrCKRB4ERw+wSd3szU5l07qmea/t20Bolj5+p2z/LqECpvcEPsRwLcO19voP
         ACBwxvYV0Yrz3KrnfmlljYgoOyFdwSVOH39ctMSHlaqCDqeR75vouuLaLMKn+nHHFD
         GZPSf0WA92Rcg==
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2020-05-19 13:14, John Hubbard wrote:
> This code was using get_user_pages_fast(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages_fast() + put_page() calls to
> pin_user_pages_fast() + unpin_user_pages() calls.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>      https://lwn.net/Articles/807108/
> 
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>


Hi Moritz and FPGA developers,

Is this OK? And if so, is it going into your git tree? Or should I
send it up through a different tree? (I'm new to the FPGA development
model).


thanks,
-- 
John Hubbard
NVIDIA



> ---
> 
> Hi,
> 
> Changes since v1:
> 
> Changed the label from "put_pages", to "unpin_pages".
> 
> thanks,
> John Hubbard
> NVIDIA
>   
>   drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 62f924489db5..a31dd3a7e581 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -16,15 +16,6 @@
>   
>   #include "dfl-afu.h"
>   
> -static void put_all_pages(struct page **pages, int npages)
> -{
> -	int i;
> -
> -	for (i = 0; i < npages; i++)
> -		if (pages[i])
> -			put_page(pages[i]);
> -}
> -
>   void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
>   {
>   	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> @@ -57,11 +48,11 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>   		goto unlock_vm;
>   	}
>   
> -	pinned = get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
> +	pinned = pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
>   				     region->pages);
>   	if (pinned < 0) {
>   		ret = pinned;
> -		goto put_pages;
> +		goto unpin_pages;
>   	} else if (pinned != npages) {
>   		ret = -EFAULT;
>   		goto free_pages;
> @@ -71,8 +62,8 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>   
>   	return 0;
>   
> -put_pages:
> -	put_all_pages(region->pages, pinned);
> +unpin_pages:
> +	unpin_user_pages(region->pages, pinned);
>   free_pages:
>   	kfree(region->pages);
>   unlock_vm:
> @@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
>   	long npages = region->length >> PAGE_SHIFT;
>   	struct device *dev = &pdata->dev->dev;
>   
> -	put_all_pages(region->pages, npages);
> +	unpin_user_pages(region->pages, npages);
>   	kfree(region->pages);
>   	account_locked_vm(current->mm, npages, false);
>   
> 

