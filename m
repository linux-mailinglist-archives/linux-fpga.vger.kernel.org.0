Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF7817DA03
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Mar 2020 08:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCIHtW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Mar 2020 03:49:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:37955 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIHtW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 9 Mar 2020 03:49:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 00:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="276415538"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2020 00:49:20 -0700
Date:   Mon, 9 Mar 2020 15:28:10 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Dominic Chen <d.c.ddcc@gmail.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v3] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
Message-ID: <20200309072810.GA852@hao-dev>
References: <20200305033310.117030-1-d.c.ddcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305033310.117030-1-d.c.ddcc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

To me, it's very clear for #ifdef - #end. So looks like this
/* CONFIG_HAVE_IOREMAP_PROT */ comments is not needed.

Could you please remove it? 

Then

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

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
