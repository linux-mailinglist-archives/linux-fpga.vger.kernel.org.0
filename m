Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E3820C9F8
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Jun 2020 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgF1Tr0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Jun 2020 15:47:26 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43043 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgF1Tr0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 28 Jun 2020 15:47:26 -0400
Received: by mail-il1-f195.google.com with SMTP id i18so12711527ilk.10;
        Sun, 28 Jun 2020 12:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjaX49kA+x/+H+Kl/rtFW+QwGHknkedl+8njsYyAMOM=;
        b=dTojvv1EpnG6MqDZODGosds3SrbPuCj3H/ky2hJxOcH3x2pIxhbCr3g7aRmbZ2nkUy
         mVMJvA7rJ8EBbmbruK2HPwMkLvG56Bzsrg4G1+ULKtL5PJ0JfdGDOw3bHFaF9BLub/f5
         ezRxsQmIp4FtZrIod7yOMIacQ4D55Ol5psn3U9BBTnLtRZqo1v8Bc2i5JOxD+d5nYkJB
         9hNMlMM6Lw5pxNAlo/3BX2m3PLMiMo54tz9gft0fR6IEeNN94A955D5hFHhWGlKvrOU1
         lyFZgU7AAN/mpF+ndcAU+MklsOoGvnWetLSjymUvTisixT3vaMA8K0uGifb/oFyLd+Jq
         SoSQ==
X-Gm-Message-State: AOAM532HNoRvOyq7KPcvGxyV3A0YTZ88ByUjLAKyQQ7zEo3BLjZ6pjxN
        FFUPAgh4opkSZV4D7EA2VaJRj8EeA/Q=
X-Google-Smtp-Source: ABdhPJxxFxKF/1beOxmots1fqPIat6QBpBNFDiwFVSeJgNpgWMuyHHR6x99I9qlW2dt0HqeWKDCimA==
X-Received: by 2002:a92:a04e:: with SMTP id b14mr13365721ilm.261.1593373644694;
        Sun, 28 Jun 2020 12:47:24 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q15sm12941147ilt.60.2020.06.28.12.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 12:47:24 -0700 (PDT)
Date:   Sun, 28 Jun 2020 12:47:23 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        mtosatti@redhat.com, gregkh@linuxfoundation.org,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v7 2/7] fpga: dfl: pci: add irq info for feature devices
 enumeration
Message-ID: <20200628194723.GB2469@epycbox.lan>
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <1592280528-6350-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592280528-6350-3-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 16, 2020 at 12:08:43PM +0800, Xu Yilun wrote:
> Some DFL FPGA PCIe cards (e.g. Intel FPGA Programmable Acceleration
> Card) support MSI-X based interrupts. This patch allows PCIe driver
> to prepare and pass interrupt resources to DFL via enumeration API.
> These interrupt resources could then be assigned to actual features
> which use them.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: put irq resources init code inside cce_enumerate_feature_dev()
>     Some minor changes for Hao's comments.
> v3: Some minor fix for Hao's comments for v2.
> v4: Some minor fix for Hao's comments for v3.
> v5: No change.
> v6: Some minor fix for Moritz's comments.
> v7: remove cci_pci_free_irq_table(), just use kfree().
> ---
>  drivers/fpga/dfl-pci.c | 76 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 5387550..4a14a24 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -39,6 +39,27 @@ static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
>  	return pcim_iomap_table(pcidev)[bar];
>  }
>  
> +static int cci_pci_alloc_irq(struct pci_dev *pcidev)
> +{
> +	int ret, nvec = pci_msix_vec_count(pcidev);
> +
> +	if (nvec <= 0) {
> +		dev_dbg(&pcidev->dev, "fpga interrupt not supported\n");
> +		return 0;
> +	}
> +
> +	ret = pci_alloc_irq_vectors(pcidev, nvec, nvec, PCI_IRQ_MSIX);
> +	if (ret < 0)
> +		return ret;
> +
> +	return nvec;
> +}
> +
> +static void cci_pci_free_irq(struct pci_dev *pcidev)
> +{
> +	pci_free_irq_vectors(pcidev);
> +}
> +
>  /* PCI Device ID */
>  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
> @@ -78,17 +99,34 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
>  
>  	/* remove all children feature devices */
>  	dfl_fpga_feature_devs_remove(drvdata->cdev);
> +	cci_pci_free_irq(pcidev);
> +}
> +
> +static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
> +{
> +	unsigned int i;
> +	int *table;
> +
> +	table = kcalloc(nvec, sizeof(int), GFP_KERNEL);
> +	if (!table)
> +		return table;
> +
> +	for (i = 0; i < nvec; i++)
> +		table[i] = pci_irq_vector(pcidev, i);
> +
> +	return table;
>  }
>  
>  /* enumerate feature devices under pci device */
>  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  {
>  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> +	int port_num, bar, i, nvec, ret = 0;
>  	struct dfl_fpga_enum_info *info;
>  	struct dfl_fpga_cdev *cdev;
>  	resource_size_t start, len;
> -	int port_num, bar, i, ret = 0;
>  	void __iomem *base;
> +	int *irq_table;
>  	u32 offset;
>  	u64 v;
>  
> @@ -97,11 +135,30 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  	if (!info)
>  		return -ENOMEM;
>  
> +	/* add irq info for enumeration if the device support irq */
> +	nvec = cci_pci_alloc_irq(pcidev);
> +	if (nvec < 0) {
> +		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
> +		ret = nvec;
> +		goto enum_info_free_exit;
> +	} else if (nvec) {
> +		irq_table = cci_pci_create_irq_table(pcidev, nvec);
> +		if (!irq_table) {
> +			ret = -ENOMEM;
> +			goto irq_free_exit;
> +		}
> +
> +		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> +		kfree(irq_table);
> +		if (ret)
> +			goto irq_free_exit;
> +	}
> +
>  	/* start to find Device Feature List from Bar 0 */
>  	base = cci_pci_ioremap_bar(pcidev, 0);
>  	if (!base) {
>  		ret = -ENOMEM;
> -		goto enum_info_free_exit;
> +		goto irq_free_exit;
>  	}
>  
>  	/*
> @@ -154,7 +211,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  		dfl_fpga_enum_info_add_dfl(info, start, len, base);
>  	} else {
>  		ret = -ENODEV;
> -		goto enum_info_free_exit;
> +		goto irq_free_exit;
>  	}
>  
>  	/* start enumeration with prepared enumeration information */
> @@ -162,11 +219,14 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  	if (IS_ERR(cdev)) {
>  		dev_err(&pcidev->dev, "Enumeration failure\n");
>  		ret = PTR_ERR(cdev);
> -		goto enum_info_free_exit;
> +		goto irq_free_exit;
>  	}
>  
>  	drvdata->cdev = cdev;
>  
> +irq_free_exit:
> +	if (ret)
> +		cci_pci_free_irq(pcidev);
>  enum_info_free_exit:
>  	dfl_fpga_enum_info_free(info);
>  
> @@ -211,12 +271,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>  	}
>  
>  	ret = cci_enumerate_feature_devs(pcidev);
> -	if (ret) {
> -		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> -		goto disable_error_report_exit;
> -	}
> +	if (!ret)
> +		return ret;
>  
> -	return ret;
> +	dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
>  
>  disable_error_report_exit:
>  	pci_disable_pcie_error_reporting(pcidev);
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks!
