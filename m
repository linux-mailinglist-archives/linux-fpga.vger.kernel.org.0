Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560E318E42C
	for <lists+linux-fpga@lfdr.de>; Sat, 21 Mar 2020 21:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCUUPj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 21 Mar 2020 16:15:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39927 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCUUPj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 21 Mar 2020 16:15:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so5230351pfn.6
        for <linux-fpga@vger.kernel.org>; Sat, 21 Mar 2020 13:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PHiqQPtpGNP4KNWRUz2lkIAcgJ/TjQ7GhqsouuwbTEo=;
        b=hqRfOGOSdync715tsGSsmkzW7bTjq6hC44DMO4dOwq1obDTM9Sux3Iu3A+bNS8nnA5
         h1I71N6NSgOQrGoWCjlgpwiMr6pD23kbjBBx+/PJIqYOI2+muEZ8ZC5Cd4zFtdSDslwo
         rCpAsmTwGXt2qxOl3SsAL56ZYtObdoovei4WbqsgL3LVWqwvNnu4bODd+q0NCR6nhLmi
         FNDHXNxkzmVVfOz9CpoTX4IhXav0mj8KRHU4n6rGeml7VY511NBNF3hX0FAd4LqR8nyr
         S4mnftC/Qbh6ZbnvnkIIqYW4Y4Dd39/JYOh2xrdFyfyyRhxp1w6CBXkN3kU4G5i3l0nd
         nvyg==
X-Gm-Message-State: ANhLgQ2EW6VtXf0oeHycPz0jcnnVaTgfrqYpylZv+7FB1D+BbUXc0moX
        7ukrND8zYQPwFErHYW6+7BE=
X-Google-Smtp-Source: ADFU+vtIPlbpqsC6bHkMEhDTH8MP8I6MUBcL1mRvfDdcDwOKLsC9sSgYhJx2tK8EQ7g/B2igGaZ2pg==
X-Received: by 2002:a62:7cc9:: with SMTP id x192mr17496639pfc.176.1584821738676;
        Sat, 21 Mar 2020 13:15:38 -0700 (PDT)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id x3sm8796691pfp.167.2020.03.21.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 13:15:37 -0700 (PDT)
Date:   Sat, 21 Mar 2020 13:15:36 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Dominic Chen <d.c.ddcc@gmail.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v3] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
Message-ID: <20200321201536.GA7275@epycbox.lan>
References: <20200305033310.117030-1-d.c.ddcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305033310.117030-1-d.c.ddcc@gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Mar 04, 2020 at 10:33:10PM -0500, Dominic Chen wrote:
> Allow debug access to memory-mapped regions using e.g. gdb.
> 
> Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 02baa6a227c0..8fa1666b5b20 100644
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
> +};
> +
>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct platform_device *pdev = filp->private_data;
> @@ -488,6 +494,9 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>  		return -EPERM;
>  
> +	/* Support debug access to the mapping */
> +	vma->vm_ops = &afu_vma_ops;
> +
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	return remap_pfn_range(vma, vma->vm_start,
> -- 
> 2.17.1
> 

Applied to for-next.

Thanks
