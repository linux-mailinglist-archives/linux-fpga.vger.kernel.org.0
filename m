Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9437617F3EA
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Mar 2020 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJJnt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Mar 2020 05:43:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:49543 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJnt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 10 Mar 2020 05:43:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 02:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,536,1574150400"; 
   d="scan'208";a="231264562"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2020 02:43:46 -0700
Date:   Tue, 10 Mar 2020 17:41:43 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH 2/7] fpga: dfl: pci: add irq info for feature devices
  enumeration
Message-ID: <20200310094143.GB30868@yilunxu-OptiPlex-7050>
References: <1583749790-10837-1-git-send-email-yilun.xu@intel.com>
 <1583749790-10837-3-git-send-email-yilun.xu@intel.com>
 <20200310024626.GB11861@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310024626.GB11861@hao-dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 10, 2020 at 10:46:26AM +0800, Wu Hao wrote:
> Hi Yilun
> 
> Some comments inline. : )
> 
> On Mon, Mar 09, 2020 at 06:29:45PM +0800, Xu Yilun wrote:
> > Some DFL FPGA PCIe cards (e.g. Intel FPGA Programmable Acceleration
> > Card) support MSI-X based interrupts. This patch allows PCIe driver
> > to prepare and pass interrupt resources to DFL via enumeration API.
> > These interrupt resources could then be assigned to actual features
> > which use them.
> > 
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 61 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index 5387550..a3370e5 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -80,8 +80,23 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
> >  	dfl_fpga_feature_devs_remove(drvdata->cdev);
> >  }
> >  
> > +static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
> > +{
> > +	int *table, i;
> > +
> > +	table = kcalloc(nvec, sizeof(int), GFP_KERNEL);
> 
> Maybe devm_ version is better?

This table will be freed right after dfl_fpga_enum_info_add_irq(). Maybe
don't need devm_ version.

> 
> > +	if (!table)
> > +		return NULL;
> > +
> > +	for (i = 0; i < nvec; i++)
> 
> i should be unsigned int as well?

Yes I should change it.

> 
> > +		table[i] = pci_irq_vector(pcidev, i);
> > +
> > +	return table;
> > +}
> > +
> >  /* enumerate feature devices under pci device */
> > -static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> > +static int cci_enumerate_feature_devs(struct pci_dev *pcidev,
> > +				      unsigned int nvec)
> >  {
> >  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> >  	struct dfl_fpga_enum_info *info;
> > @@ -89,6 +104,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  	resource_size_t start, len;
> >  	int port_num, bar, i, ret = 0;
> >  	void __iomem *base;
> > +	int *irq_table;
> >  	u32 offset;
> >  	u64 v;
> >  
> > @@ -97,6 +113,18 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  	if (!info)
> >  		return -ENOMEM;
> >  
> > +	/* add irq info for enumeration if really needed */
> > +	if (nvec) {
> > +		irq_table = cci_pci_create_irq_table(pcidev, nvec);
> > +		if (irq_table) {
> > +			dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> > +			kfree(irq_table);
> > +		} else {
> > +			ret = -ENOMEM;
> > +			goto enum_info_free_exit;
> > +		}
> > +	}
> > +
> >  	/* start to find Device Feature List from Bar 0 */
> >  	base = cci_pci_ioremap_bar(pcidev, 0);
> >  	if (!base) {
> > @@ -173,6 +201,28 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  	return ret;
> >  }
> >  
> > +static int cci_pci_alloc_irq(struct pci_dev *pcidev)
> > +{
> > +	int nvec = pci_msix_vec_count(pcidev);
> > +	int ret;
> > +
> > +	if (nvec <= 0) {
> > +		dev_dbg(&pcidev->dev, "fpga interrupt not supported\n");
> > +		return 0;
> > +	}
> > +
> > +	ret = pci_alloc_irq_vectors(pcidev, nvec, nvec, PCI_IRQ_MSIX);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return nvec;
> > +}
> > +
> > +static void cci_pci_free_irq(struct pci_dev *pcidev)
> > +{
> > +	pci_free_irq_vectors(pcidev);
> > +}
> > +
> >  static
> >  int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> >  {
> > @@ -210,14 +260,19 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> >  		goto disable_error_report_exit;
> >  	}
> >  
> > -	ret = cci_enumerate_feature_devs(pcidev);
> > -	if (ret) {
> > -		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> > +	ret = cci_pci_alloc_irq(pcidev);
> > +	if (ret < 0) {
> > +		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", ret);
> 
> we prepare mmio resources in side cci_enumerate_feature_devs.
> 
> maybe we could put irq resources code in side cce_enumerate_feature_devs too?

Yes I will try to change it in patch v2.

Thanks for your quick response.

> 
> 
> Thanks
> Hao
> 
> >  		goto disable_error_report_exit;
> >  	}
> >  
> > -	return ret;
> > +	ret = cci_enumerate_feature_devs(pcidev, (unsigned int)ret);
> > +	if (!ret)
> > +		return ret;
> > +
> > +	dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> >  
> > +	cci_pci_free_irq(pcidev);
> >  disable_error_report_exit:
> >  	pci_disable_pcie_error_reporting(pcidev);
> >  	return ret;
> > @@ -263,6 +318,7 @@ static void cci_pci_remove(struct pci_dev *pcidev)
> >  		cci_pci_sriov_configure(pcidev, 0);
> >  
> >  	cci_remove_feature_devs(pcidev);
> > +	cci_pci_free_irq(pcidev);
> >  	pci_disable_pcie_error_reporting(pcidev);
> >  }
> >  
> > -- 
> > 2.7.4
