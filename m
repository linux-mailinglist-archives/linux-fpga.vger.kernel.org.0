Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E332F46706C
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Dec 2021 04:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhLCDF7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 Dec 2021 22:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350655AbhLCDF6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 Dec 2021 22:05:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D786C06174A;
        Thu,  2 Dec 2021 19:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=QcwFxPn9nE8J9gnpBF33bqWSPwkn/afutb7ps1YKtnY=; b=pcnJRkhlBE9fK3RH27u57l3bOr
        Vftkv38HJYFmL4uaosFQnONcmimpmYeoskhOGX9fqUkCG6QPN/YCTtOg+eNmr6TLtN2VQwTZELfSr
        Oi2d+JWYJCXE1KHFINcz7fUULWvpamiNplui4ff2QHOe+5d6D1GcFRYtbGYRO+i2l+q9GYuCFEep+
        F0eU1DMNi3G4N0DQhi1qRDwfow02y7uJDNFHl0W/sfJEOzBj6ro/19yx+rkabY+ocHvYQboiMVYvl
        IXnMjWFAC4H2iSwUz2A9TuUnD+rlxfOhy679QI9AwGA1OTGSLU7SSEmBlME4cFfPBolFWaClEnpqx
        K3u4oCLg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msyq5-006jXW-NI; Fri, 03 Dec 2021 03:02:22 +0000
Message-ID: <dd215074-38bc-5011-3e52-78858e9e2ea6@infradead.org>
Date:   Thu, 2 Dec 2021 19:02:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next] fpga: region: fix kernel-doc
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, mdf@kernel.org
Cc:     hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <1638499487-74388-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1638499487-74388-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi--

On 12/2/21 18:44, Yang Li wrote:
> Fix function name in of-fpga-region.c kernel-doc comment
> to remove a warning found by clang(make W=1 LLVM=1).

The patch below looks good, but the commit message about
"found by clang" is not correct. Using 'make W=1' causes
scripts/kernel-doc to run, and this warning message is from kernel-doc,
not from clang.

> drivers/fpga/of-fpga-region.c:451: warning: expecting prototype for
> fpga_region_init(). Prototype was for of_fpga_region_init() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
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

thanks.
-- 
~Randy
