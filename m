Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2849444FCBE
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Nov 2021 02:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhKOBfL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 14 Nov 2021 20:35:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:52707 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhKOBfK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 14 Nov 2021 20:35:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220249682"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="220249682"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 17:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="453838742"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2021 17:32:14 -0800
Date:   Mon, 15 Nov 2021 09:25:16 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: pci: generalize find_dfls_by_vsec()
Message-ID: <20211115012516.GA288162@yilunxu-OptiPlex-7050>
References: <20211113221252.4062704-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113221252.4062704-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Nov 13, 2021 at 02:12:52PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> find_dfls_by_vsec() is a general dfl function.
> Although dfl has multiple vendors, only Intel is supported.
> Move vsec and vendor id to an array variable.
> Other vendors can append the array to enable their support.

As Hao mentioned, DVSEC could be a better solution if DFL should be
present in components by a variety of vendors. This is not finally
determined, but I think we should not add new features for VSEC now.

Thanks,
Yilun

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/dfl-pci.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4d68719e608f..9dc0815c8274 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -136,19 +136,36 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>  	return table;
>  }
>  
> -static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
> +struct dfl_vsec {
> +	u16 vendor;
> +	u16 id;
> +};
> +
> +static struct dfl_vsec vsecs[] = {
> +	{ PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS },
> +};
> +
> +static int find_dfls_by_vsec(struct pci_dev *pcidev,
> +			     struct dfl_fpga_enum_info *info)
>  {
>  	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
>  	int dfl_res_off, i, bars, voff = 0;
>  	resource_size_t start, len;
>  
> -	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
> -		vndr_hdr = 0;
> -		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
> +	for (i = 0; i < ARRAY_SIZE(vsecs); i++) {
> +		if (pcidev->vendor != vsecs[i].vendor)
> +			continue;
> +
> +		while ((voff =
> +			pci_find_next_ext_capability(pcidev, voff,
> +						     PCI_EXT_CAP_ID_VNDR))) {
> +			vndr_hdr = 0;
> +			pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER,
> +					      &vndr_hdr);
>  
> -		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
> -		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
> -			break;
> +			if (PCI_VNDR_HEADER_ID(vndr_hdr) == vsecs[i].id)
> +				break;
> +		}
>  	}
>  
>  	if (!voff) {
> -- 
> 2.26.3
