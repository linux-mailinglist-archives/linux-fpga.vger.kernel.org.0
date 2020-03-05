Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98B179E20
	for <lists+linux-fpga@lfdr.de>; Thu,  5 Mar 2020 04:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgCEDJb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Mar 2020 22:09:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39426 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgCEDJb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Mar 2020 22:09:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id l7so2032552pff.6
        for <linux-fpga@vger.kernel.org>; Wed, 04 Mar 2020 19:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hErx3nzWjf21G04/W2tdF4WKTCyHLZGEHQZBn4b4sG8=;
        b=g2vzKWY55M5yVJyxNRkNFbekd8+ZGwYkTT7EnxgNYLICYvov6jVgPwk4ZW/30nR50h
         BO9pVGEwgJYQE4xTLvGAxf6rmrazhOhOQHuWzWwjNfJL2xayf581RZ3UYx4xFSooaQQX
         B0TdHYSOwroPDAYzIUry78CKb4g76sYjPjIxs4C3q+PJml3iHz+1BAAXAKqyrttvrKfX
         aJJgo6+y58JvY+dzlQl/ZL99CdYgtuqVDDqx06RXNYKM6WJGM0FnOsE0T6reMUL5PXVM
         VWwjenQkExj5b9DTfvKtEzpL3VNneALB8EDosJ0mZwn9qLeKgpI4trNFn6wQDOQZJ66Z
         MMCg==
X-Gm-Message-State: ANhLgQ38WC7CziXgyIvYHpXK4/UON5uW9r6jMLJUEaUwWe5HzXemwVat
        28i2QDSKRwEBvDc9CByjuEo=
X-Google-Smtp-Source: ADFU+vt9gUQtVKut9CVQgdZNlPp4N4KbABPC0qxG50D/jC011cz76jwoLn/UHo2Nifm2gKt5q/28Bg==
X-Received: by 2002:a63:3207:: with SMTP id y7mr5724422pgy.344.1583377768628;
        Wed, 04 Mar 2020 19:09:28 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id y23sm10466134pfb.76.2020.03.04.19.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 19:09:27 -0800 (PST)
Date:   Wed, 4 Mar 2020 19:09:26 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Dominic Chen <d.c.ddcc@gmail.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
Message-ID: <20200305030926.GA4253@epycbox.lan>
References: <20200304133847.103881-1-d.c.ddcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304133847.103881-1-d.c.ddcc@gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Mar 04, 2020 at 08:38:47AM -0500, Dominic Chen wrote:
> Allow debug access to memory-mapped regions using e.g. gdb.
> 
> Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 02baa6a227c0..ec9dbd3d51b8 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	return -EINVAL;
>  }
>  
> +static const struct vm_operations_struct afu_vma_ops = {
> +#ifdef CONFIG_HAVE_IOREMAP_PROT
> +	.access = generic_access_phys,
> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
I remember there were issues in the past with modules and this, are
those resolved?

> +};
> +
>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct platform_device *pdev = filp->private_data;
> @@ -488,6 +494,9 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>  		return -EPERM;
>  
> +	// Support debug access to the mapping

Please use kernel style comments /* */ checkpatch.pl should catch this.
> +	vma->vm_ops = &afu_vma_ops;
> +
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	return remap_pfn_range(vma, vma->vm_start,
> -- 
> 2.17.1
> 

Thanks,
Moritz
