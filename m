Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950914671D8
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Dec 2021 07:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378558AbhLCG2B (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 01:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhLCG2A (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Dec 2021 01:28:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78774C06174A;
        Thu,  2 Dec 2021 22:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=sjVHRzDxmCkKFroaUE49hF4BVTuosSP0o16uR44Du5M=; b=m7fNb4hsV/5zGnq41LwuZScRaW
        YOLXhD5RjXHh/TEDDcjO4SWhcsqYD78BT6aWFAvP7r42HaG/dO1C/zFuEVLjPONGGNoQiVgutxOSn
        LjZyYD7wnFxYlvn49Nc6KmZq5QmiCuGiXvCHYxS7JwDQeGxlO/NbwoZTc98SAhhRXD9UYT4cNbN0O
        e2m3tNC8QsYgcVWZwrO6lcRVKE1gxHqkGuC+W5ZbaplNSsxeKZvs95mGNyoWR5LXgzRCa5Y+T8+o1
        BIWXn3tBU2WEJXZ2bdRewk8UQJeTuwt9H4P42pIj7zFVgjTyZGjuX0pqXbnxyd3/3juLWuHlRk0tF
        k8p9Pa1A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt1zb-001wkf-CC; Fri, 03 Dec 2021 06:24:23 +0000
Message-ID: <d0ca0f04-1a1f-ee63-5d0b-b32dc17487db@infradead.org>
Date:   Thu, 2 Dec 2021 22:24:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next RESEND] fpga: region: fix kernel-doc
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, mdf@kernel.org
Cc:     hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1638512353-103822-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1638512353-103822-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 12/2/21 22:19, Yang Li wrote:
> Fix function name in of-fpga-region.c kernel-doc comment
> to remove a warning found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> drivers/fpga/of-fpga-region.c:451: warning: expecting prototype for
> fpga_region_init(). Prototype was for of_fpga_region_init() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/fpga/of-fpga-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 9c662db..50b8305 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -444,7 +444,7 @@ static int of_fpga_region_remove(struct platform_device *pdev)
>  };
>  
>  /**
> - * fpga_region_init - init function for fpga_region class
> + * of_fpga_region_init - init function for fpga_region class
>   * Creates the fpga_region class and registers a reconfig notifier.
>   */
>  static int __init of_fpga_region_init(void)
> 

-- 
~Randy
