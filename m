Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21E72BC2F5
	for <lists+linux-fpga@lfdr.de>; Sun, 22 Nov 2020 02:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKVBS5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 21 Nov 2020 20:18:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37746 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgKVBS5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 21 Nov 2020 20:18:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id c66so11556622pfa.4;
        Sat, 21 Nov 2020 17:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6F+q0z8uoO6RqleJlDf5TYXGbSMvGrDWob+nbFawBEo=;
        b=g5B16rLfqCoMeFMwBOi46BdKBWmN8TG7XQiGFxguaPzCZZTxsyGsvNwNp1Bck2vNm1
         kkXyle2UWEsu+iIYbipG5ey68kB3O0YP/yhvukVdMtRHlsw3tnc2Uqy0Zj5Qo7a0XeDV
         ho/6JcncaVmMqVgHk1/xsX7Vu3AgeS1v1Tht3AMgE5SrJtrWH3Cd3GhJvsSqx6OM8b+Z
         GvROeG3h3YjmFiJWuSazSzzzyMwM/CoEVmUtnZlDT/ecIDBB+21VD1P/UzYk4DwFZroB
         jGM63acyn376ZBUyeRMSNohxu49PGiRIIH6kbMMMr7sy1nK2MC4UiGkZENeAf7l9TA5q
         0doQ==
X-Gm-Message-State: AOAM533AiSoTRmyUs0uhH2smFbitqNlVEur3DDJWC1Ai0p/N85Rtr4Sd
        6KehJ7QJwAlqLeC8H7uLaSw=
X-Google-Smtp-Source: ABdhPJwklL6vq/X+TnRlZn7wA81MLqwThTgnCyG6ifQwxq1QJYAta3xikNEDXXuOIvC0WaEKj5X8Mw==
X-Received: by 2002:a62:a11a:0:b029:18a:df9e:f537 with SMTP id b26-20020a62a11a0000b029018adf9ef537mr19083044pff.29.1606007936315;
        Sat, 21 Nov 2020 17:18:56 -0800 (PST)
Received: from localhost (c-73-235-149-126.hsd1.ca.comcast.net. [73.235.149.126])
        by smtp.gmail.com with ESMTPSA id v63sm7794669pfb.217.2020.11.21.17.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 17:18:55 -0800 (PST)
Date:   Sat, 21 Nov 2020 17:18:54 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH v2 2/2] fpga: dfl: look for vendor specific capability
Message-ID: <X7m8frDb8I+Q3zbt@archbook>
References: <20201118190151.365564-1-matthew.gerlach@linux.intel.com>
 <20201118190151.365564-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118190151.365564-3-matthew.gerlach@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Matthew,

On Wed, Nov 18, 2020 at 11:01:51AM -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
> specific capability can be used to specify the start of a
> number of DFLs.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2: Update documentation for clarity.
>     Clean up  macro names.
>     Use GENMASK.
>     Removed spurious blank lines.
>     Changed some calls from dev_info to dev_dbg.
>     Specifically check for VSEC not found, -ENODEV.
>     Ensure correct pci vendor id.
>     Remove check for page alignment.
>     Rename find_dfl_in_cfg to find_dfls_by_vsec.
>     Initialize target memory of pci_read_config_dword to invalid values before use.
> ---
>  Documentation/fpga/dfl.rst | 13 ++++++
>  drivers/fpga/dfl-pci.c     | 87 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 0404fe6ffc74..37016ff35a90 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -501,6 +501,19 @@ Developer only needs to provide a sub feature driver with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
> +Location of DFLs on PCI Device
> +===========================

Maybe start with: "There are two ways of locating the DFLs"
> +The start of the first DFL is assumed to be offset 0 of bar 0.
> +If the first node of the DFL is an FME, then further DFLs
> +in the port(s) are specified in FME header registers.
> +Alternatively, a vendor specific capability structure can be used to
> +specify the location of all the DFLs on the device, providing flexibility
> +for the type of starting node in the DFL.  Intel has reserved the
> +VSEC ID of 0x43 for this purpose.  The vendor specific
> +data begins with a 4 byte vendor specific register for the number of DFLs followed 4 byte
> +Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
> +indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
> +zero.
It's nice to have details, thanks! Nit: This could be a table maybe?
>  
>  Open discussion
>  ===============
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index b27fae045536..3a6807e3e10c 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -27,6 +27,14 @@
>  #define DRV_VERSION	"0.8"
>  #define DRV_NAME	"dfl-pci"
>  
> +#define PCI_VSEC_ID_INTEL_DFLS 0x43
> +
> +#define PCI_VNDR_DFLS_CNT 8
> +#define PCI_VNDR_DFLS_RES 0x0c
> +
> +#define PCI_VNDR_DFLS_RES_BAR_MASK GENMASK(2, 0)
> +#define PCI_VNDR_DFLS_RES_OFF_MASK GENMASK(31, 3)
> +
>  struct cci_drvdata {
>  	struct dfl_fpga_cdev *cdev;	/* container device */
>  };
> @@ -119,8 +127,80 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>  	return table;
>  }
>  
> +static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
> +{
> +	u32 bar, offset, vndr_hdr, dfl_cnt, dfl_res;
> +	int dfl_res_off, i, voff = 0;
> +	resource_size_t start, len;
> +
> +	if (pcidev->vendor != PCI_VENDOR_ID_INTEL)
> +		return -ENODEV;
> +
> +	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
> +		vndr_hdr = 0;
> +		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
Are there concerns around those failing?
> +
> +		dev_dbg(&pcidev->dev,
> +			"vendor-specific capability id 0x%x, rev 0x%x len 0x%x\n",
> +			PCI_VNDR_HEADER_ID(vndr_hdr),
> +			PCI_VNDR_HEADER_REV(vndr_hdr),
> +			PCI_VNDR_HEADER_LEN(vndr_hdr));
> +
> +		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS)
> +			break;
> +	}
> +
> +	if (!voff) {
> +		dev_dbg(&pcidev->dev, "%s no VSEC found\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	dfl_cnt = 0;
> +	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT, &dfl_cnt);
I guess this could fall on it's face if you'd read back ~0 ... maybe
I'm being too paranoid :)
> +	dev_dbg(&pcidev->dev, "dfl_cnt %d\n", dfl_cnt);
> +	for (i = 0; i < dfl_cnt; i++) {
> +		dfl_res_off = voff + PCI_VNDR_DFLS_RES +
> +				      (i * sizeof(dfl_res));
> +		dfl_res = GENMASK(31, 0);
> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
> +
> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
> +
> +		bar = dfl_res & PCI_VNDR_DFLS_RES_BAR_MASK;
> +		if (bar >= PCI_STD_NUM_BARS) {
> +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
> +				__func__, bar);
> +			return -EINVAL;
> +		}
> +
> +		len = pci_resource_len(pcidev, bar);
> +		if (len == 0) {
> +			dev_err(&pcidev->dev, "%s unmapped bar number %d\n",
> +				__func__, bar);
> +			return -EINVAL;
> +		}
> +
> +		offset = dfl_res & PCI_VNDR_DFLS_RES_OFF_MASK;
> +		if (offset >= len) {
> +			dev_err(&pcidev->dev, "%s bad offset %u >= %pa\n",
> +				__func__, offset, &len);
> +			return -EINVAL;
> +		}
> +
> +		dev_dbg(&pcidev->dev, "%s BAR %d offset 0x%x\n", __func__, bar, offset);
> +
> +		len -= offset;
> +
> +		start = pci_resource_start(pcidev, bar) + offset;
> +
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
> +	}
> +
> +	return 0;
> +}
> +
>  static int find_dfls_by_default(struct pci_dev *pcidev,
> -				struct dfl_fpga_enum_info *info)
> +			       struct dfl_fpga_enum_info *info)
>  {
>  	resource_size_t start, len;
>  	int port_num, bar, i;
> @@ -220,7 +300,10 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  			goto irq_free_exit;
>  	}
>  
> -	ret = find_dfls_by_default(pcidev, info);
> +	ret = find_dfls_by_vsec(pcidev, info);
> +	if (ret == -ENODEV)
> +		ret = find_dfls_by_default(pcidev, info);
> +
>  	if (ret)
>  		goto irq_free_exit;
>  
> -- 
> 2.25.2
> 

Thanks,
Moritz
