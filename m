Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BEE19A4E3
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Apr 2020 07:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgDAFnw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 1 Apr 2020 01:43:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:58537 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731721AbgDAFnw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 1 Apr 2020 01:43:52 -0400
IronPort-SDR: 9r+UcJ2kPXLmleASsmHRRIr/lQpMe36ERG/8xfuAgqO2K50F+BGWPcQYcHcn6zxw2O7iEHJX1P
 tDY4PM3A4ujg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 22:43:51 -0700
IronPort-SDR: GcFnpFPDo6u6p+fqdxihNuEiWlnDv6OHcrnw8AT7V77kaondCJakSpbBfp35ZvJ3zMwrSwaeh9
 a0AS0tblAUpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; 
   d="scan'208";a="395832671"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2020 22:43:49 -0700
Date:   Wed, 1 Apr 2020 13:41:25 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v3 2/7] fpga: dfl: pci: add irq info for feature devices
  enumeration
Message-ID: <20200401054125.GB4618@yilunxu-OptiPlex-7050>
References: <1585038763-22944-1-git-send-email-yilun.xu@intel.com>
 <1585038763-22944-3-git-send-email-yilun.xu@intel.com>
 <20200331044120.GB8468@hao-dev>
 <20200401025902.GA4212@yilunxu-OptiPlex-7050>
 <20200401034430.GB28603@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401034430.GB28603@hao-dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Apr 01, 2020 at 11:44:30AM +0800, Wu Hao wrote:
> On Wed, Apr 01, 2020 at 10:59:02AM +0800, Xu Yilun wrote:
> > On Tue, Mar 31, 2020 at 12:41:20PM +0800, Wu Hao wrote:
> > > On Tue, Mar 24, 2020 at 04:32:38PM +0800, Xu Yilun wrote:
> > > > Some DFL FPGA PCIe cards (e.g. Intel FPGA Programmable Acceleration
> > > > Card) support MSI-X based interrupts. This patch allows PCIe driver
> > > > to prepare and pass interrupt resources to DFL via enumeration API.
> > > > These interrupt resources could then be assigned to actual features
> > > > which use them.
> > > > 
> > > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > ----
> > > > v2: put irq resources init code inside cce_enumerate_feature_dev()
> > > >     Some minor changes for Hao's comments.
> > > > v3: Some minor fix for Hao's comments for v2.
> > > > ---
> > > >  drivers/fpga/dfl-pci.c | 76 ++++++++++++++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 67 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > > index 5387550..66027aa 100644
> > > > --- a/drivers/fpga/dfl-pci.c
> > > > +++ b/drivers/fpga/dfl-pci.c
> > > > @@ -39,6 +39,28 @@ static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
> > > >  	return pcim_iomap_table(pcidev)[bar];
> > > >  }
> > > >  
> > > > +static int cci_pci_alloc_irq(struct pci_dev *pcidev)
> > > > +{
> > > > +	int nvec = pci_msix_vec_count(pcidev);
> > > > +	int ret;
> > > 
> > > maybe int ret, nvec = pci_msix..
> > > 
> > > > +
> > > > +	if (nvec <= 0) {
> > > > +		dev_dbg(&pcidev->dev, "fpga interrupt not supported\n");
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	ret = pci_alloc_irq_vectors(pcidev, nvec, nvec, PCI_IRQ_MSIX);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return nvec;
> > > > +}
> > > > +
> > > > +static void cci_pci_free_irq(struct pci_dev *pcidev)
> > > > +{
> > > > +	pci_free_irq_vectors(pcidev);
> > > > +}
> > > > +
> > > >  /* PCI Device ID */
> > > >  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
> > > >  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
> > > > @@ -78,17 +100,33 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
> > > >  
> > > >  	/* remove all children feature devices */
> > > >  	dfl_fpga_feature_devs_remove(drvdata->cdev);
> > > > +	cci_pci_free_irq(pcidev);
> > > > +}
> > > > +
> > > > +static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
> > > > +{
> > > > +	unsigned int i;
> > > > +	int *table;
> > > > +
> > > > +	table = kcalloc(nvec, sizeof(int), GFP_KERNEL);
> > > > +	if (table) {
> > > > +		for (i = 0; i < nvec; i++)
> > > > +			table[i] = pci_irq_vector(pcidev, i);
> > > > +	}
> > > > +
> > > > +	return table;
> > > >  }
> > > >  
> > > >  /* enumerate feature devices under pci device */
> > > >  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> > > >  {
> > > >  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> > > > +	int port_num, bar, i, nvec, ret = 0;
> > > >  	struct dfl_fpga_enum_info *info;
> > > >  	struct dfl_fpga_cdev *cdev;
> > > >  	resource_size_t start, len;
> > > > -	int port_num, bar, i, ret = 0;
> > > >  	void __iomem *base;
> > > > +	int *irq_table;
> > > >  	u32 offset;
> > > >  	u64 v;
> > > >  
> > > > @@ -97,11 +135,30 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> > > >  	if (!info)
> > > >  		return -ENOMEM;
> > > >  
> > > > +	/* add irq info for enumeration if the device support irq */
> > > > +	nvec = cci_pci_alloc_irq(pcidev);
> > > > +	if (nvec < 0) {
> > > > +		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
> > > > +		ret = nvec;
> > > > +		goto enum_info_free_exit;
> > > > +	} else if (nvec) {
> > > > +		irq_table = cci_pci_create_irq_table(pcidev, nvec);
> > > > +		if (!irq_table) {
> > > > +			ret = -ENOMEM;
> > > > +			goto irq_free_exit;
> > > > +		}
> > > > +
> > > > +		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> > > > +		kfree(irq_table);
> > > 
> > > i see you create a function for cci_pci_free_irq instead of using kernel api
> > > directly, to make it more readable, so why not have a remove irq table function
> > > here too.
> > 
> > The irq_table is not alloced in cci_pci_alloc_irq,
> > cci_pci_create_irq_table does. Actually cci_pci_alloc/free_irq are not
> > related to irq_table for DFL.
> > 
> > So maybe we don't have to change this?
> 
> I mean, you have cci_pci_alloc/free_irq but cci_pci_create_irq_table/kfree.
> why don't you use cci_pci_remove_irq_table or something instead of kfree?

Sorry for my misunderstanding. I can make this change. Thanks.

> 
> Hao
> 
> > 
> > > 
> > > Actually patch looks good to me, with above minor fixes.
> > > 
> > > Acked-by: Wu Hao <hao.wu@intel.com>
> > > 
> > > Hao
> > > 
> > > > +		if (ret)
> > > > +			goto irq_free_exit;
> > > > +	}
> > > > +
> > > >  	/* start to find Device Feature List from Bar 0 */
> > > >  	base = cci_pci_ioremap_bar(pcidev, 0);
> > > >  	if (!base) {
> > > >  		ret = -ENOMEM;
> > > > -		goto enum_info_free_exit;
> > > > +		goto irq_free_exit;
> > > >  	}
> > > >  
> > > >  	/*
> > > > @@ -154,7 +211,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> > > >  		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> > > >  	} else {
> > > >  		ret = -ENODEV;
> > > > -		goto enum_info_free_exit;
> > > > +		goto irq_free_exit;
> > > >  	}
> > > >  
> > > >  	/* start enumeration with prepared enumeration information */
> > > > @@ -162,11 +219,14 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> > > >  	if (IS_ERR(cdev)) {
> > > >  		dev_err(&pcidev->dev, "Enumeration failure\n");
> > > >  		ret = PTR_ERR(cdev);
> > > > -		goto enum_info_free_exit;
> > > > +		goto irq_free_exit;
> > > >  	}
> > > >  
> > > >  	drvdata->cdev = cdev;
> > > >  
> > > > +irq_free_exit:
> > > > +	if (ret)
> > > > +		cci_pci_free_irq(pcidev);
> > > >  enum_info_free_exit:
> > > >  	dfl_fpga_enum_info_free(info);
> > > >  
> > > > @@ -211,12 +271,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> > > >  	}
> > > >  
> > > >  	ret = cci_enumerate_feature_devs(pcidev);
> > > > -	if (ret) {
> > > > -		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> > > > -		goto disable_error_report_exit;
> > > > -	}
> > > > +	if (!ret)
> > > > +		return ret;
> > > >  
> > > > -	return ret;
> > > > +	dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> > > >  
> > > >  disable_error_report_exit:
> > > >  	pci_disable_pcie_error_reporting(pcidev);
> > > > -- 
> > > > 2.7.4
