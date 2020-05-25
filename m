Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75D51E14D2
	for <lists+linux-fpga@lfdr.de>; Mon, 25 May 2020 21:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbgEYThz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 May 2020 15:37:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390070AbgEYThy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 May 2020 15:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590435473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJJ94T5U0nF5zDOdHPSu7XgYfIG/RMOB3z2gAmLQyQ4=;
        b=UNgrNcP53Er8bYwU81bLk+vFB4aSqV0GRVmYIF2Mvh9Hw6WQJAUjFtcqRCwTf9hJs0Skcn
        Z74+y5J+1d0UXpjsf6D8uipaXbnM5sQ1qObgbvGXtOUHda+dfOyXbWU9dfGEHvY7DNXR8q
        zVlOPrk67f+wWKwTarVc7UMVofPls9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-zgp5rzVLO0ei3XSVomTbmg-1; Mon, 25 May 2020 15:37:51 -0400
X-MC-Unique: zgp5rzVLO0ei3XSVomTbmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A6698015D2;
        Mon, 25 May 2020 19:37:50 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-16.gru2.redhat.com [10.97.116.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A93375C1BB;
        Mon, 25 May 2020 19:37:49 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E51DA416CE4A; Mon, 25 May 2020 16:21:23 -0300 (-03)
Date:   Mon, 25 May 2020 16:21:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v5 2/7] fpga: dfl: pci: add irq info for feature devices
 enumeration
Message-ID: <20200525192123.GB22266@fuller.cnet>
References: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
 <1587370303-25568-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587370303-25568-3-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 20, 2020 at 04:11:38PM +0800, Xu Yilun wrote:
> Some DFL FPGA PCIe cards (e.g. Intel FPGA Programmable Acceleration
> Card) support MSI-X based interrupts. This patch allows PCIe driver
> to prepare and pass interrupt resources to DFL via enumeration API.
> These interrupt resources could then be assigned to actual features
> which use them.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ----
> v2: put irq resources init code inside cce_enumerate_feature_dev()
>     Some minor changes for Hao's comments.
> v3: Some minor fix for Hao's comments for v2.
> v4: Some minor fix for Hao's comments for v3.
> v5: No change.
> ---
>  drivers/fpga/dfl-pci.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index a78c409..2ff1274 100644
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
> @@ -78,17 +99,38 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
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
> +	if (table) {
> +		for (i = 0; i < nvec; i++)
> +			table[i] = pci_irq_vector(pcidev, i);
> +	}
> +
> +	return table;
> +}
> +
> +static void cci_pci_free_irq_table(int *table)
> +{
> +	kfree(table);
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
> @@ -97,11 +139,30 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
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
> +		cci_pci_free_irq_table(irq_table);
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
> @@ -154,7 +215,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  		dfl_fpga_enum_info_add_dfl(info, start, len, base);
>  	} else {
>  		ret = -ENODEV;
> -		goto enum_info_free_exit;
> +		goto irq_free_exit;
>  	}
>  
>  	/* start enumeration with prepared enumeration information */
> @@ -162,11 +223,14 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
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
> @@ -211,12 +275,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
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


Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

