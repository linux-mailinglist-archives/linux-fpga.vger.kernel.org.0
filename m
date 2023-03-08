Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2186AFD71
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Mar 2023 04:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCHDcX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Mar 2023 22:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCHDcW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Mar 2023 22:32:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015CA5B5D5;
        Tue,  7 Mar 2023 19:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678246340; x=1709782340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jBsAnFm+Ma7M1DI6zr3HskpDarLdNlJ+SxBINm9NwgE=;
  b=gOHzbSipsvIRrmAJUrJtjk53RWtyPG6P5GM8lhq/tkhx23zRPkEYa6Dy
   5ENIuJ645C9YXMxl44fWT+00FfDJeZfGZ7iCqV63TYCn+6q4m6Gfp9pGE
   SL1eI7LKE/Eyz3DVVTTM1oAqTe7XUxPtDXqge4ESRp0d7Uf1AqDfuCtMH
   5mu1zW/nMsrrFBDKVS4nu7MYi33YVbCmGingbZc0kV8MP/OGDX388KawM
   bn/iTtuTAljJAYL4gqsZARKZGwPzPFdicJ7AI2pX8TPnRfgfxKlO4+Wkc
   ewcY3AXOZFwU8uJiNM83Z7ViM1qc7Ht+c0F6UFF2WkQHaqoXzNUSvFB8W
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="363680825"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="363680825"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 19:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626762760"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="626762760"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2023 19:32:18 -0800
Date:   Wed, 8 Mar 2023 11:21:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] fpga: dfl-pci: Drop redundant
 pci_enable_pcie_error_reporting()
Message-ID: <ZAf/Isgkh6GoApp4@yilunxu-OptiPlex-7050>
References: <20230307201937.880084-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307201937.880084-1-helgaas@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-07 at 14:19:37 -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), the PCI core does this for all devices during enumeration, so the
> driver doesn't need to do it itself.
> 
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> from the driver .remove() path.
> 
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on the
> AER Root Error Command register managed by the AER service driver.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

I see f26e58bf6f54 in v6.2, so I think it's OK to apply to for-6.3

Thanks,
Yilun

> ---
>  drivers/fpga/dfl-pci.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 0914e7328b1a..1bc04378118c 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -21,7 +21,6 @@
>  #include <linux/module.h>
>  #include <linux/stddef.h>
>  #include <linux/errno.h>
> -#include <linux/aer.h>
>  
>  #include "dfl.h"
>  
> @@ -376,10 +375,6 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>  		return ret;
>  	}
>  
> -	ret = pci_enable_pcie_error_reporting(pcidev);
> -	if (ret && ret != -EINVAL)
> -		dev_info(&pcidev->dev, "PCIE AER unavailable %d.\n", ret);
> -
>  	pci_set_master(pcidev);
>  
>  	ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
> @@ -387,24 +382,22 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>  		ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
>  	if (ret) {
>  		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> -		goto disable_error_report_exit;
> +		return ret;
>  	}
>  
>  	ret = cci_init_drvdata(pcidev);
>  	if (ret) {
>  		dev_err(&pcidev->dev, "Fail to init drvdata %d.\n", ret);
> -		goto disable_error_report_exit;
> +		return ret;
>  	}
>  
>  	ret = cci_enumerate_feature_devs(pcidev);
> -	if (!ret)
> +	if (ret) {
> +		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
>  		return ret;
> +	}
>  
> -	dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> -
> -disable_error_report_exit:
> -	pci_disable_pcie_error_reporting(pcidev);
> -	return ret;
> +	return 0;
>  }
>  
>  static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> @@ -448,7 +441,6 @@ static void cci_pci_remove(struct pci_dev *pcidev)
>  		cci_pci_sriov_configure(pcidev, 0);
>  
>  	cci_remove_feature_devs(pcidev);
> -	pci_disable_pcie_error_reporting(pcidev);
>  }
>  
>  static struct pci_driver cci_pci_driver = {
> -- 
> 2.25.1
> 
