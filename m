Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF53946F9C1
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Dec 2021 05:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhLJEL1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Dec 2021 23:11:27 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:42550 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhLJEL1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 9 Dec 2021 23:11:27 -0500
Received: by mail-pl1-f178.google.com with SMTP id u17so5421332plg.9;
        Thu, 09 Dec 2021 20:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHZDywHB96LHGBKSn/H1Fye/3o+2IVeKY/TZndRFPj0=;
        b=PUR2fyRTVRm/d+dwrNEpM5gt4zPPoXSIbopO/hJEl+bPKNL9rNdlL5JlILmtanZeDg
         k8ithkFqwzKmoOLBsRhgGsyB91hQ+/Cx9vLzSTTEZzkMY9BHroSqltQFlcuPCIDfIhDm
         sRnhxcAaP/5Hhpo5pkG9PwpBbtvU4aeCRaBi2+kyuSqMKPV90MQmM8+I1OuHPKm5AMb8
         Lk63KEjCf8J043XcgLUhFrse6lE9lVHkOvuaCJQvq03UNWfxCOSSBeWcdVw1+p4Ls1ra
         nSXVxu3OmX+tVki59rxsyG+uGMfR6dbRj32IYfY9Ka5DxHK3Sk8xiGUkFR4WtYmrIB7X
         AEWA==
X-Gm-Message-State: AOAM533Eiby/pQsiFANdsVcwl7Ye8MxdDxNIQ9ZmSKWLIpnrUy95vSoF
        05K1pVocTu9jrI6LKxyHyZc=
X-Google-Smtp-Source: ABdhPJywzPlO0mMt2jybcmA42zRJQ6LyvAzLdsoxh+/G/hLltGQeVb6WjWRGy9q98O94sKLE2b/t9A==
X-Received: by 2002:a17:90b:3718:: with SMTP id mg24mr20720093pjb.109.1639109272815;
        Thu, 09 Dec 2021 20:07:52 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece0:aab:34ff:52ca:a7a5])
        by smtp.gmail.com with ESMTPSA id rm1sm11156742pjb.3.2021.12.09.20.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 20:07:52 -0800 (PST)
Date:   Thu, 9 Dec 2021 20:07:51 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, rdunlap@infradead.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next RESEND] fpga: region: fix kernel-doc
Message-ID: <YbLSlzRdl2nkz85g@epycbox.lan>
References: <1638512353-103822-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638512353-103822-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Dec 03, 2021 at 02:19:13PM +0800, Yang Li wrote:
> Fix function name in of-fpga-region.c kernel-doc comment
> to remove a warning found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
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
> -- 
> 1.8.3.1
> 
Applied to for-next,

thanks
