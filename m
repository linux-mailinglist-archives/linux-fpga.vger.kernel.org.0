Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415C92B5AA4
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Nov 2020 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgKQIAl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 03:00:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:50417 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgKQIAl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 03:00:41 -0500
IronPort-SDR: oOknI+w/orenWMYyC6TK/zJXRmUSGj/a9GK1E0TL/M+YL5D3IShfk4dD+4j5Um33silnIr2oma
 nYkDzQgpJdqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="170097456"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="170097456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 00:00:38 -0800
IronPort-SDR: fPDJIgbHaDtqbWL88Txcfwc/Oli9apNyIF1Jz/tLTdGY/DwflH32uiAopyUKVI1Wu+XaiJb/P4
 D+FCUHiAnJNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="367783192"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Nov 2020 00:00:35 -0800
Date:   Tue, 17 Nov 2020 15:56:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net, yilun.xu@intel.com
Subject: Re: [PATCH 2/2] fpga: dfl: look for vendor specific capability
Message-ID: <20201117075626.GA14665@yilunxu-OptiPlex-7050>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
 <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Nov 16, 2020 at 05:25:52PM -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
> specific capability can be used to specify the start of a
> number of DFLs.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  Documentation/fpga/dfl.rst | 10 +++++
>  drivers/fpga/dfl-pci.c     | 88 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 0404fe6ffc74..c81ceb1e79e2 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -501,6 +501,16 @@ Developer only needs to provide a sub feature driver with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
> +Location of DFLs on PCI bus
> +===========================
> +The start of the DFL is assumed to be offset 0 of bar 0.
> +Alternatively, a vendor specific capability structure can be used to
> +specify the location of one or more DFLs.  Intel has reserved the
> +vendor specific id of 0x43 for this purpose.  The vendor specific
> +data begins with a 4 byte count of the number of DFLs followed 4 byte
> +Offset/BIR fields for each DFL. Bits 2:0 of Offset/BIR field indicates
> +the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
> +zero.
>  
>  Open discussion
>  ===============
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index b1b157b41942..5418e8bf2496 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -27,6 +27,13 @@
>  #define DRV_VERSION	"0.8"
>  #define DRV_NAME	"dfl-pci"
>  
> +#define PCI_VNDR_ID_DFLS 0x43
> +
> +#define PCI_VNDR_DFLS_CNT_OFFSET 8
> +#define PCI_VNDR_DFLS_RES_OFFSET 0x0c
> +
> +#define PCI_VND_DFLS_RES_BAR_MASK 0x7

We could define the mask by GENMASK().

Also another macro PCI_VND_DFLS_RES_OFFSET_MASK is needed.

> +
>  struct cci_drvdata {
>  	struct dfl_fpga_cdev *cdev;	/* container device */
>  };
> @@ -119,6 +126,82 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>  	return table;
>  }
>  
> +static int find_dfl_in_cfg(struct pci_dev *pcidev,
> +			   struct dfl_fpga_enum_info *info)
> +{
> +	u32 bar, offset, vndr_hdr, dfl_cnt, dfl_res;
> +	int dfl_res_off, i, voff = 0;
> +	resource_size_t start, len;
> +
> +	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
> +
> +		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
> +
> +		dev_dbg(&pcidev->dev,
> +			"vendor-specific capability id 0x%x, rev 0x%x len 0x%x\n",
> +			PCI_VNDR_HEADER_ID(vndr_hdr),
> +			PCI_VNDR_HEADER_REV(vndr_hdr),
> +			PCI_VNDR_HEADER_LEN(vndr_hdr));
> +
> +		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VNDR_ID_DFLS)
> +			break;
> +	}
> +
> +	if (!voff) {
> +		dev_dbg(&pcidev->dev, "%s no VSEC found\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT_OFFSET, &dfl_cnt);
> +	dev_info(&pcidev->dev, "dfl_cnt %d\n", dfl_cnt);

dev_dbg() is better?

> +	for (i = 0; i < dfl_cnt; i++) {
> +		dfl_res_off = voff + PCI_VNDR_DFLS_RES_OFFSET +
> +				      (i * sizeof(dfl_res));
> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
> +
> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
> +
> +		bar = dfl_res & PCI_VND_DFLS_RES_BAR_MASK;

FIELD_GET is better?

> +
> +		if (bar >= PCI_STD_NUM_BARS) {
> +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
> +				__func__, bar);
> +			return -EINVAL;
> +		}
> +
> +		len = pci_resource_len(pcidev, bar);
> +
> +		if (len == 0) {
> +			dev_err(&pcidev->dev, "%s unmapped bar number %d\n",
> +				__func__, bar);
> +			return -EINVAL;
> +		}
> +
> +		offset = dfl_res & ~PCI_VND_DFLS_RES_BAR_MASK;

ditto

> +
> +		if (offset >= len) {
> +			dev_err(&pcidev->dev, "%s bad offset %u >= %llu\n",
> +				__func__, offset, len);
> +			return -EINVAL;
> +		}
> +
> +		dev_info(&pcidev->dev, "%s BAR %d offset 0x%x\n", __func__, bar, offset);

dev_dbg()?

> +
> +		start = pci_resource_start(pcidev, bar) + offset;
> +		len -= offset;

With these code, I have the following assumption:

1. There is only one DFL in one bar, multiple DFLs requires multiple
bars.

2. The DFL region is from the "offset" to the end of the bar.

Are they correct? If yes maybe we should specify them clearly in Doc.

> +
> +		if (!PAGE_ALIGNED(start)) {
> +			dev_err(&pcidev->dev, "%s unaliged start 0x%llx\n",
> +				__func__, start);
> +			return -EINVAL;
> +		}
> +
> +		dfl_fpga_enum_info_add_dfl(info, start, len);

Do we need some region overlapping check in this func? So we could find
the HW problem (e.g. same bar num for multiple DFLs) in early stage.

> +	}
> +
> +	return 0;
> +}
> +
>  static int find_dfl_in_bar0(struct pci_dev *pcidev,
>  			    struct dfl_fpga_enum_info *info)
>  {
> @@ -221,7 +304,10 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  			goto irq_free_exit;
>  	}
>  
> -	ret = find_dfl_in_bar0(pcidev, info);
> +	ret = find_dfl_in_cfg(pcidev, info);
> +
> +	if (ret)
> +		ret = find_dfl_in_bar0(pcidev, info);

The patch is more than the relocation support for DFL. Actually it
introduced a different way of DFL finding.

Previously it starts at bar0 offset 0, find dfl fme first, then find
dfl port according to fme header registers. Now it enumerates every DFL
by PCIe VSEC.

Maybe we should add more description about the change and why.

Thanks,
Yilun

>  
>  	if (ret)
>  		goto irq_free_exit;
> -- 
> 2.25.2
