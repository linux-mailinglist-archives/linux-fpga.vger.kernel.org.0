Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0816948
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2019 19:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfEGRfD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 May 2019 13:35:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34376 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfEGRfD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 May 2019 13:35:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck18so8531570plb.1
        for <linux-fpga@vger.kernel.org>; Tue, 07 May 2019 10:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nR0aBKJfoopZPS6ewbt3+ta+1QzOCPH60SuweQRd3Y=;
        b=o48sZw1St3VOdezxq/l67uQh+pciiCNvnGkmH9BTwPAyX6ZneSDypX2/l5PkqDO4wq
         KL/f5Mcqy567v45gYnAlzSCCq3WpRrwU2wnLGUfBMETiMtolmPHC2FaeGrQO+8dNKk88
         +8RmUj/30dn9GHPV3cx1MK+jLvP+a/gVrV/+wfw/Z0EHKQ8AeoIDthIY62WXqsMfBJZp
         bvbiGPnAaut8zQ4My9rwQtwPO3VwLcR8SADXPzbcI/2RA24O8dXZlgwBvUuJ9T6/3+RN
         edZLIW4QZLz7Ji1CX0bcX+iVcH+bigZ5G9F7bpkcSdudRygcl3J5EW6wrB8m59bqIVfW
         YFcg==
X-Gm-Message-State: APjAAAWpR65x5AseAC9eaMUTDcAjIz1Jx+PbiXfIME5ixjy0x3RuwxPQ
        l0njrS/4x6Ss2jMCpJlLQtp6LA==
X-Google-Smtp-Source: APXvYqyA2RTx+hWbofW4Twpnmba6QN/uD0h5Fwuc26nA0nUrnqArxgPKPaiMdotoAMxTrGMgEdjfkw==
X-Received: by 2002:a17:902:a614:: with SMTP id u20mr41499062plq.117.1557250501946;
        Tue, 07 May 2019 10:35:01 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id d4sm6008914pgt.14.2019.05.07.10.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:35:01 -0700 (PDT)
Date:   Tue, 7 May 2019 10:35:00 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 07/18] fpga: dfl: pci: enable SRIOV support.
Message-ID: <20190507173500.GD26690@archbox>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-8-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556528151-17221-8-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 29, 2019 at 04:55:40PM +0800, Wu Hao wrote:
> This patch enables the standard sriov support. It allows user to
> enable SRIOV (and VFs), then user could pass through accelerators
> (VFs) into virtual machine or use VFs directly in host.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h     |  1 +
>  3 files changed, 82 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 66b5720..2fa571b 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -223,8 +223,46 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>  	return ret;
>  }
>  
> +static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> +{
> +	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> +	struct dfl_fpga_cdev *cdev = drvdata->cdev;
> +	int ret = 0;
> +
> +	mutex_lock(&cdev->lock);
> +
> +	if (!num_vfs) {
> +		/*
> +		 * disable SRIOV and then put released ports back to default
> +		 * PF access mode.
> +		 */
> +		pci_disable_sriov(pcidev);
> +
> +		__dfl_fpga_cdev_config_port_vf(cdev, false);
> +
> +	} else if (cdev->released_port_num == num_vfs) {
> +		/*
> +		 * only enable SRIOV if cdev has matched released ports, put
> +		 * released ports into VF access mode firstly.
> +		 */
> +		__dfl_fpga_cdev_config_port_vf(cdev, true);
> +
> +		ret = pci_enable_sriov(pcidev, num_vfs);
> +		if (ret)
> +			__dfl_fpga_cdev_config_port_vf(cdev, false);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&cdev->lock);
> +	return ret;
> +}
> +
>  static void cci_pci_remove(struct pci_dev *pcidev)
>  {
> +	if (dev_is_pf(&pcidev->dev))
> +		cci_pci_sriov_configure(pcidev, 0);
> +
>  	cci_remove_feature_devs(pcidev);
>  	pci_disable_pcie_error_reporting(pcidev);
>  }
> @@ -234,6 +272,7 @@ static void cci_pci_remove(struct pci_dev *pcidev)
>  	.id_table = cci_pcie_id_tbl,
>  	.probe = cci_pci_probe,
>  	.remove = cci_pci_remove,
> +	.sriov_configure = cci_pci_sriov_configure,
>  };
>  
>  module_pci_driver(cci_pci_driver);
> @@ -241,3 +280,4 @@ static void cci_pci_remove(struct pci_dev *pcidev)
>  MODULE_DESCRIPTION("FPGA DFL PCIe Device Driver");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL v2");
> +MODULE_VERSION(DRV_VERSION);
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index a6b6d38..c5aa287 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1098,6 +1098,47 @@ int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev,
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_port);
>  
> +static void config_port_vf(struct device *fme_dev, int port_id, bool is_vf)
> +{
> +	void __iomem *base;
> +	u64 v;
> +
> +	base = dfl_get_feature_ioaddr_by_id(fme_dev, FME_FEATURE_ID_HEADER);
> +
> +	v = readq(base + FME_HDR_PORT_OFST(port_id));
> +
> +	v &= ~FME_PORT_OFST_ACC_CTRL;
> +	v |= FIELD_PREP(FME_PORT_OFST_ACC_CTRL,
> +			is_vf ? FME_PORT_OFST_ACC_VF : FME_PORT_OFST_ACC_PF);
> +
> +	writeq(v, base + FME_HDR_PORT_OFST(port_id));
> +}
> +
> +/**
> + * __dfl_fpga_cdev_config_port_vf - configure port to VF access mode
> + *
> + * @cdev: parent container device.
> + * @if_vf: true for VF access mode, and false for PF access mode
> + *
> + * Return: 0 on success, negative error code otherwise.
> + *
> + * This function is needed in sriov configuration routine. It could be used to
> + * configures the released ports access mode to VF or PF.
> + * The caller needs to hold lock for protection.
> + */
> +void __dfl_fpga_cdev_config_port_vf(struct dfl_fpga_cdev *cdev, bool is_vf)
> +{
> +	struct dfl_feature_platform_data *pdata;
> +
> +	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> +		if (device_is_registered(&pdata->dev->dev))
> +			continue;
> +
> +		config_port_vf(cdev->fme_dev, pdata->id, is_vf);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_config_port_vf);
> +
>  static int __init dfl_fpga_init(void)
>  {
>  	int ret;
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 63f39ab..1350e8e 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -421,5 +421,6 @@ struct platform_device *
>  
>  int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev,
>  			      u32 port_id, bool release);
> +void __dfl_fpga_cdev_config_port_vf(struct dfl_fpga_cdev *cdev, bool is_vf);
>  
>  #endif /* __FPGA_DFL_H */
> -- 
> 1.8.3.1
> 
