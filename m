Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF72D178F0F
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Mar 2020 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbgCDK7f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Mar 2020 05:59:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:61097 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387762AbgCDK7f (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 4 Mar 2020 05:59:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 02:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="319790396"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga001.jf.intel.com with ESMTP; 04 Mar 2020 02:59:34 -0800
Date:   Wed, 4 Mar 2020 18:38:29 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Dominic Chen <d.c.ddcc@gmail.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [Resend] [PATCH] fpga: support debug access to memory-mapped afu
 regions
Message-ID: <20200304103829.GA14731@hao-dev>
References: <20200304061406.98865-1-d.c.ddcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304061406.98865-1-d.c.ddcc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Dominic,

Thanks a lot for this patch. Please see my comments inline.

On Wed, Mar 04, 2020 at 01:14:06AM -0500, Dominic Chen wrote:
> Allow debug access to memory-mapped regions using e.g. gdb.

Do you mind improving the title to something like

   "fpga: dfl: afu: ...."

> 
> Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 02baa6a227c0..38983f9dde98 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	return -EINVAL;
>  }
>  
> +#ifdef CONFIG_HAVE_IOREMAP_PROT
> +const struct vm_operations_struct afu_vma_ops = {

let's add "static" for afu_vma_ops here.

> +	.access = generic_access_phys,
> +};
> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> +

What about

  static const struct vm_operations_struct afu_vma_ops = {
  #ifdef CONFIG_HAVE_IOREMAP_PROT
  	.access = generic_access_phys,
  #endif
  };

Then we just need one line below.

  vma->vm_ops = &afu_vma_ops;


Thanks
Hao

>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct platform_device *pdev = filp->private_data;
> @@ -488,6 +494,11 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>  		return -EPERM;
>  
> +	// Support debug access to the mapping
> +#ifdef CONFIG_HAVE_IOREMAP_PROT
> +	vma->vm_ops = &afu_vma_ops;
> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> +
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	return remap_pfn_range(vma, vma->vm_start,
> -- 
> 2.17.1
