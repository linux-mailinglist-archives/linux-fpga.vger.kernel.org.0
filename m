Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC5D2B702F
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Nov 2020 21:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgKQUf1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 15:35:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728329AbgKQUf1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 15:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605645325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vByS5kpz80AZKFxgvOpQGebYSL7WXU8v4XJYr3GtPus=;
        b=SKEtvZVDoPJNW87ca7XpMfvUiXKFIV69uXOlpJ9f9cNXIhUstgA0jVNZvQrKjI90qe8551
        JuGwxK3VCLnWQhJBtTROBRjMAUb5KuckyEzLdxRSgxW6/KsDAPCpinRYA0+jrLcJqcZSJm
        msIzmW/D3MHmKi0De+ujgnfBsvyuuTk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-Glh44fQXOkGmuAY4M5tcsA-1; Tue, 17 Nov 2020 15:35:24 -0500
X-MC-Unique: Glh44fQXOkGmuAY4M5tcsA-1
Received: by mail-qk1-f197.google.com with SMTP id s128so15065982qke.0
        for <linux-fpga@vger.kernel.org>; Tue, 17 Nov 2020 12:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vByS5kpz80AZKFxgvOpQGebYSL7WXU8v4XJYr3GtPus=;
        b=DdEBquCdejDUmsqXFfBgnkJqHrHctS15mtYkmsSS0z1ogaoI74fx5bvty1wzqXYAFN
         48mUIh7a/7fdREt41ywTDJQFys+V8kVu1Bh39eUtWcUMAVU0SkDeOMXtv6u3YmugE7wY
         5LUSTkQKNKGP5BMqHKip5Dpc38CvthCrI6a7dzkFdKPSap7ezs1IMDWpHBEj9g9NETJs
         Pd6ugBlYlkWzJZdvGy4SggeQLOPAKw9XpaGxsW6DcvGOO0Ch0ExsFjhxUUH/qAdmrXLC
         cn3bz+3jdjWtUknF87JUgg0oZianMxGXrndDmtE1h17Iqu0okVG1uNQWUSTwuSeH+8BU
         VhYg==
X-Gm-Message-State: AOAM532ar9nGBsVj0ydYBus05rVJHEtvGxX/4cde2IxMQRhBUOy9S3Mm
        aORjtgnjZXkb/WOkLzAHIRDTXNMRQti53SXITwtLXCOAMwH4WWkXo7qGMLePXBwk/1pKVTRozx0
        3ckST42aMmU9WQ9uH7/81Vw==
X-Received: by 2002:a37:9a43:: with SMTP id c64mr1499053qke.223.1605645322576;
        Tue, 17 Nov 2020 12:35:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVFW4odEPbASd6yXmPk9DUs3zSDbet8Mv70Ww7X01oVR3uetiTAQ28SO0aj8M6nWXlW01YGw==
X-Received: by 2002:a37:9a43:: with SMTP id c64mr1499028qke.223.1605645322308;
        Tue, 17 Nov 2020 12:35:22 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z16sm16139413qka.18.2020.11.17.12.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 12:35:21 -0800 (PST)
Subject: Re: [PATCH 2/2] fpga: dfl: look for vendor specific capability
To:     matthew.gerlach@linux.intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
 <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <53b9cb12-8002-5737-ba8b-7c59687ead5a@redhat.com>
Date:   Tue, 17 Nov 2020 12:35:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/16/20 5:25 PM, matthew.gerlach@linux.intel.com wrote:
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

Does the 'Device Feature List (DFL) Overview' section need to change ?

Maybe some more ascii art on location of bar0 vs vendor specific ?

>  Open discussion
>  ===============
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index b1b157b41942..5418e8bf2496 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -27,6 +27,13 @@
>  #define DRV_VERSION	"0.8"
Since basic pci functionality is changing, consider incrementing this version.
>  #define DRV_NAME	"dfl-pci"
>  
> +#define PCI_VNDR_ID_DFLS 0x43
> +
> +#define PCI_VNDR_DFLS_CNT_OFFSET 8
> +#define PCI_VNDR_DFLS_RES_OFFSET 0x0c
> +
> +#define PCI_VND_DFLS_RES_BAR_MASK 0x7
Is this missing a R? PCI_VNDR_DFLS_RES_BAR_MASK ?
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
extra nl
> +		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);

A general problem.

Return of pci_read is not checked, nor are the values ex/ vndr_hdr initialized.

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
> +	for (i = 0; i < dfl_cnt; i++) {
Is there a upper limit on the dfl_cnt ? maybe PCI_STD_NUM_BARS ?
> +		dfl_res_off = voff + PCI_VNDR_DFLS_RES_OFFSET +
> +				      (i * sizeof(dfl_res));
> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
> +
> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
> +
> +		bar = dfl_res & PCI_VND_DFLS_RES_BAR_MASK;
an extra nl, fix the similar ones as well.
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
> +
> +		if (offset >= len) {
> +			dev_err(&pcidev->dev, "%s bad offset %u >= %llu\n",
> +				__func__, offset, len);
> +			return -EINVAL;
> +		}
> +
> +		dev_info(&pcidev->dev, "%s BAR %d offset 0x%x\n", __func__, bar, offset);
> +
> +		start = pci_resource_start(pcidev, bar) + offset;
> +		len -= offset;
> +
> +		if (!PAGE_ALIGNED(start)) {
> +			dev_err(&pcidev->dev, "%s unaliged start 0x%llx\n",
> +				__func__, start);
> +			return -EINVAL;
> +		}
> +
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
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

Is this really an either/or ?

Could there be a base functionality on bar0 and a skew functionality on vendor bars?

If vendor is going to completely override, why not use bar0 ?

Tom

>  
>  	if (ret)
>  		goto irq_free_exit;

